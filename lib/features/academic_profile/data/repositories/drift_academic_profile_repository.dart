// Signature: dev.tswicolly03

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../core/sync/sync_status.dart';
import '../../domain/entities/academic_profile.dart';
import '../../domain/repositories/academic_profile_repository.dart';

class DriftAcademicProfileRepository implements AcademicProfileRepository {
  DriftAcademicProfileRepository(this._database, this._syncQueueService);

  final AppDatabase _database;
  final SyncQueueService _syncQueueService;

  @override
  Future<void> deleteProfile(String id) async {
    final now = DateTime.now();
    await (_database.update(_database.academicProfiles)
          ..where((table) => table.id.equals(id)))
        .write(
      AcademicProfilesCompanion(
        isDeleted: const Value(true),
        isActive: const Value(false),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingDelete.name),
      ),
    );
    await _syncQueueService.enqueueDelete(
      entityType: 'academic_profile',
      entityId: id,
      entityVersion: now.millisecondsSinceEpoch,
      payload: {
        'id': id,
        'isDeleted': true,
        'updatedAt': now.toIso8601String(),
        'syncStatus': SyncStatus.pendingDelete.name,
      },
    );

    final nextActive = await (_database.select(_database.academicProfiles)
          ..where((table) => table.isDeleted.equals(false))
          ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
          ..limit(1))
        .getSingleOrNull();

    if (nextActive != null) {
      await setActiveProfile(nextActive.id);
    }
  }

  @override
  Future<AcademicProfile?> findById(String id) async {
    final query = _database.select(_database.academicProfiles)
      ..where((table) => table.id.equals(id))
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<AcademicProfile?> getActiveProfile() async {
    final query = _database.select(_database.academicProfiles)
      ..where((table) => table.isDeleted.equals(false) & table.isActive.equals(true))
      ..limit(1);

    final active = await query.getSingleOrNull();
    if (active != null) {
      return _mapRow(active);
    }

    final fallback = await (_database.select(_database.academicProfiles)
          ..where((table) => table.isDeleted.equals(false))
          ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
          ..limit(1))
        .getSingleOrNull();
    return fallback == null ? null : _mapRow(fallback);
  }

  @override
  Future<List<AcademicProfile>> getAllProfiles() async {
    final rows = await (_database.select(_database.academicProfiles)
          ..where((table) => table.isDeleted.equals(false))
          ..orderBy([
            (table) => OrderingTerm.desc(table.isActive),
            (table) => OrderingTerm.asc(table.profileName),
          ]))
        .get();

    return rows.map(_mapRow).toList();
  }

  @override
  Future<void> saveProfile(AcademicProfile profile) async {
    if (profile.isActive) {
      await _setInactiveForAll();
    }

    await _database.transaction(() async {
      await _database.into(_database.academicProfiles).insertOnConflictUpdate(
            AcademicProfilesCompanion(
              id: Value(profile.id),
              remoteId: Value(profile.remoteId),
              createdAt: Value(profile.createdAt),
              updatedAt: Value(profile.updatedAt),
              syncStatus: Value(profile.syncStatus.name),
              isDeleted: Value(profile.isDeleted),
              profileName: Value(profile.profileName),
              courseName: Value(profile.courseName),
              institution: Value(profile.institution),
              schoolName: Value(profile.schoolName),
              campus: Value(profile.campus),
              degreeLabel: Value(profile.degreeLabel),
              isActive: Value(profile.isActive),
              totalCourseHours: Value(profile.totalCourseHours),
              semesterCount: Value(profile.semesterCount),
              requiredComplementaryHours:
                  Value(profile.requiredComplementaryHours),
              requiredInternshipHours: Value(profile.requiredInternshipHours),
              requiredExtensionHours: Value(profile.requiredExtensionHours),
            ),
          );
      await _syncQueueService.enqueueUpsert(
        entityType: 'academic_profile',
        entityId: profile.id,
        entityVersion: profile.updatedAt.millisecondsSinceEpoch,
        payload: profile.toJson(),
      );
    });
  }

  @override
  Future<void> setActiveProfile(String id) async {
    await _setInactiveForAll();

    await (_database.update(_database.academicProfiles)
          ..where((table) => table.id.equals(id)))
        .write(
      AcademicProfilesCompanion(
        isActive: const Value(true),
        updatedAt: Value(DateTime.now()),
        syncStatus: Value(SyncStatus.pendingUpdate.name),
      ),
    );
  }

  @override
  Stream<AcademicProfile?> watchActiveProfile() {
    final query = _database.select(_database.academicProfiles)
      ..where((table) => table.isDeleted.equals(false) & table.isActive.equals(true))
      ..limit(1);

    return query.watchSingleOrNull().map((row) => row == null ? null : _mapRow(row));
  }

  @override
  Stream<List<AcademicProfile>> watchProfiles() {
    final query = _database.select(_database.academicProfiles)
      ..where((table) => table.isDeleted.equals(false))
      ..orderBy([
        (table) => OrderingTerm.desc(table.isActive),
        (table) => OrderingTerm.asc(table.profileName),
      ]);

    return query.watch().map((rows) => rows.map(_mapRow).toList());
  }

  Future<void> _setInactiveForAll() {
    return _database.update(_database.academicProfiles).write(
          const AcademicProfilesCompanion(
            isActive: Value(false),
          ),
        );
  }

  AcademicProfile _mapRow(AcademicProfileRow row) {
    return AcademicProfile(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      profileName: row.profileName,
      courseName: row.courseName,
      institution: row.institution,
      schoolName: row.schoolName,
      campus: row.campus,
      degreeLabel: row.degreeLabel,
      isActive: row.isActive,
      totalCourseHours: row.totalCourseHours,
      semesterCount: row.semesterCount,
      requiredComplementaryHours: row.requiredComplementaryHours,
      requiredInternshipHours: row.requiredInternshipHours,
      requiredExtensionHours: row.requiredExtensionHours,
    );
  }
}
