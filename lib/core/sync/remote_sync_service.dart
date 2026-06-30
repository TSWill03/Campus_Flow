// Signature: dev.tswicolly03

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../database/app_database.dart';
import '../database/database_providers.dart';
import '../feedback/error_report_providers.dart';
import '../feedback/error_report_service.dart';
import '../network/api_client.dart';
import '../network/api_settings.dart';

class RemoteSyncRunResult {
  const RemoteSyncRunResult({
    required this.pushed,
    required this.conflicts,
    required this.failed,
    required this.pulled,
  });

  final int pushed;
  final int conflicts;
  final int failed;
  final int pulled;

  bool get hasIssues => conflicts > 0 || failed > 0;
}

class RemoteSyncService {
  RemoteSyncService({
    required AppDatabase database,
    required ApiClient apiClient,
    required ApiSettings settings,
    required SharedPreferences sharedPreferences,
    required ErrorReportService errorReportService,
  }) : _database = database,
       _apiClient = apiClient,
       _settings = settings,
       _sharedPreferences = sharedPreferences,
       _errorReportService = errorReportService;

  static const _pullCursorKey = 'remote_sync_pull_cursor';

  final AppDatabase _database;
  final ApiClient _apiClient;
  final ApiSettings _settings;
  final SharedPreferences _sharedPreferences;
  final ErrorReportService _errorReportService;

  Future<RemoteSyncRunResult> syncNow() async {
    // O app continua offline-first: se nao houver endpoint configurado, a sync
    // nao bloqueia o uso local. Quando houver servidor, envia a fila em lotes.
    if (!_settings.hasServer) {
      return const RemoteSyncRunResult(
        pushed: 0,
        conflicts: 0,
        failed: 0,
        pulled: 0,
      );
    }

    final pending =
        await (_database.select(_database.syncQueueEntries)
              ..where(
                (table) =>
                    table.status.equals('pending') |
                    table.status.equals('failed'),
              )
              ..orderBy([(table) => OrderingTerm.asc(table.createdAt)])
              ..limit(500))
            .get();

    var pushed = 0;
    var conflicts = 0;
    var failed = 0;

    if (pending.isNotEmpty) {
      await _markSyncing(pending);
      try {
        // O backend recebe mudancas genericas por entidade. Isso permite evoluir
        // o schema do app sem criar uma rota especifica para cada tabela agora.
        final response = await _apiClient.post(
          '/sync/push',
          body: {
            'clientId': pending.first.deviceId ?? 'unknown-device',
            'deviceName': 'CampusFlow',
            'changes': pending.map(_changeFromEntry).toList(),
          },
        );
        final results = (response['results'] as List<dynamic>? ?? const []);
        for (final rawResult in results) {
          final result = rawResult as Map<String, dynamic>;
          final status = result['status'] as String?;
          final entityType = result['entityType'] as String;
          final localId = result['localId'] as String;

          if (status == 'accepted') {
            pushed++;
            await _markAccepted(
              entityType: entityType,
              entityId: localId,
              remoteId: result['remoteId'] as String,
            );
          } else if (status == 'conflict') {
            conflicts++;
            await _markFailed(entityType, localId);
          }
        }
      } catch (error) {
        failed += pending.length;
        await _markFailedEntries(pending);
        _reportSyncFailure(error, pending.length);
      }
    }

    final pulled = await _pullServerChanges();
    return RemoteSyncRunResult(
      pushed: pushed,
      conflicts: conflicts,
      failed: failed,
      pulled: pulled,
    );
  }

  Map<String, dynamic> _changeFromEntry(SyncQueueEntryRow entry) {
    final payload = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
    final updatedAt = payload['updatedAt'] as String?;
    final change = {
      'entityType': entry.entityType,
      'localId': entry.entityId,
      'isDeleted': entry.operation == 'delete',
      'payload': payload,
    };
    if (updatedAt != null) {
      change['updatedAt'] = _normalizeDateTime(updatedAt);
    }
    return change;
  }

  String _normalizeDateTime(String rawValue) {
    final parsed = DateTime.tryParse(rawValue);
    if (parsed == null) {
      return rawValue;
    }
    return parsed.toUtc().toIso8601String();
  }

  Future<int> _pullServerChanges() async {
    final cursor = _sharedPreferences.getString(_pullCursorKey);
    // O cursor simples usa o horario do servidor. Em uma versao mais avancada,
    // este ponto pode virar paginacao por versao global ou log de eventos.
    final response = await _apiClient.get(
      '/sync/pull',
      queryParameters: {
        if (cursor != null && cursor.isNotEmpty) 'cursor': cursor,
        'limit': '200',
      },
    );
    final changes = response['changes'] as List<dynamic>? ?? const [];
    final serverTime = response['serverTime'] as String?;
    if (serverTime != null && serverTime.isNotEmpty) {
      await _sharedPreferences.setString(_pullCursorKey, serverTime);
    }
    return changes.length;
  }

  Future<void> _markSyncing(List<SyncQueueEntryRow> entries) async {
    final now = DateTime.now();
    await (_database.update(
      _database.syncQueueEntries,
    )..where((table) => table.id.isIn(entries.map((entry) => entry.id)))).write(
      SyncQueueEntriesCompanion(
        status: const Value('syncing'),
        lastAttemptAt: Value(now),
      ),
    );
  }

  Future<void> _markAccepted({
    required String entityType,
    required String entityId,
    required String remoteId,
  }) async {
    final now = DateTime.now();
    await (_database.update(_database.syncQueueEntries)..where(
          (table) =>
              table.entityType.equals(entityType) &
              table.entityId.equals(entityId),
        ))
        .write(
          SyncQueueEntriesCompanion(
            status: const Value('synced'),
            lastSyncedAt: Value(now),
          ),
        );

    final tableName = _entityTableName(entityType);
    if (tableName == null) {
      return;
    }

    await _database.customUpdate(
      'UPDATE $tableName SET remote_id = ?1, sync_status = ?2 WHERE id = ?3',
      variables: [
        Variable.withString(remoteId),
        Variable.withString('synced'),
        Variable.withString(entityId),
      ],
    );
  }

  Future<void> _markFailed(String entityType, String entityId) async {
    await (_database.update(_database.syncQueueEntries)..where(
          (table) =>
              table.entityType.equals(entityType) &
              table.entityId.equals(entityId),
        ))
        .write(const SyncQueueEntriesCompanion(status: Value('failed')));
  }

  Future<void> _markFailedEntries(List<SyncQueueEntryRow> entries) async {
    await (_database.update(_database.syncQueueEntries)
          ..where((table) => table.id.isIn(entries.map((entry) => entry.id))))
        .write(const SyncQueueEntriesCompanion(status: Value('failed')));
  }

  String? _entityTableName(String entityType) {
    return switch (entityType) {
      'academic_profile' => 'academic_profiles',
      'course_subject' => 'course_subjects',
      'course_subject_lesson' => 'course_subject_lessons',
      'attachment' => 'attachments',
      'complementary_activity' => 'complementary_activities',
      'internship' => 'internships',
      'extension_activity' => 'extension_activities',
      'study_subject' => 'study_subjects',
      'study_topic' => 'study_topics',
      'study_task' => 'study_tasks',
      'study_session' => 'study_sessions',
      _ => null,
    };
  }

  void _reportSyncFailure(Object error, int pendingCount) {
    unawaited(
      _errorReportService
          .submitReport(
            ErrorReportPayload(
              type: ErrorReportType.syncError,
              severity: ErrorReportSeverity.medium,
              message: 'Falha ao enviar fila de sincronizacao.',
              route: '/settings',
              extra: {
                'pendingCount': pendingCount,
                'errorType': error.runtimeType.toString(),
              },
            ),
          )
          .catchError((_) => const ErrorReportSendResult(queued: true)),
    );
  }
}

final remoteSyncServiceProvider = Provider<RemoteSyncService>((ref) {
  return RemoteSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: ref.watch(apiClientProvider),
    settings: ref.watch(apiSettingsControllerProvider),
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    errorReportService: ref.watch(errorReportServiceProvider),
  );
});
