// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../attachments/attachment_owner_type.dart';
import '../attachments/attachment_providers.dart';
import '../attachments/attachment_repository.dart';
import '../attachments/stored_attachment.dart';
import '../../features/academic_profile/domain/entities/academic_profile.dart';
import '../../features/academic_profile/domain/repositories/academic_profile_repository.dart';
import '../../features/academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../features/complementary_hours/domain/entities/complementary_activity.dart';
import '../../features/complementary_hours/domain/repositories/complementary_activity_repository.dart';
import '../../features/complementary_hours/presentation/providers/complementary_activities_provider.dart';
import '../../features/course_subjects/domain/entities/course_subject.dart';
import '../../features/course_subjects/domain/entities/course_subject_lesson.dart';
import '../../features/course_subjects/domain/repositories/course_subject_repository.dart';
import '../../features/course_subjects/presentation/providers/course_subjects_provider.dart';
import '../../features/extension_activities/domain/entities/extension_activity.dart';
import '../../features/extension_activities/domain/repositories/extension_activity_repository.dart';
import '../../features/extension_activities/presentation/providers/extension_activities_provider.dart';
import '../../features/internships/domain/entities/internship_record.dart';
import '../../features/internships/domain/repositories/internship_repository.dart';
import '../../features/internships/presentation/providers/internships_provider.dart';
import '../../features/study_manager/domain/entities/study_session.dart';
import '../../features/study_manager/domain/entities/study_subject.dart';
import '../../features/study_manager/domain/entities/study_task.dart';
import '../../features/study_manager/domain/entities/study_topic.dart';
import '../../features/study_manager/domain/repositories/study_manager_repository.dart';
import '../../features/study_manager/presentation/providers/study_manager_provider.dart';
import '../database/app_database.dart';
import '../database/database_providers.dart';
import 'backup_bundle.dart';

enum BackupImportMode { replaceAll, merge }

class BackupValidationException implements Exception {
  const BackupValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}

class BackupService {
  BackupService({
    required AppDatabase database,
    required SharedPreferences sharedPreferences,
    required AcademicProfileRepository academicProfileRepository,
    required CourseSubjectRepository courseSubjectRepository,
    required AttachmentRepository attachmentRepository,
    required ComplementaryActivityRepository complementaryActivityRepository,
    required InternshipRepository internshipRepository,
    required ExtensionActivityRepository extensionActivityRepository,
    required StudyManagerRepository studyManagerRepository,
  }) : _database = database,
       _sharedPreferences = sharedPreferences,
       _academicProfileRepository = academicProfileRepository,
       _courseSubjectRepository = courseSubjectRepository,
       _attachmentRepository = attachmentRepository,
       _complementaryActivityRepository = complementaryActivityRepository,
       _internshipRepository = internshipRepository,
       _extensionActivityRepository = extensionActivityRepository,
       _studyManagerRepository = studyManagerRepository;

  static const _restorePointKey = 'backup_restore_point_json';
  static const _restorePointCreatedAtKey = 'backup_restore_point_created_at';

  final AppDatabase _database;
  final SharedPreferences _sharedPreferences;
  final AcademicProfileRepository _academicProfileRepository;
  final CourseSubjectRepository _courseSubjectRepository;
  final AttachmentRepository _attachmentRepository;
  final ComplementaryActivityRepository _complementaryActivityRepository;
  final InternshipRepository _internshipRepository;
  final ExtensionActivityRepository _extensionActivityRepository;
  final StudyManagerRepository _studyManagerRepository;

  Future<String?> exportBackup() async {
    final bundle = await _buildBundle();
    final fileName =
        'campusflow_backup_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.json';
    final bytes = Uint8List.fromList(
      utf8.encode(const JsonEncoder.withIndent('  ').convert(bundle.toJson())),
    );

    return FilePicker.platform.saveFile(
      dialogTitle: 'Salvar backup',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: const ['json'],
      bytes: bytes,
    );
  }

  Future<bool> importBackup({
    BackupImportMode mode = BackupImportMode.replaceAll,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
      withData: true,
    );

    if (result == null || result.xFiles.isEmpty) {
      return false;
    }

    final bytes = await result.xFiles.single.readAsBytes();
    return importBackupBytes(bytes, mode: mode);
  }

  Future<bool> importBackupBytes(
    List<int> bytes, {
    BackupImportMode mode = BackupImportMode.replaceAll,
  }) async {
    final bundle = _parseBundle(bytes);
    _validateBundle(bundle);

    if (mode == BackupImportMode.replaceAll) {
      await _saveTemporaryRestorePoint();
    }

    await _applyBundle(bundle, mode: mode);
    return true;
  }

  Future<bool> hasTemporaryRestorePoint() async {
    return _sharedPreferences.containsKey(_restorePointKey);
  }

  Future<DateTime?> getTemporaryRestorePointCreatedAt() async {
    final rawValue = _sharedPreferences.getString(_restorePointCreatedAtKey);
    if (rawValue == null || rawValue.isEmpty) {
      return null;
    }

    return DateTime.tryParse(rawValue);
  }

  Future<bool> restoreTemporaryRestorePoint() async {
    final rawJson = _sharedPreferences.getString(_restorePointKey);
    if (rawJson == null || rawJson.isEmpty) {
      return false;
    }

    final bundle = _parseBundle(utf8.encode(rawJson));
    _validateBundle(bundle);
    await _applyBundle(bundle, mode: BackupImportMode.replaceAll);
    await clearTemporaryRestorePoint();
    return true;
  }

  Future<void> clearTemporaryRestorePoint() async {
    await _sharedPreferences.remove(_restorePointKey);
    await _sharedPreferences.remove(_restorePointCreatedAtKey);
  }

  Future<BackupBundle> _buildBundle() async {
    return BackupBundle(
      schemaVersion: _database.schemaVersion,
      exportedAt: DateTime.now(),
      academicProfiles: await _academicProfileRepository.getAllProfiles(),
      courseSubjects: await _courseSubjectRepository.getAllSubjects(),
      courseSubjectLessons: await _courseSubjectRepository.getAllLessons(),
      attachments: await _attachmentRepository.getAllAttachments(),
      complementaryActivities: await _complementaryActivityRepository
          .getAllActivities(),
      internships: await _internshipRepository.getAllInternships(),
      extensionActivities: await _extensionActivityRepository
          .getAllActivities(),
      studySubjects: await _studyManagerRepository.getAllSubjects(),
      studyTopics: await _studyManagerRepository.getAllTopics(),
      studyTasks: await _studyManagerRepository.getAllTasks(),
      studySessions: await _studyManagerRepository.getAllSessions(),
    );
  }

  BackupBundle _parseBundle(List<int> bytes) {
    try {
      final decoded = json.decode(utf8.decode(bytes));
      if (decoded is! Map<String, dynamic>) {
        throw const BackupValidationException(
          'O arquivo selecionado nao contem um backup valido em JSON.',
        );
      }
      return BackupBundle.fromJson(decoded);
    } on FormatException {
      throw const BackupValidationException(
        'Nao foi possivel ler o arquivo JSON selecionado.',
      );
    } on TypeError {
      throw const BackupValidationException(
        'A estrutura do backup esta incompleta ou corrompida.',
      );
    }
  }

  void _validateBundle(BackupBundle bundle) {
    if (bundle.schemaVersion > _database.schemaVersion) {
      throw BackupValidationException(
        'Este backup foi gerado por uma versao mais nova do app '
        '(schema ${bundle.schemaVersion}) e nao pode ser importado aqui.',
      );
    }

    _validateUniqueIds(
      'perfis academicos',
      bundle.academicProfiles,
      (item) => item.id,
    );
    _validateUniqueIds('disciplinas', bundle.courseSubjects, (item) => item.id);
    _validateUniqueIds(
      'aulas das disciplinas',
      bundle.courseSubjectLessons,
      (item) => item.id,
    );
    _validateUniqueIds('anexos', bundle.attachments, (item) => item.id);
    _validateUniqueIds(
      'atividades complementares',
      bundle.complementaryActivities,
      (item) => item.id,
    );
    _validateUniqueIds('estagios', bundle.internships, (item) => item.id);
    _validateUniqueIds(
      'atividades de extensao',
      bundle.extensionActivities,
      (item) => item.id,
    );
    _validateUniqueIds(
      'materias de estudo',
      bundle.studySubjects,
      (item) => item.id,
    );
    _validateUniqueIds('topicos', bundle.studyTopics, (item) => item.id);
    _validateUniqueIds('tarefas', bundle.studyTasks, (item) => item.id);
    _validateUniqueIds('sessoes', bundle.studySessions, (item) => item.id);

    final academicProfileIds = bundle.academicProfiles
        .map((item) => item.id)
        .toSet();
    final courseSubjectIds = bundle.courseSubjects
        .map((item) => item.id)
        .toSet();
    final lessonIds = bundle.courseSubjectLessons
        .map((item) => item.id)
        .toSet();
    final complementaryIds = bundle.complementaryActivities
        .map((item) => item.id)
        .toSet();
    final internshipIds = bundle.internships.map((item) => item.id).toSet();
    final studySubjectIds = bundle.studySubjects.map((item) => item.id).toSet();
    final studyTopicIds = bundle.studyTopics.map((item) => item.id).toSet();

    _validateAcademicProfileLinks(
      bundle.courseSubjects,
      academicProfileIds,
      (item) => item.academicProfileId,
    );
    _validateAcademicProfileLinks(
      bundle.complementaryActivities,
      academicProfileIds,
      (item) => item.academicProfileId,
    );
    _validateAcademicProfileLinks(
      bundle.internships,
      academicProfileIds,
      (item) => item.academicProfileId,
    );
    _validateAcademicProfileLinks(
      bundle.extensionActivities,
      academicProfileIds,
      (item) => item.academicProfileId,
    );
    for (final lesson in bundle.courseSubjectLessons) {
      if (!courseSubjectIds.contains(lesson.courseSubjectId)) {
        throw const BackupValidationException(
          'O backup contem aulas vinculadas a uma disciplina inexistente.',
        );
      }
    }

    for (final attachment in bundle.attachments) {
      final ownerExists = switch (attachment.ownerType) {
        AttachmentOwnerType.courseSubjectLesson => lessonIds.contains(
          attachment.ownerId,
        ),
        AttachmentOwnerType.complementaryActivity => complementaryIds.contains(
          attachment.ownerId,
        ),
        AttachmentOwnerType.internshipRecord => internshipIds.contains(
          attachment.ownerId,
        ),
      };

      if (!ownerExists) {
        throw const BackupValidationException(
          'O backup contem anexos vinculados a um registro inexistente.',
        );
      }
    }

    for (final topic in bundle.studyTopics) {
      if (!studySubjectIds.contains(topic.studySubjectId)) {
        throw BackupValidationException(
          'O topico "${topic.name}" referencia uma materia de estudo inexistente.',
        );
      }
    }

    for (final task in bundle.studyTasks) {
      if (task.studySubjectId != null &&
          !studySubjectIds.contains(task.studySubjectId)) {
        throw BackupValidationException(
          'A tarefa "${task.title}" referencia uma materia de estudo inexistente.',
        );
      }
    }

    for (final session in bundle.studySessions) {
      if (session.studySubjectId != null &&
          !studySubjectIds.contains(session.studySubjectId)) {
        throw const BackupValidationException(
          'Uma sessao de estudo referencia uma materia inexistente.',
        );
      }
      if (session.studyTopicId != null &&
          !studyTopicIds.contains(session.studyTopicId)) {
        throw const BackupValidationException(
          'Uma sessao de estudo referencia um topico inexistente.',
        );
      }
    }
  }

  void _validateUniqueIds<T>(
    String label,
    Iterable<T> items,
    String Function(T item) pickId,
  ) {
    final ids = <String>{};
    for (final item in items) {
      final id = pickId(item);
      if (id.isEmpty) {
        throw BackupValidationException(
          'O backup contem $label com identificador vazio.',
        );
      }
      if (!ids.add(id)) {
        throw BackupValidationException(
          'O backup contem ids duplicados em $label.',
        );
      }
    }
  }

  void _validateAcademicProfileLinks<T>(
    Iterable<T> items,
    Set<String> profileIds,
    String? Function(T item) pickProfileId,
  ) {
    for (final item in items) {
      final profileId = pickProfileId(item);
      if (profileId != null && !profileIds.contains(profileId)) {
        throw const BackupValidationException(
          'O backup contem registros vinculados a um perfil academico inexistente.',
        );
      }
    }
  }

  Future<void> _saveTemporaryRestorePoint() async {
    final snapshot = await _buildBundle();
    final snapshotJson = const JsonEncoder.withIndent(
      '  ',
    ).convert(snapshot.toJson());
    await _sharedPreferences.setString(_restorePointKey, snapshotJson);
    await _sharedPreferences.setString(
      _restorePointCreatedAtKey,
      DateTime.now().toIso8601String(),
    );
  }

  Future<void> _applyBundle(
    BackupBundle bundle, {
    required BackupImportMode mode,
  }) async {
    await _database.transaction(() async {
      if (mode == BackupImportMode.replaceAll) {
        await _database.delete(_database.syncQueueEntries).go();
        await _database.delete(_database.studySessions).go();
        await _database.delete(_database.studyTasks).go();
        await _database.delete(_database.studyTopics).go();
        await _database.delete(_database.studySubjects).go();
        await _database.delete(_database.attachments).go();
        await _database.delete(_database.extensionActivities).go();
        await _database.delete(_database.internships).go();
        await _database.delete(_database.complementaryActivities).go();
        await _database.delete(_database.courseSubjectLessons).go();
        await _database.delete(_database.courseSubjects).go();
        await _database.delete(_database.academicProfiles).go();
      }

      await _database.batch((batch) {
        batch.insertAll(
          _database.academicProfiles,
          bundle.academicProfiles.map(_profileCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.courseSubjects,
          bundle.courseSubjects.map(_courseSubjectCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.courseSubjectLessons,
          bundle.courseSubjectLessons
              .map(_courseSubjectLessonCompanion)
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.attachments,
          bundle.attachments.map(_attachmentCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.complementaryActivities,
          bundle.complementaryActivities.map(_complementaryCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.internships,
          bundle.internships.map(_internshipCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.extensionActivities,
          bundle.extensionActivities.map(_extensionCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.studySubjects,
          bundle.studySubjects.map(_studySubjectCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.studyTopics,
          bundle.studyTopics.map(_studyTopicCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.studyTasks,
          bundle.studyTasks.map(_studyTaskCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _database.studySessions,
          bundle.studySessions.map(_studySessionCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  AcademicProfilesCompanion _profileCompanion(AcademicProfile profile) =>
      AcademicProfilesCompanion(
        id: Value(profile.id),
        remoteId: Value(profile.remoteId),
        createdAt: Value(profile.createdAt),
        updatedAt: Value(profile.updatedAt),
        syncStatus: Value(profile.syncStatus.name),
        isDeleted: Value(profile.isDeleted),
        profileName: Value(profile.profileName),
        courseName: Value(profile.courseName),
        institution: Value(profile.institution),
        schoolName: Value(profile.schoolName),
        campus: Value(profile.campus),
        degreeLabel: Value(profile.degreeLabel),
        isActive: Value(profile.isActive),
        totalCourseHours: Value(profile.totalCourseHours),
        semesterCount: Value(profile.semesterCount),
        requiredComplementaryHours: Value(profile.requiredComplementaryHours),
        requiredInternshipHours: Value(profile.requiredInternshipHours),
        requiredExtensionHours: Value(profile.requiredExtensionHours),
      );

  CourseSubjectsCompanion _courseSubjectCompanion(CourseSubject subject) =>
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
          jsonEncode(subject.prerequisiteSubjectIds),
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
      );

  CourseSubjectLessonsCompanion _courseSubjectLessonCompanion(
    CourseSubjectLesson lesson,
  ) => CourseSubjectLessonsCompanion(
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
      lesson.pdfBytes == null ? null : Uint8List.fromList(lesson.pdfBytes!),
    ),
    wasAbsent: Value(lesson.wasAbsent),
  );

  AttachmentsCompanion _attachmentCompanion(StoredAttachment attachment) =>
      AttachmentsCompanion(
        id: Value(attachment.id),
        remoteId: Value(attachment.remoteId),
        createdAt: Value(attachment.createdAt),
        updatedAt: Value(attachment.updatedAt),
        syncStatus: Value(attachment.syncStatus.name),
        isDeleted: Value(attachment.isDeleted),
        ownerType: Value(attachment.ownerType.dbValue),
        ownerId: Value(attachment.ownerId),
        fileName: Value(attachment.fileName),
        fileBytes: Value(Uint8List.fromList(attachment.bytes)),
        mimeType: Value(attachment.mimeType),
        category: Value(attachment.category.name),
        dueDate: Value(attachment.dueDate),
        isCompleted: Value(attachment.isCompleted),
      );

  ComplementaryActivitiesCompanion _complementaryCompanion(
    ComplementaryActivity activity,
  ) => ComplementaryActivitiesCompanion(
    id: Value(activity.id),
    remoteId: Value(activity.remoteId),
    createdAt: Value(activity.createdAt),
    updatedAt: Value(activity.updatedAt),
    syncStatus: Value(activity.syncStatus.name),
    isDeleted: Value(activity.isDeleted),
    academicProfileId: Value(activity.academicProfileId),
    title: Value(activity.title),
    category: Value(activity.category),
    date: Value(activity.date),
    endDate: Value(activity.endDate),
    workloadHours: Value(activity.workloadHours),
    notes: Value(activity.notes),
    status: Value(activity.status.name),
  );

  InternshipsCompanion _internshipCompanion(InternshipRecord internship) =>
      InternshipsCompanion(
        id: Value(internship.id),
        remoteId: Value(internship.remoteId),
        createdAt: Value(internship.createdAt),
        updatedAt: Value(internship.updatedAt),
        syncStatus: Value(internship.syncStatus.name),
        isDeleted: Value(internship.isDeleted),
        academicProfileId: Value(internship.academicProfileId),
        location: Value(internship.location),
        supervisor: Value(internship.supervisor),
        startDate: Value(internship.startDate),
        endDate: Value(internship.endDate),
        totalHours: Value(internship.totalHours),
        completedHours: Value(internship.completedHours),
        status: Value(internship.status.name),
        notes: Value(internship.notes),
      );

  ExtensionActivitiesCompanion _extensionCompanion(
    ExtensionActivity activity,
  ) => ExtensionActivitiesCompanion(
    id: Value(activity.id),
    remoteId: Value(activity.remoteId),
    createdAt: Value(activity.createdAt),
    updatedAt: Value(activity.updatedAt),
    syncStatus: Value(activity.syncStatus.name),
    isDeleted: Value(activity.isDeleted),
    academicProfileId: Value(activity.academicProfileId),
    title: Value(activity.title),
    type: Value(activity.type),
    date: Value(activity.date),
    workloadHours: Value(activity.workloadHours),
    notes: Value(activity.notes),
    status: Value(activity.status.name),
  );

  StudySubjectsCompanion _studySubjectCompanion(StudySubject subject) =>
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
      );

  StudyTopicsCompanion _studyTopicCompanion(StudyTopic topic) =>
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
      );

  StudyTasksCompanion _studyTaskCompanion(StudyTask task) =>
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
      );

  StudySessionsCompanion _studySessionCompanion(StudySession session) =>
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
      );
}

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(
    database: ref.watch(appDatabaseProvider),
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    academicProfileRepository: ref.watch(academicProfileRepositoryProvider),
    courseSubjectRepository: ref.watch(courseSubjectRepositoryProvider),
    attachmentRepository: ref.watch(attachmentRepositoryProvider),
    complementaryActivityRepository: ref.watch(
      complementaryActivityRepositoryProvider,
    ),
    internshipRepository: ref.watch(internshipRepositoryProvider),
    extensionActivityRepository: ref.watch(extensionActivityRepositoryProvider),
    studyManagerRepository: ref.watch(studyManagerRepositoryProvider),
  );
});

final backupRestorePointAvailableProvider = FutureProvider<bool>((ref) {
  return ref.watch(backupServiceProvider).hasTemporaryRestorePoint();
});

final backupRestorePointCreatedAtProvider = FutureProvider<DateTime?>((ref) {
  return ref.watch(backupServiceProvider).getTemporaryRestorePointCreatedAt();
});
