// Signature: dev.tswicolly03

import 'package:drift/drift.dart';

import '../../../../core/attachments/attachment_owner_type.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../domain/entities/academic_profile.dart';
import '../../domain/repositories/academic_profile_repository.dart';

class DriftAcademicProfileRepository implements AcademicProfileRepository {
  DriftAcademicProfileRepository(this._database, this._syncQueueService);

  final AppDatabase _database;
  final SyncQueueService _syncQueueService;

  @override
  Future<void> deleteProfile(String id) async {
    final now = DateTime.now();
    final subjectRows =
        await (_database.select(_database.courseSubjects)..where(
              (table) =>
                  table.academicProfileId.equals(id) &
                  table.isDeleted.equals(false),
            ))
            .get();
    final subjectIds = subjectRows.map((row) => row.id).toList(growable: false);

    final lessonRows = subjectIds.isEmpty
        ? const <CourseSubjectLessonRow>[]
        : await (_database.select(_database.courseSubjectLessons)..where(
                (table) =>
                    table.courseSubjectId.isIn(subjectIds) &
                    table.isDeleted.equals(false),
              ))
              .get();
    final lessonIds = lessonRows.map((row) => row.id).toList(growable: false);

    final complementaryRows =
        await (_database.select(_database.complementaryActivities)..where(
              (table) =>
                  table.academicProfileId.equals(id) &
                  table.isDeleted.equals(false),
            ))
            .get();
    final complementaryIds = complementaryRows
        .map((row) => row.id)
        .toList(growable: false);

    final internshipRows =
        await (_database.select(_database.internships)..where(
              (table) =>
                  table.academicProfileId.equals(id) &
                  table.isDeleted.equals(false),
            ))
            .get();
    final internshipIds = internshipRows
        .map((row) => row.id)
        .toList(growable: false);

    final extensionRows =
        await (_database.select(_database.extensionActivities)..where(
              (table) =>
                  table.academicProfileId.equals(id) &
                  table.isDeleted.equals(false),
            ))
            .get();
    final extensionIds = extensionRows
        .map((row) => row.id)
        .toList(growable: false);

    final studySessionRows =
        await (_database.select(_database.studySessions)..where(
              (table) =>
                  table.academicProfileId.equals(id) &
                  table.isDeleted.equals(false),
            ))
            .get();
    final studySessionIds = studySessionRows
        .map((row) => row.id)
        .toList(growable: false);

    final attachmentRows = <AttachmentRow>[
      if (lessonIds.isNotEmpty)
        ...await (_database.select(_database.attachments)..where(
              (table) =>
                  table.ownerType.equals(
                    AttachmentOwnerType.courseSubjectLesson.dbValue,
                  ) &
                  table.ownerId.isIn(lessonIds) &
                  table.isDeleted.equals(false),
            ))
            .get(),
      if (complementaryIds.isNotEmpty)
        ...await (_database.select(_database.attachments)..where(
              (table) =>
                  table.ownerType.equals(
                    AttachmentOwnerType.complementaryActivity.dbValue,
                  ) &
                  table.ownerId.isIn(complementaryIds) &
                  table.isDeleted.equals(false),
            ))
            .get(),
      if (internshipIds.isNotEmpty)
        ...await (_database.select(_database.attachments)..where(
              (table) =>
                  table.ownerType.equals(
                    AttachmentOwnerType.internshipRecord.dbValue,
                  ) &
                  table.ownerId.isIn(internshipIds) &
                  table.isDeleted.equals(false),
            ))
            .get(),
    ];
    final attachmentIds = attachmentRows
        .map((row) => row.id)
        .toSet()
        .toList(growable: false);

    final creditLinkedSubjects = <String, CourseSubjectRow>{};
    final subjectsLinkedByProfile =
        await (_database.select(_database.courseSubjects)..where(
              (table) =>
                  table.isDeleted.equals(false) &
                  table.creditSourceProfileId.equals(id),
            ))
            .get();
    for (final row in subjectsLinkedByProfile) {
      if (!subjectIds.contains(row.id)) {
        creditLinkedSubjects[row.id] = row;
      }
    }
    if (subjectIds.isNotEmpty) {
      final subjectsLinkedBySource =
          await (_database.select(_database.courseSubjects)..where(
                (table) =>
                    table.isDeleted.equals(false) &
                    table.creditSourceSubjectId.isIn(subjectIds),
              ))
              .get();
      for (final row in subjectsLinkedBySource) {
        if (!subjectIds.contains(row.id)) {
          creditLinkedSubjects[row.id] = row;
        }
      }
    }

    await _database.transaction(() async {
      await (_database.update(
        _database.academicProfiles,
      )..where((table) => table.id.equals(id))).write(
        AcademicProfilesCompanion(
          isDeleted: const Value(true),
          isActive: const Value(false),
          updatedAt: Value(now),
          syncStatus: Value(SyncStatus.pendingDelete.name),
        ),
      );

      if (subjectIds.isNotEmpty) {
        await (_database.update(
          _database.courseSubjects,
        )..where((table) => table.id.isIn(subjectIds))).write(
          CourseSubjectsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (lessonIds.isNotEmpty) {
        await (_database.update(
          _database.courseSubjectLessons,
        )..where((table) => table.id.isIn(lessonIds))).write(
          CourseSubjectLessonsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (attachmentIds.isNotEmpty) {
        await (_database.update(
          _database.attachments,
        )..where((table) => table.id.isIn(attachmentIds))).write(
          AttachmentsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (complementaryIds.isNotEmpty) {
        await (_database.update(
          _database.complementaryActivities,
        )..where((table) => table.id.isIn(complementaryIds))).write(
          ComplementaryActivitiesCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (internshipIds.isNotEmpty) {
        await (_database.update(
          _database.internships,
        )..where((table) => table.id.isIn(internshipIds))).write(
          InternshipsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (extensionIds.isNotEmpty) {
        await (_database.update(
          _database.extensionActivities,
        )..where((table) => table.id.isIn(extensionIds))).write(
          ExtensionActivitiesCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (studySessionIds.isNotEmpty) {
        await (_database.update(
          _database.studySessions,
        )..where((table) => table.id.isIn(studySessionIds))).write(
          StudySessionsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      for (final linkedSubject in creditLinkedSubjects.values) {
        await (_database.update(
          _database.courseSubjects,
        )..where((table) => table.id.equals(linkedSubject.id))).write(
          CourseSubjectsCompanion(
            creditSourceSubjectId: const Value<String?>(null),
            creditSourceProfileId: const Value<String?>(null),
            creditStatus: Value(CourseSubjectCreditStatus.none.name),
            creditMatchScore: const Value<double?>(null),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingUpdate.name),
          ),
        );
      }
    });

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
    await _enqueueDeleteForIds(
      entityType: 'course_subject',
      ids: subjectIds,
      now: now,
    );
    await _enqueueDeleteForIds(
      entityType: 'course_subject_lesson',
      ids: lessonIds,
      now: now,
    );
    await _enqueueDeleteForIds(
      entityType: 'attachment',
      ids: attachmentIds,
      now: now,
    );
    await _enqueueDeleteForIds(
      entityType: 'complementary_activity',
      ids: complementaryIds,
      now: now,
    );
    await _enqueueDeleteForIds(
      entityType: 'internship',
      ids: internshipIds,
      now: now,
    );
    await _enqueueDeleteForIds(
      entityType: 'extension_activity',
      ids: extensionIds,
      now: now,
    );
    await _enqueueDeleteForIds(
      entityType: 'study_session',
      ids: studySessionIds,
      now: now,
    );
    for (final linkedSubject in creditLinkedSubjects.values) {
      await _syncQueueService.enqueueUpsert(
        entityType: 'course_subject',
        entityId: linkedSubject.id,
        entityVersion: now.millisecondsSinceEpoch,
        payload: {
          'id': linkedSubject.id,
          'creditSourceSubjectId': null,
          'creditSourceProfileId': null,
          'creditStatus': CourseSubjectCreditStatus.none.name,
          'creditMatchScore': null,
          'updatedAt': now.toIso8601String(),
          'syncStatus': SyncStatus.pendingUpdate.name,
        },
      );
    }

    final nextActive =
        await (_database.select(_database.academicProfiles)
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
      ..where(
        (table) => table.isDeleted.equals(false) & table.isActive.equals(true),
      )
      ..limit(1);

    final active = await query.getSingleOrNull();
    if (active != null) {
      return _mapRow(active);
    }

    final fallback =
        await (_database.select(_database.academicProfiles)
              ..where((table) => table.isDeleted.equals(false))
              ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
              ..limit(1))
            .getSingleOrNull();
    return fallback == null ? null : _mapRow(fallback);
  }

  @override
  Future<List<AcademicProfile>> getAllProfiles() async {
    final rows =
        await (_database.select(_database.academicProfiles)
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
      await _database
          .into(_database.academicProfiles)
          .insertOnConflictUpdate(
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
              requiredComplementaryHours: Value(
                profile.requiredComplementaryHours,
              ),
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

    await (_database.update(
      _database.academicProfiles,
    )..where((table) => table.id.equals(id))).write(
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
      ..where(
        (table) => table.isDeleted.equals(false) & table.isActive.equals(true),
      )
      ..limit(1);

    return query.watchSingleOrNull().map(
      (row) => row == null ? null : _mapRow(row),
    );
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
    return _database
        .update(_database.academicProfiles)
        .write(const AcademicProfilesCompanion(isActive: Value(false)));
  }

  Future<void> _enqueueDeleteForIds({
    required String entityType,
    required Iterable<String> ids,
    required DateTime now,
  }) async {
    for (final id in ids) {
      await _syncQueueService.enqueueDelete(
        entityType: entityType,
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
