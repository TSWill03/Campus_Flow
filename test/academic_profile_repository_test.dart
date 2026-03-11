import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campus_flow/core/database/app_database.dart';
import 'package:campus_flow/core/sync/sync_queue_service.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/academic_profile/data/repositories/drift_academic_profile_repository.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/academic_profile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DriftAcademicProfileRepository', () {
    late AppDatabase database;
    late SyncQueueService syncQueueService;
    late DriftAcademicProfileRepository repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      database = AppDatabase(executor: NativeDatabase.memory());
      syncQueueService = SyncQueueService(
        database: database,
        sharedPreferences: preferences,
      );
      repository = DriftAcademicProfileRepository(database, syncQueueService);
    });

    tearDown(() async {
      await database.close();
    });

    test('keeps a single active profile and enqueues outbox entries', () async {
      final firstProfile = _buildProfile(
        id: 'profile-1',
        updatedAt: DateTime(2026, 3, 11, 8),
        isActive: true,
      );
      final secondProfile = _buildProfile(
        id: 'profile-2',
        profileName: 'USP Mestrado',
        courseName: 'Computacao Aplicada',
        institution: 'USP',
        updatedAt: DateTime(2026, 3, 11, 9),
        isActive: true,
      );

      await repository.saveProfile(firstProfile);
      await repository.saveProfile(secondProfile);

      final activeProfile = await repository.getActiveProfile();
      final profiles = await repository.getAllProfiles();
      final queueEntries = await database.select(database.syncQueueEntries).get();

      expect(activeProfile?.id, secondProfile.id);
      expect(profiles.where((profile) => profile.isActive), hasLength(1));
      expect(
        profiles.firstWhere((profile) => profile.id == firstProfile.id).isActive,
        isFalse,
      );
      expect(queueEntries, hasLength(2));
      expect(queueEntries.every((entry) => entry.operation == 'upsert'), isTrue);
      expect(queueEntries.every((entry) => entry.entityVersion > 0), isTrue);
    });
  });
}

AcademicProfile _buildProfile({
  required String id,
  String profileName = 'UFRJ Graduacao',
  String courseName = 'Engenharia',
  String institution = 'UFRJ',
  required DateTime updatedAt,
  bool isActive = false,
}) {
  return AcademicProfile(
    id: id,
    createdAt: updatedAt.subtract(const Duration(days: 30)),
    updatedAt: updatedAt,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    profileName: profileName,
    courseName: courseName,
    institution: institution,
    schoolName: 'Escola Politecnica',
    campus: 'Cidade Universitaria',
    degreeLabel: 'Graduacao',
    isActive: isActive,
    totalCourseHours: 3600,
    semesterCount: 10,
    requiredComplementaryHours: 200,
    requiredInternshipHours: 300,
    requiredExtensionHours: 120,
  );
}
