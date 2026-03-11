import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/core/backup/backup_bundle.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/academic_profile.dart';

void main() {
  test('backup bundle keeps schema version and extended profile fields', () {
    final bundle = BackupBundle(
      schemaVersion: 3,
      exportedAt: DateTime(2026, 3, 11, 12),
      academicProfiles: [
        AcademicProfile(
          id: 'profile-1',
          createdAt: DateTime(2026, 1, 1),
          updatedAt: DateTime(2026, 3, 11, 12),
          syncStatus: SyncStatus.pendingCreate,
          isDeleted: false,
          profileName: 'USP Doutorado',
          courseName: 'Engenharia Eletrica',
          institution: 'USP',
          schoolName: 'POLI',
          campus: 'Butanta',
          degreeLabel: 'Doutorado',
          isActive: true,
          totalCourseHours: 2400,
          semesterCount: 8,
          requiredComplementaryHours: 120,
          requiredInternshipHours: 0,
          requiredExtensionHours: 60,
        ),
      ],
      courseSubjects: const [],
      courseSubjectLessons: const [],
      attachments: const [],
      complementaryActivities: const [],
      internships: const [],
      extensionActivities: const [],
      studySubjects: const [],
      studyTopics: const [],
      studyTasks: const [],
      studySessions: const [],
    );

    final rehydrated = BackupBundle.fromJson(bundle.toJson());

    expect(rehydrated.schemaVersion, 3);
    expect(rehydrated.academicProfiles.single.profileName, 'USP Doutorado');
    expect(rehydrated.academicProfiles.single.schoolName, 'POLI');
    expect(rehydrated.academicProfiles.single.degreeLabel, 'Doutorado');
  });
}
