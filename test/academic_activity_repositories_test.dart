// Signature: dev.tswicolly03

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/complementary_hours/data/repositories/drift_complementary_activity_repository.dart';
import 'package:campus_flow/features/complementary_hours/domain/entities/complementary_activity.dart';
import 'package:campus_flow/features/extension_activities/data/repositories/drift_extension_activity_repository.dart';
import 'package:campus_flow/features/extension_activities/domain/entities/extension_activity.dart';
import 'package:campus_flow/features/internships/data/repositories/drift_internship_repository.dart';
import 'package:campus_flow/features/internships/domain/entities/internship_record.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

import 'test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Academic activity repositories', () {
    late RepositoryTestHarness harness;

    setUp(() async {
      harness = await createRepositoryTestHarness();
      await harness.insertAcademicProfile(id: 'profile-1');
      await harness.insertAcademicProfile(
        id: 'profile-2',
        profileName: 'Segundo perfil',
      );
    });

    tearDown(() async {
      await harness.close();
    });

    test('saves and deletes complementary activities by profile', () async {
      final repository = DriftComplementaryActivityRepository(
        harness.database,
        harness.syncQueueService,
      );

      await repository.saveActivity(_complementary(id: 'comp-1'));
      await repository.saveActivity(
        _complementary(id: 'comp-2', academicProfileId: 'profile-2'),
      );

      expect(
        await repository.getAllActivities(academicProfileId: 'profile-1'),
        hasLength(1),
      );

      await repository.deleteActivity('comp-1');
      final queueById = {
        for (final entry in await harness.queueEntries()) entry.id: entry,
      };

      expect(
        await repository.getAllActivities(academicProfileId: 'profile-1'),
        isEmpty,
      );
      expect(queueById['complementary_activity::comp-1']?.operation, 'delete');
    });

    test('saves and deletes internships by profile', () async {
      final repository = DriftInternshipRepository(
        harness.database,
        harness.syncQueueService,
      );

      await repository.saveInternship(_internship(id: 'internship-1'));
      await repository.saveInternship(
        _internship(id: 'internship-2', academicProfileId: 'profile-2'),
      );

      expect(
        await repository.getAllInternships(academicProfileId: 'profile-1'),
        hasLength(1),
      );

      await repository.deleteInternship('internship-1');
      final queueById = {
        for (final entry in await harness.queueEntries()) entry.id: entry,
      };

      expect(
        await repository.getAllInternships(academicProfileId: 'profile-1'),
        isEmpty,
      );
      expect(queueById['internship::internship-1']?.operation, 'delete');
    });

    test('saves and deletes extension activities by profile', () async {
      final repository = DriftExtensionActivityRepository(
        harness.database,
        harness.syncQueueService,
      );

      await repository.saveActivity(_extension(id: 'extension-1'));
      await repository.saveActivity(
        _extension(id: 'extension-2', academicProfileId: 'profile-2'),
      );

      expect(
        await repository.getAllActivities(academicProfileId: 'profile-1'),
        hasLength(1),
      );

      await repository.deleteActivity('extension-1');
      final queueById = {
        for (final entry in await harness.queueEntries()) entry.id: entry,
      };

      expect(
        await repository.getAllActivities(academicProfileId: 'profile-1'),
        isEmpty,
      );
      expect(queueById['extension_activity::extension-1']?.operation, 'delete');
    });
  });
}

ComplementaryActivity _complementary({
  required String id,
  String academicProfileId = 'profile-1',
}) {
  final now = DateTime(2026, 6, 4, 9);
  return ComplementaryActivity(
    id: id,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    academicProfileId: academicProfileId,
    title: 'Campus Party',
    category: 'Evento',
    date: now,
    endDate: now.add(const Duration(days: 4)),
    workloadHours: 32,
    notes: 'Atividade continua.',
    status: ValidationStatus.approved,
  );
}

InternshipRecord _internship({
  required String id,
  String academicProfileId = 'profile-1',
}) {
  final now = DateTime(2026, 6, 5, 8);
  return InternshipRecord(
    id: id,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    academicProfileId: academicProfileId,
    location: 'Empresa Dev',
    supervisor: 'Maria',
    startDate: now,
    endDate: now.add(const Duration(days: 90)),
    totalHours: 300,
    completedHours: 80,
    status: InternshipStatus.inProgress,
  );
}

ExtensionActivity _extension({
  required String id,
  String academicProfileId = 'profile-1',
}) {
  final now = DateTime(2026, 6, 6, 14);
  return ExtensionActivity(
    id: id,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    academicProfileId: academicProfileId,
    title: 'Projeto com comunidade',
    type: 'Oficina',
    date: now,
    workloadHours: 40,
    status: ValidationStatus.approved,
  );
}
