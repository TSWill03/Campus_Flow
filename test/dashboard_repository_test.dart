// Signature: dev.tswicolly03

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/core/database/app_database.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/dashboard/data/repositories/drift_dashboard_repository.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DriftDashboardRepository', () {
    late AppDatabase database;
    late DriftDashboardRepository repository;

    setUp(() {
      database = AppDatabase(executor: NativeDatabase.memory());
      repository = DriftDashboardRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test(
      'ignores orphaned academic records when there is no active profile',
      () async {
        final now = DateTime(2026, 3, 20, 14);
        await database
            .into(database.academicProfiles)
            .insert(
              AcademicProfilesCompanion.insert(
                id: 'profile-1',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                profileName: const Value('Perfil apagado'),
                courseName: 'BCC',
                institution: 'IF',
                totalCourseHours: 3200,
                semesterCount: 8,
                requiredComplementaryHours: 100,
                requiredInternshipHours: 0,
                requiredExtensionHours: 320,
                isDeleted: const Value(true),
              ),
            );
        await database
            .into(database.courseSubjects)
            .insert(
              CourseSubjectsCompanion.insert(
                id: 'subject-1',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                academicProfileId: const Value('profile-1'),
                name: 'Algoritmos',
                workloadHours: 72,
                type: CourseSubjectType.mandatory.name,
                status: CourseSubjectStatus.completed.name,
              ),
            );
        await database
            .into(database.studySessions)
            .insert(
              StudySessionsCompanion.insert(
                id: 'session-1',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                startedAt: now,
                endedAt: now.add(const Duration(minutes: 50)),
                durationMinutes: 50,
              ),
            );

        final summary = await repository.watchSummary().first;

        expect(summary.totalSubjects, 0);
        expect(summary.completedSubjects, 0);
        expect(summary.pendingSubjects, 0);
        expect(summary.courseCompletionPercentage, 0);
        expect(summary.totalStudySessions, 1);
        expect(summary.totalStudyMinutes, 50);
      },
    );
  });
}
