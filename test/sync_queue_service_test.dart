// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SyncQueueService', () {
    late RepositoryTestHarness harness;

    setUp(() async {
      harness = await createRepositoryTestHarness(
        preferences: {'remote_sync_pull_cursor': '2026-06-01T00:00:00.000Z'},
      );
    });

    tearDown(() async {
      await harness.close();
    });

    test(
      'compacts repeated changes for same entity and discards local queue',
      () async {
        final service = harness.syncQueueService;

        await service.enqueueUpsert(
          entityType: 'course_subject',
          entityId: 'subject-1',
          entityVersion: 1,
          payload: {'name': 'Antigo'},
        );
        await service.enqueueUpsert(
          entityType: 'course_subject',
          entityId: 'subject-1',
          entityVersion: 2,
          payload: {'name': 'Atualizado'},
        );

        final entries = await harness.queueEntries();
        final payload = jsonDecode(entries.single.payloadJson) as Map;

        expect(entries, hasLength(1));
        expect(entries.single.entityVersion, 2);
        expect(payload['name'], 'Atualizado');
        expect((await service.watchOverview().first).pendingCount, 1);

        final deleted = await service.discardLocalQueue();

        expect(deleted, 1);
        expect(await harness.queueEntries(), isEmpty);
        expect(
          harness.preferences.getString('remote_sync_pull_cursor'),
          isNull,
        );
      },
    );
  });
}
