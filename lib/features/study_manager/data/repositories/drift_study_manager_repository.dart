import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../domain/entities/study_session.dart';
import '../../domain/entities/study_subject.dart';
import '../../domain/entities/study_task.dart';
import '../../domain/entities/study_topic.dart';
import '../../domain/repositories/study_manager_repository.dart';

class DriftStudyManagerRepository implements StudyManagerRepository {
  DriftStudyManagerRepository(this._database, this._syncQueueService);

  final AppDatabase _database;
  final SyncQueueService _syncQueueService;

  @override
  Future<void> deleteSession(String id) async {
    final now = DateTime.now();
    await (_database.update(_database.studySessions)
          ..where((table) => table.id.equals(id)))
        .write(
      StudySessionsCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingDelete.name),
      ),
    );
    await _enqueueDelete('study_session', id, now);
  }

  @override
  Future<void> deleteSubject(String id) async {
    final now = DateTime.now();
    await (_database.update(_database.studySubjects)
          ..where((table) => table.id.equals(id)))
        .write(
      StudySubjectsCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingDelete.name),
      ),
    );
    await _enqueueDelete('study_subject', id, now);
  }

  @override
  Future<void> deleteTask(String id) async {
    final now = DateTime.now();
    await (_database.update(_database.studyTasks)
          ..where((table) => table.id.equals(id)))
        .write(
      StudyTasksCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingDelete.name),
      ),
    );
    await _enqueueDelete('study_task', id, now);
  }

  @override
  Future<void> deleteTopic(String id) async {
    final now = DateTime.now();
    await (_database.update(_database.studyTopics)
          ..where((table) => table.id.equals(id)))
        .write(
      StudyTopicsCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingDelete.name),
      ),
    );
    await _enqueueDelete('study_topic', id, now);
  }

  @override
  Future<StudySession?> findSessionById(String id) async {
    final query = _database.select(_database.studySessions)
      ..where((table) => table.id.equals(id))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapSession(row);
  }

  @override
  Future<StudySubject?> findSubjectById(String id) async {
    final query = _database.select(_database.studySubjects)
      ..where((table) => table.id.equals(id))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapSubject(row);
  }

  @override
  Future<StudyTask?> findTaskById(String id) async {
    final query = _database.select(_database.studyTasks)
      ..where((table) => table.id.equals(id))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapTask(row);
  }

  @override
  Future<StudyTopic?> findTopicById(String id) async {
    final query = _database.select(_database.studyTopics)
      ..where((table) => table.id.equals(id))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapTopic(row);
  }

  @override
  Future<List<StudySession>> getAllSessions() async {
    final rows = await _database.select(_database.studySessions).get();
    return rows.map(_mapSession).toList();
  }

  @override
  Future<List<StudySubject>> getAllSubjects() async {
    final rows = await _database.select(_database.studySubjects).get();
    return rows.map(_mapSubject).toList();
  }

  @override
  Future<List<StudyTask>> getAllTasks() async {
    final rows = await _database.select(_database.studyTasks).get();
    return rows.map(_mapTask).toList();
  }

  @override
  Future<List<StudyTopic>> getAllTopics() async {
    final rows = await _database.select(_database.studyTopics).get();
    return rows.map(_mapTopic).toList();
  }

  @override
  Future<void> saveSession(StudySession session) async {
    await _database.transaction(() async {
      await _database.into(_database.studySessions).insertOnConflictUpdate(
            StudySessionsCompanion(
              id: Value(session.id),
              remoteId: Value(session.remoteId),
              createdAt: Value(session.createdAt),
              updatedAt: Value(session.updatedAt),
              syncStatus: Value(session.syncStatus.name),
              isDeleted: Value(session.isDeleted),
              studySubjectId: Value(session.studySubjectId),
              studyTopicId: Value(session.studyTopicId),
              startedAt: Value(session.startedAt),
              endedAt: Value(session.endedAt),
              durationMinutes: Value(session.durationMinutes),
              notes: Value(session.notes),
            ),
          );
      await _enqueueUpsert(
        entityType: 'study_session',
        entityId: session.id,
        updatedAt: session.updatedAt,
        payload: session.toJson(),
      );
    });
  }

  @override
  Future<void> saveSubject(StudySubject subject) async {
    await _database.transaction(() async {
      await _database.into(_database.studySubjects).insertOnConflictUpdate(
            StudySubjectsCompanion(
              id: Value(subject.id),
              remoteId: Value(subject.remoteId),
              createdAt: Value(subject.createdAt),
              updatedAt: Value(subject.updatedAt),
              syncStatus: Value(subject.syncStatus.name),
              isDeleted: Value(subject.isDeleted),
              name: Value(subject.name),
              colorValue: Value(subject.colorValue),
              description: Value(subject.description),
            ),
          );
      await _enqueueUpsert(
        entityType: 'study_subject',
        entityId: subject.id,
        updatedAt: subject.updatedAt,
        payload: subject.toJson(),
      );
    });
  }

  @override
  Future<void> saveTask(StudyTask task) async {
    await _database.transaction(() async {
      await _database.into(_database.studyTasks).insertOnConflictUpdate(
            StudyTasksCompanion(
              id: Value(task.id),
              remoteId: Value(task.remoteId),
              createdAt: Value(task.createdAt),
              updatedAt: Value(task.updatedAt),
              syncStatus: Value(task.syncStatus.name),
              isDeleted: Value(task.isDeleted),
              title: Value(task.title),
              description: Value(task.description),
              studySubjectId: Value(task.studySubjectId),
              dueDate: Value(task.dueDate),
              priority: Value(task.priority.name),
              status: Value(task.status.name),
            ),
          );
      await _enqueueUpsert(
        entityType: 'study_task',
        entityId: task.id,
        updatedAt: task.updatedAt,
        payload: task.toJson(),
      );
    });
  }

  @override
  Future<void> saveTopic(StudyTopic topic) async {
    await _database.transaction(() async {
      await _database.into(_database.studyTopics).insertOnConflictUpdate(
            StudyTopicsCompanion(
              id: Value(topic.id),
              remoteId: Value(topic.remoteId),
              createdAt: Value(topic.createdAt),
              updatedAt: Value(topic.updatedAt),
              syncStatus: Value(topic.syncStatus.name),
              isDeleted: Value(topic.isDeleted),
              studySubjectId: Value(topic.studySubjectId),
              name: Value(topic.name),
              description: Value(topic.description),
              status: Value(topic.status.name),
            ),
          );
      await _enqueueUpsert(
        entityType: 'study_topic',
        entityId: topic.id,
        updatedAt: topic.updatedAt,
        payload: topic.toJson(),
      );
    });
  }

  @override
  Stream<List<StudySession>> watchSessions() {
    final query = _database.select(_database.studySessions)
      ..where((table) => table.isDeleted.equals(false))
      ..orderBy([(table) => OrderingTerm.desc(table.startedAt)]);
    return query.watch().map((rows) => rows.map(_mapSession).toList());
  }

  @override
  Stream<List<StudySubject>> watchSubjects() {
    final query = _database.select(_database.studySubjects)
      ..where((table) => table.isDeleted.equals(false))
      ..orderBy([(table) => OrderingTerm.asc(table.name)]);
    return query.watch().map((rows) => rows.map(_mapSubject).toList());
  }

  @override
  Stream<List<StudyTask>> watchTasks() {
    final query = _database.select(_database.studyTasks)
      ..where((table) => table.isDeleted.equals(false))
      ..orderBy([
        (table) => OrderingTerm.desc(table.dueDate),
        (table) => OrderingTerm.asc(table.title),
      ]);
    return query.watch().map((rows) => rows.map(_mapTask).toList());
  }

  @override
  Stream<List<StudyTopic>> watchTopics(String subjectId) {
    final query = _database.select(_database.studyTopics)
      ..where(
        (table) =>
            table.isDeleted.equals(false) & table.studySubjectId.equals(subjectId),
      )
      ..orderBy([(table) => OrderingTerm.asc(table.name)]);
    return query.watch().map((rows) => rows.map(_mapTopic).toList());
  }

  StudySession _mapSession(StudySessionRow row) {
    return StudySession(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      studySubjectId: row.studySubjectId,
      studyTopicId: row.studyTopicId,
      startedAt: row.startedAt,
      endedAt: row.endedAt,
      durationMinutes: row.durationMinutes,
      notes: row.notes,
    );
  }

  StudySubject _mapSubject(StudySubjectRow row) {
    return StudySubject(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      name: row.name,
      colorValue: row.colorValue,
      description: row.description,
    );
  }

  StudyTask _mapTask(StudyTaskRow row) {
    return StudyTask(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      title: row.title,
      description: row.description,
      studySubjectId: row.studySubjectId,
      dueDate: row.dueDate,
      priority: StudyTaskPriority.values.byName(row.priority),
      status: StudyTaskStatus.values.byName(row.status),
    );
  }

  StudyTopic _mapTopic(StudyTopicRow row) {
    return StudyTopic(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      studySubjectId: row.studySubjectId,
      name: row.name,
      description: row.description,
      status: StudyTopicStatus.values.byName(row.status),
    );
  }

  Future<void> _enqueueUpsert({
    required String entityType,
    required String entityId,
    required DateTime updatedAt,
    required Map<String, dynamic> payload,
  }) {
    return _syncQueueService.enqueueUpsert(
      entityType: entityType,
      entityId: entityId,
      entityVersion: updatedAt.millisecondsSinceEpoch,
      payload: payload,
    );
  }

  Future<void> _enqueueDelete(String entityType, String entityId, DateTime now) {
    return _syncQueueService.enqueueDelete(
      entityType: entityType,
      entityId: entityId,
      entityVersion: now.millisecondsSinceEpoch,
      payload: {
        'id': entityId,
        'isDeleted': true,
        'updatedAt': now.toIso8601String(),
        'syncStatus': SyncStatus.pendingDelete.name,
      },
    );
  }
}
