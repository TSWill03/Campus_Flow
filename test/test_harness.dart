// Signature: dev.tswicolly03

import 'package:drift/native.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campus_flow/core/database/app_database.dart';
import 'package:campus_flow/core/sync/sync_queue_service.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/auth/data/services/auth_secure_store.dart';

class RepositoryTestHarness {
  RepositoryTestHarness({
    required this.database,
    required this.preferences,
    required this.syncQueueService,
  });

  final AppDatabase database;
  final SharedPreferences preferences;
  final SyncQueueService syncQueueService;

  Future<List<SyncQueueEntryRow>> queueEntries() {
    return database.select(database.syncQueueEntries).get();
  }

  Future<void> insertAcademicProfile({
    required String id,
    String profileName = 'Perfil de teste',
  }) async {
    final now = DateTime(2026, 6, 1, 7);
    await database
        .into(database.academicProfiles)
        .insert(
          AcademicProfilesCompanion.insert(
            id: id,
            createdAt: now,
            updatedAt: now,
            syncStatus: SyncStatus.synced.name,
            profileName: Value(profileName),
            courseName: 'Curso de Teste',
            institution: 'Instituicao de Teste',
            totalCourseHours: 3200,
            semesterCount: 8,
            requiredComplementaryHours: 100,
            requiredInternshipHours: 300,
            requiredExtensionHours: 320,
          ),
        );
  }

  Future<void> close() => database.close();
}

Future<RepositoryTestHarness> createRepositoryTestHarness({
  Map<String, Object> preferences = const {},
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(preferences);
  final sharedPreferences = await SharedPreferences.getInstance();
  final database = AppDatabase(executor: NativeDatabase.memory());
  final syncQueueService = SyncQueueService(
    database: database,
    sharedPreferences: sharedPreferences,
  );
  return RepositoryTestHarness(
    database: database,
    preferences: sharedPreferences,
    syncQueueService: syncQueueService,
  );
}

class MemoryAuthSecureStore implements AuthSecureStore {
  final Map<String, String> values = {};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async {
    values[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    values.remove(key);
  }
}
