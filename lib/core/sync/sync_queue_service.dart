import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';
import '../database/database_providers.dart';
import '../utils/id_generator.dart';

enum SyncQueueOperation {
  upsert,
  delete,
}

enum SyncQueueEntryStatus {
  pending,
  syncing,
  failed,
  synced,
}

enum SyncConflictPolicy {
  clientWins,
  serverWins,
  manualReview,
}

extension on SyncConflictPolicy {
  String get dbValue => switch (this) {
        SyncConflictPolicy.clientWins => 'client_wins',
        SyncConflictPolicy.serverWins => 'server_wins',
        SyncConflictPolicy.manualReview => 'manual_review',
      };
}

class SyncQueueOverview {
  const SyncQueueOverview({
    required this.deviceId,
    required this.pendingCount,
    required this.failedCount,
    this.lastSyncedAt,
  });

  final String deviceId;
  final int pendingCount;
  final int failedCount;
  final DateTime? lastSyncedAt;
}

class SyncQueueService {
  SyncQueueService({
    required AppDatabase database,
    required SharedPreferences sharedPreferences,
  })  : _database = database,
        _sharedPreferences = sharedPreferences;

  static const _deviceIdKey = 'sync_device_id';

  final AppDatabase _database;
  final SharedPreferences _sharedPreferences;

  String get description =>
      'A aplicacao agora grava uma fila de sincronizacao local com operacao, payload, deviceId, entityVersion e politica de conflito, pronta para um backend futuro.';

  Future<String> getOrCreateDeviceId() async {
    final existing = _sharedPreferences.getString(_deviceIdKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final deviceId = IdGenerator.generate();
    await _sharedPreferences.setString(_deviceIdKey, deviceId);
    return deviceId;
  }

  Future<void> enqueueUpsert({
    required String entityType,
    required String entityId,
    required int entityVersion,
    required Map<String, dynamic> payload,
    SyncConflictPolicy conflictPolicy = SyncConflictPolicy.clientWins,
  }) {
    return _enqueue(
      entityType: entityType,
      entityId: entityId,
      entityVersion: entityVersion,
      operation: SyncQueueOperation.upsert,
      payload: payload,
      conflictPolicy: conflictPolicy,
    );
  }

  Future<void> enqueueDelete({
    required String entityType,
    required String entityId,
    required int entityVersion,
    required Map<String, dynamic> payload,
    SyncConflictPolicy conflictPolicy = SyncConflictPolicy.clientWins,
  }) {
    return _enqueue(
      entityType: entityType,
      entityId: entityId,
      entityVersion: entityVersion,
      operation: SyncQueueOperation.delete,
      payload: payload,
      conflictPolicy: conflictPolicy,
    );
  }

  Stream<SyncQueueOverview> watchOverview() {
    return _database
        .customSelect(
          '''
            SELECT
              COALESCE(SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END), 0) AS pending_count,
              COALESCE(SUM(CASE WHEN status = 'failed' THEN 1 ELSE 0 END), 0) AS failed_count,
              MAX(last_synced_at) AS last_synced_at
            FROM sync_queue_entries
          ''',
          readsFrom: {_database.syncQueueEntries},
        )
        .watchSingle()
        .map((row) => SyncQueueOverview(
              deviceId: _sharedPreferences.getString(_deviceIdKey) ?? 'pendente',
              pendingCount: row.read<int>('pending_count'),
              failedCount: row.read<int>('failed_count'),
              lastSyncedAt: row.readNullable<DateTime>('last_synced_at'),
            ));
  }

  Future<void> _enqueue({
    required String entityType,
    required String entityId,
    required int entityVersion,
    required SyncQueueOperation operation,
    required Map<String, dynamic> payload,
    required SyncConflictPolicy conflictPolicy,
  }) async {
    final deviceId = await getOrCreateDeviceId();
    final now = DateTime.now();

    await _database.into(_database.syncQueueEntries).insertOnConflictUpdate(
          SyncQueueEntriesCompanion(
            id: Value('$entityType::$entityId'),
            entityType: Value(entityType),
            entityId: Value(entityId),
            entityVersion: Value(entityVersion),
            operation: Value(operation.name),
            payloadJson: Value(jsonEncode(payload)),
            status: Value(SyncQueueEntryStatus.pending.name),
            deviceId: Value(deviceId),
            conflictPolicy: Value(conflictPolicy.dbValue),
            retryCount: const Value(0),
            createdAt: Value(now),
            lastAttemptAt: const Value.absent(),
            lastSyncedAt: const Value.absent(),
          ),
        );
  }
}

final syncQueueServiceProvider = Provider<SyncQueueService>((ref) {
  return SyncQueueService(
    database: ref.watch(appDatabaseProvider),
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  );
});

final syncQueueOverviewProvider = StreamProvider<SyncQueueOverview>((ref) {
  return ref.watch(syncQueueServiceProvider).watchOverview();
});

final syncDeviceIdProvider = FutureProvider<String>((ref) {
  return ref.watch(syncQueueServiceProvider).getOrCreateDeviceId();
});
