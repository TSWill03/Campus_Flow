import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../domain/entities/internship_record.dart';
import '../../domain/repositories/internship_repository.dart';

class DriftInternshipRepository implements InternshipRepository {
  DriftInternshipRepository(this._database, this._syncQueueService);

  final AppDatabase _database;
  final SyncQueueService _syncQueueService;

  @override
  Future<void> deleteInternship(String id) async {
    final now = DateTime.now();
    await (_database.update(_database.internships)
          ..where((table) => table.id.equals(id)))
        .write(
      InternshipsCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingDelete.name),
      ),
    );
    await _syncQueueService.enqueueDelete(
      entityType: 'internship',
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
  Future<InternshipRecord?> findById(String id) async {
    final query = _database.select(_database.internships)
      ..where((table) => table.id.equals(id))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<List<InternshipRecord>> getAllInternships({
    String? academicProfileId,
  }) async {
    final query = _database.select(_database.internships)
      ..where((table) => table.isDeleted.equals(false));

    if (academicProfileId != null) {
      query.where((table) => table.academicProfileId.equals(academicProfileId));
    }

    final rows = await query.get();
    return rows.map(_mapRow).toList();
  }

  @override
  Future<void> saveInternship(InternshipRecord internship) async {
    await _database.transaction(() async {
      await _database.into(_database.internships).insertOnConflictUpdate(
            InternshipsCompanion(
              id: Value(internship.id),
              remoteId: Value(internship.remoteId),
              createdAt: Value(internship.createdAt),
              updatedAt: Value(internship.updatedAt),
              syncStatus: Value(internship.syncStatus.name),
              isDeleted: Value(internship.isDeleted),
              academicProfileId: Value(internship.academicProfileId),
              location: Value(internship.location),
              supervisor: Value(internship.supervisor),
              startDate: Value(internship.startDate),
              endDate: Value(internship.endDate),
              totalHours: Value(internship.totalHours),
              completedHours: Value(internship.completedHours),
              status: Value(internship.status.name),
              notes: Value(internship.notes),
            ),
          );
      await _syncQueueService.enqueueUpsert(
        entityType: 'internship',
        entityId: internship.id,
        entityVersion: internship.updatedAt.millisecondsSinceEpoch,
        payload: internship.toJson(),
      );
    });
  }

  @override
  Stream<List<InternshipRecord>> watchInternships({String? academicProfileId}) {
    final query = _database.select(_database.internships)
      ..where((table) => table.isDeleted.equals(false))
      ..orderBy([(table) => OrderingTerm.desc(table.startDate)]);

    if (academicProfileId != null) {
      query.where((table) => table.academicProfileId.equals(academicProfileId));
    }

    return query.watch().map((rows) => rows.map(_mapRow).toList());
  }

  InternshipRecord _mapRow(InternshipRow row) {
    return InternshipRecord(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      academicProfileId: row.academicProfileId,
      location: row.location,
      supervisor: row.supervisor,
      startDate: row.startDate,
      endDate: row.endDate,
      totalHours: row.totalHours,
      completedHours: row.completedHours,
      status: InternshipStatus.values.byName(row.status),
      notes: row.notes,
    );
  }
}
