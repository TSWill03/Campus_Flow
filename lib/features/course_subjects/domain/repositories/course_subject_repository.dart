import '../entities/course_subject.dart';
import '../entities/course_subject_lesson.dart';
import '../../../../shared/enums/app_enums.dart';

abstract interface class CourseSubjectRepository {
  Stream<List<CourseSubject>> watchSubjects({String? academicProfileId});

  Future<List<CourseSubject>> getAllSubjects({String? academicProfileId});

  Future<CourseSubject?> findById(String id);

  Stream<List<CourseSubjectLesson>> watchLessons(String subjectId);

  Future<List<CourseSubjectLesson>> getAllLessons({String? subjectId});

  Future<CourseSubjectLesson?> findLessonById(String id);

  Future<void> saveSubject(CourseSubject subject);

  Future<void> saveLesson(CourseSubjectLesson lesson);

  Future<void> updateStatus(String id, CourseSubjectStatus status);

  Future<void> deleteSubject(String id);

  Future<void> deleteLesson(String id);
}
