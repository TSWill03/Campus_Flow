// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/academic_profile/presentation/pages/academic_profile_form_page.dart';
import '../../features/academic_profile/presentation/pages/academic_profile_page.dart';
import '../../features/complementary_hours/presentation/widgets/complementary_activities_page.dart';
import '../../features/complementary_hours/presentation/widgets/complementary_activity_form_page.dart';
import '../../features/course_subjects/presentation/pages/course_subject_detail_page.dart';
import '../../features/course_subjects/presentation/pages/course_subject_form_page.dart';
import '../../features/course_subjects/presentation/pages/course_subject_lesson_form_page.dart';
import '../../features/course_subjects/presentation/pages/course_subject_list_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/pages/splash_page.dart';
import '../../features/extension_activities/presentation/widgets/extension_activities_page.dart';
import '../../features/extension_activities/presentation/widgets/extension_activity_form_page.dart';
import '../../features/internships/presentation/widgets/internship_form_page.dart';
import '../../features/internships/presentation/widgets/internships_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/study_manager/presentation/pages/study_manager_page.dart';
import '../../features/study_manager/presentation/pages/study_session_form_page.dart';
import '../../features/study_manager/presentation/pages/study_subject_form_page.dart';
import '../../features/study_manager/presentation/pages/study_task_form_page.dart';
import '../../features/study_manager/presentation/pages/study_topic_form_page.dart';
import '../../features/study_manager/presentation/pages/study_topics_page.dart';
import '../../shared/widgets/app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const AcademicProfilePage(),
          ),
          GoRoute(
            path: '/subjects',
            builder: (context, state) => const CourseSubjectListPage(),
          ),
          GoRoute(
            path: '/subjects/:id',
            builder: (context, state) => CourseSubjectDetailPage(
              subjectId: state.pathParameters['id']!,
              startLessonOnOpen: state.uri.queryParameters['startLesson'] == '1',
            ),
          ),
          GoRoute(
            path: '/complementary',
            builder: (context, state) => const ComplementaryActivitiesPage(),
          ),
          GoRoute(
            path: '/internships',
            builder: (context, state) => const InternshipsPage(),
          ),
          GoRoute(
            path: '/extensions',
            builder: (context, state) => const ExtensionActivitiesPage(),
          ),
          GoRoute(
            path: '/study',
            builder: (context, state) => const StudyManagerPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/profile/new',
        builder: (context, state) => const AcademicProfileFormPage(),
      ),
      GoRoute(
        path: '/profile/:id/edit',
        builder: (context, state) => AcademicProfileFormPage(
          profileId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: '/subjects/new',
        builder: (context, state) => const CourseSubjectFormPage(),
      ),
      GoRoute(
        path: '/subjects/:id/edit',
        builder: (context, state) => CourseSubjectFormPage(
          subjectId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: '/subjects/:subjectId/lessons/new',
        builder: (context, state) {
          final rawDate = state.uri.queryParameters['lessonDate'];
          final rawHours = state.uri.queryParameters['lessonHours'];
          return CourseSubjectLessonFormPage(
            subjectId: state.pathParameters['subjectId']!,
            initialLessonDate: rawDate == null ? null : DateTime.tryParse(rawDate),
            suggestedLessonHours:
                rawHours == null ? null : double.tryParse(rawHours),
          );
        },
      ),
      GoRoute(
        path: '/subjects/:subjectId/lessons/:lessonId/edit',
        builder: (context, state) => CourseSubjectLessonFormPage(
          subjectId: state.pathParameters['subjectId']!,
          lessonId: state.pathParameters['lessonId'],
        ),
      ),
      GoRoute(
        path: '/complementary/new',
        builder: (context, state) => const ComplementaryActivityFormPage(),
      ),
      GoRoute(
        path: '/complementary/:id/edit',
        builder: (context, state) => ComplementaryActivityFormPage(
          activityId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: '/internships/new',
        builder: (context, state) => const InternshipFormPage(),
      ),
      GoRoute(
        path: '/internships/:id/edit',
        builder: (context, state) => InternshipFormPage(
          internshipId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: '/extensions/new',
        builder: (context, state) => const ExtensionActivityFormPage(),
      ),
      GoRoute(
        path: '/extensions/:id/edit',
        builder: (context, state) => ExtensionActivityFormPage(
          activityId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: '/study/subjects/new',
        builder: (context, state) => const StudySubjectFormPage(),
      ),
      GoRoute(
        path: '/study/subjects/:id/edit',
        builder: (context, state) => StudySubjectFormPage(
          subjectId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: '/study/subjects/:subjectId/topics',
        builder: (context, state) => StudyTopicsPage(
          subjectId: state.pathParameters['subjectId']!,
        ),
      ),
      GoRoute(
        path: '/study/subjects/:subjectId/topics/new',
        builder: (context, state) => StudyTopicFormPage(
          subjectId: state.pathParameters['subjectId']!,
        ),
      ),
      GoRoute(
        path: '/study/subjects/:subjectId/topics/:topicId/edit',
        builder: (context, state) => StudyTopicFormPage(
          subjectId: state.pathParameters['subjectId']!,
          topicId: state.pathParameters['topicId'],
        ),
      ),
      GoRoute(
        path: '/study/tasks/new',
        builder: (context, state) => const StudyTaskFormPage(),
      ),
      GoRoute(
        path: '/study/tasks/:id/edit',
        builder: (context, state) => StudyTaskFormPage(
          taskId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: '/study/sessions/new',
        builder: (context, state) => const StudySessionFormPage(),
      ),
      GoRoute(
        path: '/study/sessions/:id/edit',
        builder: (context, state) => StudySessionFormPage(
          sessionId: state.pathParameters['id'],
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Rota nao encontrada: ${state.uri}'),
      ),
    ),
  );
});
