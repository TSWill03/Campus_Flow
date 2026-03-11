import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campus_flow/core/backup/backup_bundle.dart';
import 'package:campus_flow/core/backup/backup_service.dart';
import 'package:campus_flow/core/attachments/drift_attachment_repository.dart';
import 'package:campus_flow/core/database/app_database.dart';
import 'package:campus_flow/core/sync/sync_queue_service.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/academic_profile/data/repositories/drift_academic_profile_repository.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/academic_profile.dart';
import 'package:campus_flow/features/complementary_hours/data/repositories/drift_complementary_activity_repository.dart';
import 'package:campus_flow/features/course_subjects/data/repositories/drift_course_subject_repository.dart';
import 'package:campus_flow/features/course_subjects/domain/entities/course_subject.dart';
import 'package:campus_flow/features/extension_activities/data/repositories/drift_extension_activity_repository.dart';
import 'package:campus_flow/features/internships/data/repositories/drift_internship_repository.dart';
import 'package:campus_flow/features/study_manager/data/repositories/drift_study_manager_repository.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BackupService', () {
    late AppDatabase database;
    late SharedPreferences preferences;
    late SyncQueueService syncQueueService;
    late DriftAcademicProfileRepository academicRepository;
    late DriftCourseSubjectRepository courseRepository;
    late DriftAttachmentRepository attachmentRepository;
    late BackupService backupService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      preferences = await SharedPreferences.getInstance();
      database = AppDatabase(executor: NativeDatabase.memory());
      syncQueueService = SyncQueueService(
        database: database,
        sharedPreferences: preferences,
      );
      academicRepository =
          DriftAcademicProfileRepository(database, syncQueueService);
      courseRepository = DriftCourseSubjectRepository(database, syncQueueService);
      attachmentRepository =
          DriftAttachmentRepository(database, syncQueueService);
      backupService = BackupService(
        database: database,
        sharedPreferences: preferences,
        academicProfileRepository: academicRepository,
        courseSubjectRepository: courseRepository,
        attachmentRepository: attachmentRepository,
        complementaryActivityRepository:
            DriftComplementaryActivityRepository(database, syncQueueService),
        internshipRepository: DriftInternshipRepository(database, syncQueueService),
        extensionActivityRepository:
            DriftExtensionActivityRepository(database, syncQueueService),
        studyManagerRepository:
            DriftStudyManagerRepository(database, syncQueueService),
      );
    });

    tearDown(() async {
      await database.close();
    });

    test('imports backup bytes, creates restore point and restores previous data', () async {
      await academicRepository.saveProfile(
        _profile(
          id: 'profile-old',
          profileName: 'UFRJ Medicina',
          updatedAt: DateTime(2026, 3, 11, 8),
        ),
      );

      final incomingProfile = _profile(
        id: 'profile-new',
        profileName: 'USP Mestrado',
        courseName: 'Saude Publica',
        institution: 'USP',
        updatedAt: DateTime(2026, 3, 11, 9),
        isActive: true,
      );
      final incomingSubject = CourseSubject(
        id: 'subject-1',
        createdAt: DateTime(2026, 3, 1),
        updatedAt: DateTime(2026, 3, 11, 9),
        syncStatus: SyncStatus.pendingCreate,
        isDeleted: false,
        academicProfileId: incomingProfile.id,
        name: 'Metodologia de Pesquisa',
        code: 'MET-101',
        workloadHours: 90,
        electiveHours: 45,
        suggestedSemester: 1,
        type: CourseSubjectType.elective,
        status: CourseSubjectStatus.inProgress,
        notes: 'Disciplina optativa do programa.',
      );

      final incomingBundle = BackupBundle(
        schemaVersion: database.schemaVersion,
        exportedAt: DateTime(2026, 3, 11, 10),
        academicProfiles: [incomingProfile],
        courseSubjects: [incomingSubject],
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

      final imported = await backupService.importBackupBytes(
        utf8.encode(jsonEncode(incomingBundle.toJson())),
      );

      expect(imported, isTrue);
      expect(await backupService.hasTemporaryRestorePoint(), isTrue);
      expect(
        (await academicRepository.getAllProfiles()).map((profile) => profile.id),
        contains('profile-new'),
      );
      expect(
        (await courseRepository.getAllSubjects()).single.electiveHours,
        45,
      );

      final restored = await backupService.restoreTemporaryRestorePoint();

      expect(restored, isTrue);
      expect(await backupService.hasTemporaryRestorePoint(), isFalse);
      expect(
        (await academicRepository.getAllProfiles()).map((profile) => profile.id),
        contains('profile-old'),
      );
      expect(
        (await academicRepository.getAllProfiles()).map((profile) => profile.id),
        isNot(contains('profile-new')),
      );
    });

    test('rejects backups with invalid academic profile references', () async {
      final invalidBundle = BackupBundle(
        schemaVersion: database.schemaVersion,
        exportedAt: DateTime(2026, 3, 11, 10),
        academicProfiles: const [],
        courseSubjects: [
          CourseSubject(
            id: 'subject-invalid',
            createdAt: DateTime(2026, 3, 1),
            updatedAt: DateTime(2026, 3, 11, 10),
            syncStatus: SyncStatus.pendingCreate,
            isDeleted: false,
            academicProfileId: 'missing-profile',
            name: 'Topicos Avancados',
            workloadHours: 60,
            type: CourseSubjectType.elective,
            status: CourseSubjectStatus.notStarted,
          ),
        ],
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

      expect(
        () => backupService.importBackupBytes(
          utf8.encode(jsonEncode(invalidBundle.toJson())),
        ),
        throwsA(isA<BackupValidationException>()),
      );
    });
  });
}

AcademicProfile _profile({
  required String id,
  required String profileName,
  String courseName = 'Engenharia',
  String institution = 'UFRJ',
  required DateTime updatedAt,
  bool isActive = true,
}) {
  return AcademicProfile(
    id: id,
    createdAt: updatedAt.subtract(const Duration(days: 15)),
    updatedAt: updatedAt,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    profileName: profileName,
    courseName: courseName,
    institution: institution,
    schoolName: 'Centro Tecnologico',
    campus: 'Principal',
    degreeLabel: 'Pos-graduacao',
    isActive: isActive,
    totalCourseHours: 1800,
    semesterCount: 4,
    requiredComplementaryHours: 60,
    requiredInternshipHours: 0,
    requiredExtensionHours: 30,
  );
}
