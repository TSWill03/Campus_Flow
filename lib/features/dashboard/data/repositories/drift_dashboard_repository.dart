import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/attachment_deadline_reminder.dart';
import '../../domain/entities/dashboard_summary.dart';

class DriftDashboardRepository {
  DriftDashboardRepository(this._database);

  final AppDatabase _database;

  Stream<DashboardSummary> watchSummary({String? academicProfileId}) {
    final filteredProfileId =
        academicProfileId != null && academicProfileId.isNotEmpty
            ? academicProfileId
            : null;
    final profileFilter =
        filteredProfileId != null ? ' AND academic_profile_id = ?1' : '';
    final variables = filteredProfileId != null
        ? [Variable<String>(filteredProfileId)]
        : const <Variable<Object>>[];
    final requirementsProjection = filteredProfileId != null
        ? '''
          (SELECT COALESCE(required_complementary_hours, 0) FROM academic_profiles WHERE id = ?1 LIMIT 1)
            AS required_complementary_hours,
          (SELECT COALESCE(required_internship_hours, 0) FROM academic_profiles WHERE id = ?1 LIMIT 1)
            AS required_internship_hours,
          (SELECT COALESCE(required_extension_hours, 0) FROM academic_profiles WHERE id = ?1 LIMIT 1)
            AS required_extension_hours
        '''
        : '''
          0 AS required_complementary_hours,
          0 AS required_internship_hours,
          0 AS required_extension_hours
        ''';

    final query = '''
      SELECT
        (SELECT COUNT(*) FROM course_subjects WHERE is_deleted = 0$profileFilter) AS total_subjects,
        (SELECT COUNT(*) FROM course_subjects WHERE is_deleted = 0 AND status = 'completed'$profileFilter)
          AS completed_subjects,
        (SELECT COALESCE(SUM(workload_hours), 0)
          FROM complementary_activities
          WHERE is_deleted = 0 AND status = 'approved'$profileFilter) AS completed_complementary_hours,
        (SELECT COALESCE(SUM(completed_hours), 0)
          FROM internships
          WHERE is_deleted = 0$profileFilter) AS completed_internship_hours,
        (SELECT COALESCE(SUM(workload_hours), 0)
          FROM extension_activities
          WHERE is_deleted = 0 AND status = 'approved'$profileFilter) AS completed_extension_hours,
        (SELECT COUNT(*) FROM study_sessions WHERE is_deleted = 0) AS total_study_sessions,
        (SELECT COALESCE(SUM(duration_minutes), 0) FROM study_sessions WHERE is_deleted = 0)
          AS total_study_minutes,
        $requirementsProjection
    ''';

    return _database
        .customSelect(
          query,
          variables: variables,
          readsFrom: {
            _database.academicProfiles,
            _database.courseSubjects,
            _database.complementaryActivities,
            _database.internships,
            _database.extensionActivities,
            _database.studySessions,
          },
        )
        .watchSingle()
        .map(_mapSummary);
  }

  Stream<List<AttachmentDeadlineReminder>> watchPendingAttachmentDeadlines({
    String? academicProfileId,
  }) {
    final filteredProfileId =
        academicProfileId != null && academicProfileId.isNotEmpty
            ? academicProfileId
            : null;
    final profileFilter =
        filteredProfileId != null ? ' AND s.academic_profile_id = ?1' : '';
    final variables = filteredProfileId != null
        ? [Variable<String>(filteredProfileId)]
        : const <Variable<Object>>[];

    return _database
        .customSelect(
          '''
          SELECT
            a.id AS attachment_id,
            a.file_name,
            a.due_date,
            s.id AS subject_id,
            s.name AS subject_name,
            l.covered_content AS lesson_title
          FROM attachments a
          INNER JOIN course_subject_lessons l
            ON l.id = a.owner_id
          INNER JOIN course_subjects s
            ON s.id = l.course_subject_id
          WHERE a.is_deleted = 0
            AND a.owner_type = 'course_subject_lesson'
            AND a.category = 'activity'
            AND a.is_completed = 0
            AND a.due_date IS NOT NULL
            AND l.is_deleted = 0
            AND s.is_deleted = 0$profileFilter
          ORDER BY a.due_date ASC
          LIMIT 8
          ''',
          variables: variables,
          readsFrom: {
            _database.attachments,
            _database.courseSubjectLessons,
            _database.courseSubjects,
          },
        )
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => AttachmentDeadlineReminder(
                  attachmentId: row.read<String>('attachment_id'),
                  subjectId: row.read<String>('subject_id'),
                  subjectName: row.read<String>('subject_name'),
                  lessonTitle: row.read<String>('lesson_title'),
                  fileName: row.read<String>('file_name'),
                  dueDate: row.read<DateTime>('due_date'),
                ),
              )
              .toList(),
        );
  }

  DashboardSummary _mapSummary(QueryRow row) {
    final totalSubjects = row.read<int>('total_subjects');
    final completedSubjects = row.read<int>('completed_subjects');
    final pendingSubjects = totalSubjects - completedSubjects;
    final completedComplementaryHours =
        row.read<int>('completed_complementary_hours');
    final completedInternshipHours = row.read<int>('completed_internship_hours');
    final completedExtensionHours = row.read<int>('completed_extension_hours');
    final requiredComplementaryHours =
        row.read<int>('required_complementary_hours');
    final requiredInternshipHours = row.read<int>('required_internship_hours');
    final requiredExtensionHours = row.read<int>('required_extension_hours');

    return DashboardSummary(
      courseCompletionPercentage: totalSubjects == 0
          ? 0
          : (completedSubjects / totalSubjects) * 100,
      totalSubjects: totalSubjects,
      completedSubjects: completedSubjects,
      pendingSubjects: pendingSubjects < 0 ? 0 : pendingSubjects,
      completedComplementaryHours: completedComplementaryHours,
      remainingComplementaryHours:
          _remaining(requiredComplementaryHours, completedComplementaryHours),
      completedInternshipHours: completedInternshipHours,
      remainingInternshipHours:
          _remaining(requiredInternshipHours, completedInternshipHours),
      completedExtensionHours: completedExtensionHours,
      remainingExtensionHours:
          _remaining(requiredExtensionHours, completedExtensionHours),
      totalStudySessions: row.read<int>('total_study_sessions'),
      totalStudyMinutes: row.read<int>('total_study_minutes'),
    );
  }

  int _remaining(int required, int completed) {
    final value = required - completed;
    return value < 0 ? 0 : value;
  }
}
