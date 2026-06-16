// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:campus_flow/core/network/api_client.dart';
import 'package:campus_flow/core/network/api_session_store.dart';
import 'package:campus_flow/core/network/api_settings.dart';
import 'package:campus_flow/core/sync/remote_sync_service.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/course_subjects/data/repositories/drift_course_subject_repository.dart';
import 'package:campus_flow/features/course_subjects/domain/entities/course_subject.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

import 'test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RemoteSyncService', () {
    late RepositoryTestHarness harness;

    setUp(() async {
      harness = await createRepositoryTestHarness();
      await harness.insertAcademicProfile(id: 'profile-1');
    });

    tearDown(() async {
      await harness.close();
    });

    test('pushes pending queue and marks accepted entity as synced', () async {
      final repository = DriftCourseSubjectRepository(
        harness.database,
        harness.syncQueueService,
      );
      await repository.saveSubject(_subject());

      final secureStore = MemoryAuthSecureStore();
      final sessionStore = ApiSessionStore(secureStore: secureStore);
      await sessionStore.write(
        ApiSession(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
          expiresAt: DateTime.now().add(const Duration(minutes: 10)),
        ),
      );

      Map<String, dynamic>? pushedBody;
      final apiClient = ApiClient(
        settings: const ApiSettings(baseUrl: 'https://example.com/api'),
        sessionStore: sessionStore,
        httpClient: MockClient((request) async {
          if (request.url.path == '/api/sync/push') {
            pushedBody = jsonDecode(request.body) as Map<String, dynamic>;
            return http.Response(
              jsonEncode({
                'serverTime': '2026-06-15T12:00:00.000Z',
                'results': [
                  {
                    'status': 'accepted',
                    'entityType': 'course_subject',
                    'localId': 'subject-1',
                    'remoteId': 'remote-subject-1',
                    'version': 2,
                    'updatedAt': '2026-06-15T12:00:00.000Z',
                  },
                ],
              }),
              200,
            );
          }

          if (request.url.path == '/api/sync/pull') {
            return http.Response(
              jsonEncode({
                'serverTime': '2026-06-15T12:01:00.000Z',
                'changes': [],
              }),
              200,
            );
          }

          return http.Response('not found', 404);
        }),
      );
      final service = RemoteSyncService(
        database: harness.database,
        apiClient: apiClient,
        settings: const ApiSettings(baseUrl: 'https://example.com/api'),
        sharedPreferences: harness.preferences,
      );

      final result = await service.syncNow();
      final subject = await repository.findById('subject-1');
      final queueEntry = (await harness.queueEntries()).single;

      expect(result.pushed, 1);
      expect(result.failed, 0);
      expect(result.conflicts, 0);
      expect(pushedBody?['changes'], hasLength(1));
      expect(subject?.remoteId, 'remote-subject-1');
      expect(subject?.syncStatus, SyncStatus.synced);
      expect(queueEntry.status, 'synced');
      expect(
        harness.preferences.getString('remote_sync_pull_cursor'),
        '2026-06-15T12:01:00.000Z',
      );
    });
  });
}

CourseSubject _subject() {
  final now = DateTime(2026, 6, 15, 8);
  return CourseSubject(
    id: 'subject-1',
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    academicProfileId: 'profile-1',
    name: 'Banco de Dados',
    workloadHours: 72,
    type: CourseSubjectType.mandatory,
    status: CourseSubjectStatus.inProgress,
  );
}
