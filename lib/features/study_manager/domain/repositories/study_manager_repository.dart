import '../entities/study_session.dart';
import '../entities/study_subject.dart';
import '../entities/study_task.dart';
import '../entities/study_topic.dart';

abstract interface class StudyManagerRepository {
  Stream<List<StudySubject>> watchSubjects();

  Future<List<StudySubject>> getAllSubjects();

  Future<StudySubject?> findSubjectById(String id);

  Future<void> saveSubject(StudySubject subject);

  Future<void> deleteSubject(String id);

  Stream<List<StudyTopic>> watchTopics(String subjectId);

  Future<List<StudyTopic>> getAllTopics();

  Future<StudyTopic?> findTopicById(String id);

  Future<void> saveTopic(StudyTopic topic);

  Future<void> deleteTopic(String id);

  Stream<List<StudyTask>> watchTasks();

  Future<List<StudyTask>> getAllTasks();

  Future<StudyTask?> findTaskById(String id);

  Future<void> saveTask(StudyTask task);

  Future<void> deleteTask(String id);

  Stream<List<StudySession>> watchSessions();

  Future<List<StudySession>> getAllSessions();

  Future<StudySession?> findSessionById(String id);

  Future<void> saveSession(StudySession session);

  Future<void> deleteSession(String id);
}
