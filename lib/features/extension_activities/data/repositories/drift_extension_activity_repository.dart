// Signature: dev.tswicolly03

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../domain/entities/extension_activity.dart';
import '../../domain/repositories/extension_activity_repository.dart';

class DriftExtensionActivityRepository implements ExtensionActivityRepository {
  DriftExtensionActivityRepository(this._database, this._syncQueueService);

  final AppDatabase _database;
  final SyncQueueService _syncQueueService;

  @override
  Future<void> deleteActivity(String id) async {
    final now = DateTime.now();
    await (_database.update(_database.extensionActivities)
          ..where((table) => table.id.equals(id)))
        .write(
      ExtensionActivitiesCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingDelete.name),
      ),
    );
    await _syncQueueService.enqueueDelete(
      entityType: 'extension_activity',
      entityId: id,
      entityVersion: now.millisecondsSinceEpoch,
      payload: {
        'id': id,
        'isDeleted': true,
        'updatedAt': now.toIso8601String(),
        'syncStatus': SyncStatus.pendingDelete.name,
      },
    );
  }

  @override
  Future<ExtensionActivity?> findById(String id) async {
    final query = _database.select(_database.extensionActivities)
      ..where((table) => table.id.equals(id))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<List<ExtensionActivity>> getAllActivities({
    String? academicProfileId,
  }) async {
    final query = _database.select(_database.extensionActivities)
      ..where((table) => table.isDeleted.equals(false));

    if (academicProfileId != null) {
      query.where((table) => table.academicProfileId.equals(academicProfileId));
    }

    final rows = await query.get();
    return rows.map(_mapRow).toList();
  }

  @override
  Future<void> saveActivity(ExtensionActivity activity) async {
    await _database.transaction(() async {
      await _database
          .into(_database.extensionActivities)
          .insertOnConflictUpdate(
            ExtensionActivitiesCompanion(
              id: Value(activity.id),
              remoteId: Value(activity.remoteId),
              createdAt: Value(activity.createdAt),
              updatedAt: Value(activity.updatedAt),
              syncStatus: Value(activity.syncStatus.name),
              isDeleted: Value(activity.isDeleted),
              academicProfileId: Value(activity.academicProfileId),
              title: Value(activity.title),
              type: Value(activity.type),
              date: Value(activity.date),
              workloadHours: Value(activity.workloadHours),
              notes: Value(activity.notes),
              status: Value(activity.status.name),
            ),
          );
      await _syncQueueService.enqueueUpsert(
        entityType: 'extension_activity',
        entityId: activity.id,
        entityVersion: activity.updatedAt.millisecondsSinceEpoch,
        payload: activity.toJson(),
      );
    });
  }

  @override
  Stream<List<ExtensionActivity>> watchActivities({String? academicProfileId}) {
    final query = _database.select(_database.extensionActivities)
      ..where((table) => table.isDeleted.equals(false))
      ..orderBy([(table) => OrderingTerm.desc(table.date)]);

    if (academicProfileId != null) {
      query.where((table) => table.academicProfileId.equals(academicProfileId));
    }

    return query.watch().map((rows) => rows.map(_mapRow).toList());
  }

  ExtensionActivity _mapRow(ExtensionActivityRow row) {
    return ExtensionActivity(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      academicProfileId: row.academicProfileId,
      title: row.title,
      type: row.type,
      date: row.date,
      workloadHours: row.workloadHours,
      notes: row.notes,
      status: ValidationStatus.values.byName(row.status),
    );
  }
}
