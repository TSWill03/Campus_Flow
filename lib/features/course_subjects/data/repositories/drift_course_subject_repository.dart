// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/attachments/attachment_owner_type.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../domain/entities/course_subject.dart';
import '../../domain/entities/course_subject_lesson.dart';
import '../../domain/repositories/course_subject_repository.dart';

class DriftCourseSubjectRepository implements CourseSubjectRepository {
  DriftCourseSubjectRepository(this._database, this._syncQueueService);

  final AppDatabase _database;
  final SyncQueueService _syncQueueService;

  @override
  Future<void> deleteSubject(String id) async {
    final now = DateTime.now();
    final lessonRows =
        await (_database.select(_database.courseSubjectLessons)..where(
              (table) =>
                  table.courseSubjectId.equals(id) &
                  table.isDeleted.equals(false),
            ))
            .get();
    final lessonIds = lessonRows.map((row) => row.id).toList(growable: false);
    final attachmentRows = lessonIds.isEmpty
        ? const <AttachmentRow>[]
        : await (_database.select(_database.attachments)..where(
                (table) =>
                    table.ownerType.equals(
                      AttachmentOwnerType.courseSubjectLesson.dbValue,
                    ) &
                    table.ownerId.isIn(lessonIds) &
                    table.isDeleted.equals(false),
              ))
              .get();
    final attachmentIds = attachmentRows
        .map((row) => row.id)
        .toList(growable: false);

    await _database.transaction(() async {
      await (_database.update(
        _database.courseSubjects,
      )..where((table) => table.id.equals(id))).write(
        CourseSubjectsCompanion(
          isDeleted: const Value(true),
          updatedAt: Value(now),
          syncStatus: Value(SyncStatus.pendingDelete.name),
        ),
      );
      await (_database.update(
        _database.courseSubjectLessons,
      )..where((table) => table.courseSubjectId.equals(id))).write(
        CourseSubjectLessonsCompanion(
          isDeleted: const Value(true),
          updatedAt: Value(now),
          syncStatus: Value(SyncStatus.pendingDelete.name),
        ),
      );

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
    });

    await _enqueueDelete('course_subject', id, now);
    await _enqueueDeleteForIds('course_subject_lesson', lessonIds, now);
    await _enqueueDeleteForIds('attachment', attachmentIds, now);
  }

  @override
  Future<CourseSubject?> findById(String id) async {
    final query = _database.select(_database.courseSubjects)
      ..where((table) => table.id.equals(id))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<CourseSubjectLesson?> findLessonById(String id) async {
    final query = _database.select(_database.courseSubjectLessons)
      ..where((table) => table.id.equals(id))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapLessonRow(row);
  }

  @override
  Future<List<CourseSubject>> getAllSubjects({
    String? academicProfileId,
  }) async {
    final query = _database.select(_database.courseSubjects)
      ..where((table) => table.isDeleted.equals(false));

    if (academicProfileId != null) {
      query.where((table) => table.academicProfileId.equals(academicProfileId));
    }

    final rows = await query.get();
    return rows.map(_mapRow).toList();
  }

  @override
  Future<List<CourseSubjectLesson>> getAllLessons({String? subjectId}) async {
    final query = _database.select(_database.courseSubjectLessons)
      ..where((table) => table.isDeleted.equals(false));

    if (subjectId != null) {
      query.where((table) => table.courseSubjectId.equals(subjectId));
    }

    final rows = await query.get();
    return rows.map(_mapLessonRow).toList();
  }

  @override
  Future<void> saveSubject(CourseSubject subject) async {
    await _database.transaction(() async {
      await _database
          .into(_database.courseSubjects)
          .insertOnConflictUpdate(
            CourseSubjectsCompanion(
              id: Value(subject.id),
              remoteId: Value(subject.remoteId),
              createdAt: Value(subject.createdAt),
              updatedAt: Value(subject.updatedAt),
              syncStatus: Value(subject.syncStatus.name),
              isDeleted: Value(subject.isDeleted),
              academicProfileId: Value(subject.academicProfileId),
              name: Value(subject.name),
              code: Value(subject.code),
              workloadHours: Value(subject.workloadHours),
              electiveHours: Value(subject.electiveHours),
              suggestedSemester: Value(subject.suggestedSemester),
              prerequisiteSubjectIdsJson: Value(
                _encodePrerequisiteSubjectIds(subject.prerequisiteSubjectIds),
              ),
              scheduledWeekday: Value(subject.scheduledWeekday),
              defaultLessonHours: Value(subject.defaultLessonHours),
              type: Value(subject.type.name),
              status: Value(subject.status.name),
              creditSourceSubjectId: Value(subject.creditSourceSubjectId),
              creditSourceProfileId: Value(subject.creditSourceProfileId),
              creditStatus: Value(subject.creditStatus.name),
              creditMatchScore: Value(subject.creditMatchScore),
              syllabus: Value(subject.syllabus),
              notes: Value(subject.notes),
            ),
          );
      await _syncQueueService.enqueueUpsert(
        entityType: 'course_subject',
        entityId: subject.id,
        entityVersion: subject.updatedAt.millisecondsSinceEpoch,
        payload: subject.toJson(),
      );
    });
  }

  @override
  Future<void> saveLesson(CourseSubjectLesson lesson) async {
    await _database.transaction(() async {
      await _database
          .into(_database.courseSubjectLessons)
          .insertOnConflictUpdate(
            CourseSubjectLessonsCompanion(
              id: Value(lesson.id),
              remoteId: Value(lesson.remoteId),
              createdAt: Value(lesson.createdAt),
              updatedAt: Value(lesson.updatedAt),
              syncStatus: Value(lesson.syncStatus.name),
              isDeleted: Value(lesson.isDeleted),
              courseSubjectId: Value(lesson.courseSubjectId),
              lessonDate: Value(lesson.lessonDate),
              lessonHours: Value(lesson.lessonHours),
              coveredContent: Value(lesson.coveredContent),
              description: Value(lesson.description),
              activityDescription: Value(lesson.activityDescription),
              assessmentDescription: Value(lesson.assessmentDescription),
              assessmentDate: Value(lesson.assessmentDate),
              pdfName: Value(lesson.pdfName),
              pdfBytes: Value(
                lesson.pdfBytes == null
                    ? null
                    : Uint8List.fromList(lesson.pdfBytes!),
              ),
              wasAbsent: Value(lesson.wasAbsent),
            ),
          );
      await _syncQueueService.enqueueUpsert(
        entityType: 'course_subject_lesson',
        entityId: lesson.id,
        entityVersion: lesson.updatedAt.millisecondsSinceEpoch,
        payload: lesson.toJson(),
      );
    });
  }

  @override
  Future<void> updateStatus(String id, CourseSubjectStatus status) async {
    final now = DateTime.now();
    await (_database.update(
      _database.courseSubjects,
    )..where((table) => table.id.equals(id))).write(
      CourseSubjectsCompanion(
        status: Value(status.name),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingUpdate.name),
      ),
    );
    await _syncQueueService.enqueueUpsert(
      entityType: 'course_subject',
      entityId: id,
      entityVersion: now.millisecondsSinceEpoch,
      payload: {
        'id': id,
        'status': status.name,
        'updatedAt': now.toIso8601String(),
        'syncStatus': SyncStatus.pendingUpdate.name,
      },
    );
  }

  @override
  Future<void> deleteLesson(String id) async {
    final now = DateTime.now();
    final attachmentRows =
        await (_database.select(_database.attachments)..where(
              (table) =>
                  table.ownerType.equals(
                    AttachmentOwnerType.courseSubjectLesson.dbValue,
                  ) &
                  table.ownerId.equals(id) &
                  table.isDeleted.equals(false),
            ))
            .get();
    final attachmentIds = attachmentRows
        .map((row) => row.id)
        .toList(growable: false);

    await _database.transaction(() async {
      await (_database.update(
        _database.courseSubjectLessons,
      )..where((table) => table.id.equals(id))).write(
        CourseSubjectLessonsCompanion(
          isDeleted: const Value(true),
          updatedAt: Value(now),
          syncStatus: Value(SyncStatus.pendingDelete.name),
        ),
      );

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
    });

    await _enqueueDelete('course_subject_lesson', id, now);
    await _enqueueDeleteForIds('attachment', attachmentIds, now);
  }

  Future<void> _enqueueDelete(
    String entityType,
    String id,
    DateTime now,
  ) async {
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

  Future<void> _enqueueDeleteForIds(
    String entityType,
    List<String> ids,
    DateTime now,
  ) async {
    for (final id in ids) {
      await _enqueueDelete(entityType, id, now);
    }
  }

  @override
  Stream<List<CourseSubject>> watchSubjects({String? academicProfileId}) {
    final query = _database.select(_database.courseSubjects)
      ..where((table) => table.isDeleted.equals(false))
      ..orderBy([
        (table) => OrderingTerm.asc(table.status),
        (table) => OrderingTerm.asc(table.name),
      ]);

    if (academicProfileId != null) {
      query.where((table) => table.academicProfileId.equals(academicProfileId));
    }

    return query.watch().map((rows) => rows.map(_mapRow).toList());
  }

  @override
  Stream<List<CourseSubjectLesson>> watchLessons(String subjectId) {
    final query = _database.select(_database.courseSubjectLessons)
      ..where(
        (table) =>
            table.isDeleted.equals(false) &
            table.courseSubjectId.equals(subjectId),
      )
      ..orderBy([
        (table) => OrderingTerm.desc(table.lessonDate),
        (table) => OrderingTerm.desc(table.createdAt),
      ]);

    return query.watch().map((rows) => rows.map(_mapLessonRow).toList());
  }

  CourseSubject _mapRow(CourseSubjectRow row) {
    return CourseSubject(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      academicProfileId: row.academicProfileId,
      name: row.name,
      code: row.code,
      workloadHours: row.workloadHours,
      electiveHours: row.electiveHours,
      suggestedSemester: row.suggestedSemester,
      prerequisiteSubjectIds: _decodePrerequisiteSubjectIds(
        row.prerequisiteSubjectIdsJson,
      ),
      scheduledWeekday: row.scheduledWeekday,
      defaultLessonHours: row.defaultLessonHours,
      type: CourseSubjectType.values.byName(row.type),
      status: CourseSubjectStatus.values.byName(row.status),
      creditSourceSubjectId: row.creditSourceSubjectId,
      creditSourceProfileId: row.creditSourceProfileId,
      creditStatus: CourseSubjectCreditStatus.values.byName(row.creditStatus),
      creditMatchScore: row.creditMatchScore,
      syllabus: row.syllabus,
      notes: row.notes,
    );
  }

  CourseSubjectLesson _mapLessonRow(CourseSubjectLessonRow row) {
    return CourseSubjectLesson(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      courseSubjectId: row.courseSubjectId,
      lessonDate: row.lessonDate,
      lessonHours: row.lessonHours,
      coveredContent: row.coveredContent,
      description: row.description,
      activityDescription: row.activityDescription,
      assessmentDescription: row.assessmentDescription,
      assessmentDate: row.assessmentDate,
      pdfName: row.pdfName,
      pdfBytes: row.pdfBytes,
      wasAbsent: row.wasAbsent,
    );
  }

  String _encodePrerequisiteSubjectIds(List<String> ids) {
    return jsonEncode(ids.where((id) => id.trim().isNotEmpty).toList());
  }

  List<String> _decodePrerequisiteSubjectIds(String rawValue) {
    final trimmed = rawValue.trim();
    if (trimmed.isEmpty) {
      return const <String>[];
    }

    try {
      final decoded = jsonDecode(trimmed);
      if (decoded is List) {
        return decoded
            .whereType<String>()
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList();
      }
    } catch (_) {
      return const <String>[];
    }

    return const <String>[];
  }
}
