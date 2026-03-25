// Signature: dev.tswicolly03

import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campus_flow/core/database/app_database.dart';
import 'package:campus_flow/core/attachments/attachment_owner_type.dart';
import 'package:campus_flow/core/sync/sync_queue_service.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/academic_profile/data/repositories/drift_academic_profile_repository.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/academic_profile.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DriftAcademicProfileRepository', () {
    late AppDatabase database;
    late SyncQueueService syncQueueService;
    late DriftAcademicProfileRepository repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      database = AppDatabase(executor: NativeDatabase.memory());
      syncQueueService = SyncQueueService(
        database: database,
        sharedPreferences: preferences,
      );
      repository = DriftAcademicProfileRepository(database, syncQueueService);
    });

    tearDown(() async {
      await database.close();
    });

    test('keeps a single active profile and enqueues outbox entries', () async {
      final firstProfile = _buildProfile(
        id: 'profile-1',
        updatedAt: DateTime(2026, 3, 11, 8),
        isActive: true,
      );
      final secondProfile = _buildProfile(
        id: 'profile-2',
        profileName: 'USP Mestrado',
        courseName: 'Computacao Aplicada',
        institution: 'USP',
        updatedAt: DateTime(2026, 3, 11, 9),
        isActive: true,
      );

      await repository.saveProfile(firstProfile);
      await repository.saveProfile(secondProfile);

      final activeProfile = await repository.getActiveProfile();
      final profiles = await repository.getAllProfiles();
      final queueEntries = await database
          .select(database.syncQueueEntries)
          .get();

      expect(activeProfile?.id, secondProfile.id);
      expect(profiles.where((profile) => profile.isActive), hasLength(1));
      expect(
        profiles
            .firstWhere((profile) => profile.id == firstProfile.id)
            .isActive,
        isFalse,
      );
      expect(queueEntries, hasLength(2));
      expect(
        queueEntries.every((entry) => entry.operation == 'upsert'),
        isTrue,
      );
      expect(queueEntries.every((entry) => entry.entityVersion > 0), isTrue);
    });

    test(
      'deletes related academic data and clears aproveitamento links from other profiles',
      () async {
        final firstProfile = _buildProfile(
          id: 'profile-1',
          updatedAt: DateTime(2026, 3, 11, 8),
          isActive: true,
        );
        final secondProfile = _buildProfile(
          id: 'profile-2',
          profileName: 'Segunda graduacao',
          courseName: 'Sistemas de Informacao',
          institution: 'IF Goiano',
          updatedAt: DateTime(2026, 3, 11, 9),
        );

        await repository.saveProfile(firstProfile);
        await repository.saveProfile(secondProfile);

        final now = DateTime(2026, 3, 12, 10);
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
            .into(database.courseSubjectLessons)
            .insert(
              CourseSubjectLessonsCompanion.insert(
                id: 'lesson-1',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                courseSubjectId: 'subject-1',
                lessonDate: now,
                lessonHours: 2,
                coveredContent: 'Introducao',
              ),
            );
        await database
            .into(database.attachments)
            .insert(
              AttachmentsCompanion.insert(
                id: 'attachment-lesson',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                ownerType: AttachmentOwnerType.courseSubjectLesson.dbValue,
                ownerId: 'lesson-1',
                fileName: 'slide.pdf',
                fileBytes: Uint8List.fromList(const [1, 2, 3]),
                category: 'document',
              ),
            );
        await database
            .into(database.complementaryActivities)
            .insert(
              ComplementaryActivitiesCompanion.insert(
                id: 'comp-1',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                academicProfileId: const Value('profile-1'),
                title: 'Evento',
                category: 'Palestra',
                date: now,
                workloadHours: 8,
                status: ValidationStatus.approved.name,
              ),
            );
        await database
            .into(database.attachments)
            .insert(
              AttachmentsCompanion.insert(
                id: 'attachment-comp',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                ownerType: AttachmentOwnerType.complementaryActivity.dbValue,
                ownerId: 'comp-1',
                fileName: 'certificado.pdf',
                fileBytes: Uint8List.fromList(const [4, 5, 6]),
                category: 'document',
              ),
            );
        await database
            .into(database.internships)
            .insert(
              InternshipsCompanion.insert(
                id: 'internship-1',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                academicProfileId: const Value('profile-1'),
                location: 'Empresa X',
                startDate: now,
                totalHours: 300,
                completedHours: 120,
                status: InternshipStatus.inProgress.name,
              ),
            );
        await database
            .into(database.attachments)
            .insert(
              AttachmentsCompanion.insert(
                id: 'attachment-internship',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                ownerType: AttachmentOwnerType.internshipRecord.dbValue,
                ownerId: 'internship-1',
                fileName: 'termo.pdf',
                fileBytes: Uint8List.fromList(const [7, 8, 9]),
                category: 'document',
              ),
            );
        await database
            .into(database.extensionActivities)
            .insert(
              ExtensionActivitiesCompanion.insert(
                id: 'extension-1',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                academicProfileId: const Value('profile-1'),
                title: 'Projeto',
                type: 'Extensao',
                date: now,
                workloadHours: 40,
                status: ValidationStatus.approved.name,
              ),
            );
        await database
            .into(database.courseSubjects)
            .insert(
              CourseSubjectsCompanion.insert(
                id: 'subject-2',
                createdAt: now,
                updatedAt: now,
                syncStatus: SyncStatus.synced.name,
                academicProfileId: const Value('profile-2'),
                name: 'Algoritmos na segunda graduacao',
                workloadHours: 72,
                type: CourseSubjectType.mandatory.name,
                status: CourseSubjectStatus.notStarted.name,
                creditSourceSubjectId: const Value('subject-1'),
                creditSourceProfileId: const Value('profile-1'),
                creditStatus: Value(CourseSubjectCreditStatus.requested.name),
                creditMatchScore: const Value(0.91),
              ),
            );

        await repository.deleteProfile('profile-1');

        final deletedProfile = await repository.findById('profile-1');
        final remainingProfile = await repository.getActiveProfile();
        final deletedSubject = await (database.select(
          database.courseSubjects,
        )..where((table) => table.id.equals('subject-1'))).getSingle();
        final linkedSubject = await (database.select(
          database.courseSubjects,
        )..where((table) => table.id.equals('subject-2'))).getSingle();
        final deletedLesson = await (database.select(
          database.courseSubjectLessons,
        )..where((table) => table.id.equals('lesson-1'))).getSingle();
        final deletedLessonAttachment = await (database.select(
          database.attachments,
        )..where((table) => table.id.equals('attachment-lesson'))).getSingle();
        final deletedCompAttachment = await (database.select(
          database.attachments,
        )..where((table) => table.id.equals('attachment-comp'))).getSingle();
        final deletedInternshipAttachment =
            await (database.select(database.attachments)
                  ..where((table) => table.id.equals('attachment-internship')))
                .getSingle();
        final deletedComplementary = await (database.select(
          database.complementaryActivities,
        )..where((table) => table.id.equals('comp-1'))).getSingle();
        final deletedInternship = await (database.select(
          database.internships,
        )..where((table) => table.id.equals('internship-1'))).getSingle();
        final deletedExtension = await (database.select(
          database.extensionActivities,
        )..where((table) => table.id.equals('extension-1'))).getSingle();

        expect(deletedProfile?.isDeleted, isTrue);
        expect(remainingProfile?.id, 'profile-2');
        expect(deletedSubject.isDeleted, isTrue);
        expect(deletedLesson.isDeleted, isTrue);
        expect(deletedLessonAttachment.isDeleted, isTrue);
        expect(deletedCompAttachment.isDeleted, isTrue);
        expect(deletedInternshipAttachment.isDeleted, isTrue);
        expect(deletedComplementary.isDeleted, isTrue);
        expect(deletedInternship.isDeleted, isTrue);
        expect(deletedExtension.isDeleted, isTrue);
        expect(linkedSubject.isDeleted, isFalse);
        expect(linkedSubject.creditSourceSubjectId, isNull);
        expect(linkedSubject.creditSourceProfileId, isNull);
        expect(linkedSubject.creditStatus, CourseSubjectCreditStatus.none.name);
        expect(linkedSubject.creditMatchScore, isNull);
      },
    );
  });
}

AcademicProfile _buildProfile({
  required String id,
  String profileName = 'UFRJ Graduacao',
  String courseName = 'Engenharia',
  String institution = 'UFRJ',
  required DateTime updatedAt,
  bool isActive = false,
}) {
  return AcademicProfile(
    id: id,
    createdAt: updatedAt.subtract(const Duration(days: 30)),
    updatedAt: updatedAt,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    profileName: profileName,
    courseName: courseName,
    institution: institution,
    schoolName: 'Escola Politecnica',
    campus: 'Cidade Universitaria',
    degreeLabel: 'Graduacao',
    isActive: isActive,
    totalCourseHours: 3600,
    semesterCount: 10,
    requiredComplementaryHours: 200,
    requiredInternshipHours: 300,
    requiredExtensionHours: 120,
  );
}
