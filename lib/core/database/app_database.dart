// Signature: dev.tswicolly03

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../sync/sync_status.dart';
import '../../shared/enums/app_enums.dart';

part 'app_database.g.dart';

// Todas as tabelas de dominio seguem a mesma ideia offline-first:
// id local para funcionar sem internet, remoteId para o servidor futuro,
// timestamps para auditoria/sync, syncStatus para fila de envio e isDeleted
// para exclusao logica sem perder historico antes de sincronizar.
@DataClassName('AcademicProfileRow')
class AcademicProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get profileName => text().withDefault(const Constant(''))();
  TextColumn get courseName => text()();
  TextColumn get institution => text()();
  TextColumn get schoolName => text().nullable()();
  TextColumn get campus => text().nullable()();
  TextColumn get degreeLabel => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  IntColumn get totalCourseHours => integer()();
  IntColumn get semesterCount => integer()();
  IntColumn get requiredComplementaryHours => integer()();
  IntColumn get requiredInternshipHours => integer()();
  IntColumn get requiredExtensionHours => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const [
    'CHECK (total_course_hours >= 0)',
    'CHECK (semester_count >= 0)',
    'CHECK (required_complementary_hours >= 0)',
    'CHECK (required_internship_hours >= 0)',
    'CHECK (required_extension_hours >= 0)',
  ];
}

@DataClassName('CourseSubjectRow')
class CourseSubjects extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get academicProfileId =>
      text().nullable().references(AcademicProfiles, #id)();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  IntColumn get workloadHours => integer()();
  IntColumn get electiveHours => integer().nullable()();
  IntColumn get suggestedSemester => integer().nullable()();
  TextColumn get prerequisiteSubjectIdsJson =>
      text().withDefault(const Constant('[]'))();
  IntColumn get scheduledWeekday => integer().nullable()();
  RealColumn get defaultLessonHours => real().nullable()();
  TextColumn get type => text()();
  TextColumn get status => text()();
  TextColumn get creditSourceSubjectId => text().nullable()();
  TextColumn get creditSourceProfileId => text().nullable()();
  TextColumn get creditStatus => text().withDefault(const Constant('none'))();
  RealColumn get creditMatchScore => real().nullable()();
  TextColumn get syllabus => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const [
    'CHECK (workload_hours >= 0)',
    'CHECK (elective_hours IS NULL OR elective_hours >= 0)',
    'CHECK (scheduled_weekday IS NULL OR scheduled_weekday BETWEEN 1 AND 7)',
    'CHECK (default_lesson_hours IS NULL OR default_lesson_hours > 0)',
  ];
}

@DataClassName('CourseSubjectLessonRow')
class CourseSubjectLessons extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get courseSubjectId => text().references(CourseSubjects, #id)();
  DateTimeColumn get lessonDate => dateTime()();
  RealColumn get lessonHours => real()();
  TextColumn get coveredContent => text()();
  TextColumn get description => text().nullable()();
  TextColumn get activityDescription => text().nullable()();
  TextColumn get assessmentDescription => text().nullable()();
  DateTimeColumn get assessmentDate => dateTime().nullable()();
  TextColumn get pdfName => text().nullable()();
  BlobColumn get pdfBytes => blob().nullable()();
  BoolColumn get wasAbsent => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const ['CHECK (lesson_hours >= 0)'];
}

@DataClassName('AttachmentRow')
class Attachments extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get ownerType => text()();
  TextColumn get ownerId => text()();
  TextColumn get fileName => text()();
  BlobColumn get fileBytes => blob()();
  TextColumn get mimeType => text().nullable()();
  TextColumn get category => text()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ComplementaryActivityRow')
class ComplementaryActivities extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get academicProfileId =>
      text().nullable().references(AcademicProfiles, #id)();
  TextColumn get title => text()();
  TextColumn get category => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get workloadHours => integer()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const ['CHECK (workload_hours >= 0)'];
}

@DataClassName('InternshipRow')
class Internships extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get academicProfileId =>
      text().nullable().references(AcademicProfiles, #id)();
  TextColumn get location => text()();
  TextColumn get supervisor => text().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get totalHours => integer()();
  IntColumn get completedHours => integer()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const [
    'CHECK (total_hours >= 0)',
    'CHECK (completed_hours >= 0)',
  ];
}

@DataClassName('ExtensionActivityRow')
class ExtensionActivities extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get academicProfileId =>
      text().nullable().references(AcademicProfiles, #id)();
  TextColumn get title => text()();
  TextColumn get type => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get workloadHours => integer()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const ['CHECK (workload_hours >= 0)'];
}

@DataClassName('StudySubjectRow')
class StudySubjects extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get name => text()();
  IntColumn get colorValue => integer().nullable()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('StudyTopicRow')
class StudyTopics extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get studySubjectId => text().references(StudySubjects, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get status => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('StudyTaskRow')
class StudyTasks extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get studySubjectId =>
      text().nullable().references(StudySubjects, #id)();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get priority => text()();
  TextColumn get status => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('StudySessionRow')
class StudySessions extends Table {
  TextColumn get id => text()();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get academicProfileId =>
      text().nullable().references(AcademicProfiles, #id)();
  TextColumn get studySubjectId =>
      text().nullable().references(StudySubjects, #id)();
  TextColumn get studyTopicId =>
      text().nullable().references(StudyTopics, #id)();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  IntColumn get durationMinutes => integer()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const ['CHECK (duration_minutes >= 0)'];
}

@DataClassName('SyncQueueEntryRow')
class SyncQueueEntries extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  IntColumn get entityVersion => integer().withDefault(const Constant(1))();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get deviceId => text().nullable()();
  TextColumn get conflictPolicy =>
      text().withDefault(const Constant('client_wins'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Banco local principal do CampusFlow.
///
/// Drift gera o codigo de acesso ao SQLite a partir destas tabelas. A mesma
/// classe funciona em desktop/mobile e tambem na web via SQLite WASM.
@DriftDatabase(
  tables: [
    AcademicProfiles,
    CourseSubjects,
    CourseSubjectLessons,
    Attachments,
    ComplementaryActivities,
    Internships,
    ExtensionActivities,
    StudySubjects,
    StudyTopics,
    StudyTasks,
    StudySessions,
    SyncQueueEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor})
    : super(
        executor ??
            driftDatabase(
              name: 'campus_flow',
              web: DriftWebOptions(
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.js'),
              ),
            ),
      );

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _createIndexes();
    },
    onUpgrade: (m, from, to) async {
      // As migracoes sao incrementais: quem instalou uma versao antiga passa por
      // cada etapa necessaria ate chegar ao schema atual, sem apagar os dados.
      if (from < 2) {
        await _migrateFrom1To2(m);
      }
      if (from < 3) {
        await _migrateFrom2To3(m);
      }
      if (from < 4) {
        await _migrateFrom3To4(m);
      }
      if (from < 5) {
        await _migrateFrom4To5(m);
      }
      if (from < 6) {
        await _migrateFrom5To6(m);
      }
      if (from < 7) {
        await _migrateFrom6To7(m);
      }
      if (from < 8) {
        await _migrateFrom7To8(m);
      }
      if (from < 9) {
        await _migrateFrom8To9(m);
      }
      if (from < 10) {
        await _migrateFrom9To10(m);
      }
      await _createIndexes();
    },
    beforeOpen: (details) async {
      // Foreign keys e indices sao reativados sempre que o banco abre porque
      // SQLite trata algumas configuracoes por conexao.
      await customStatement('PRAGMA foreign_keys = ON');
      await _createIndexes();
      await _cleanupOrphanedAcademicData();
    },
  );

  Future<void> _migrateFrom1To2(Migrator m) async {
    await _addColumnIfMissing(
      tableName: 'academic_profiles',
      columnName: 'profile_name',
      statement:
          "ALTER TABLE academic_profiles ADD COLUMN profile_name TEXT NOT NULL DEFAULT ''",
    );
    await _addColumnIfMissing(
      tableName: 'academic_profiles',
      columnName: 'school_name',
      statement:
          "ALTER TABLE academic_profiles ADD COLUMN school_name TEXT NULL",
    );
    await _addColumnIfMissing(
      tableName: 'academic_profiles',
      columnName: 'campus',
      statement: "ALTER TABLE academic_profiles ADD COLUMN campus TEXT NULL",
    );
    await _addColumnIfMissing(
      tableName: 'academic_profiles',
      columnName: 'degree_label',
      statement:
          "ALTER TABLE academic_profiles ADD COLUMN degree_label TEXT NULL",
    );
    await _addColumnIfMissing(
      tableName: 'academic_profiles',
      columnName: 'is_active',
      statement:
          "ALTER TABLE academic_profiles ADD COLUMN is_active INTEGER NOT NULL DEFAULT 0",
    );
    await customStatement(
      "UPDATE academic_profiles SET profile_name = course_name WHERE profile_name = ''",
    );
    await customStatement(
      'UPDATE academic_profiles SET is_active = 1 WHERE id IN (SELECT id FROM academic_profiles WHERE is_deleted = 0 ORDER BY updated_at DESC LIMIT 1)',
    );

    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'academic_profile_id',
      statement:
          "ALTER TABLE course_subjects ADD COLUMN academic_profile_id TEXT NULL",
    );
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'elective_hours',
      statement:
          "ALTER TABLE course_subjects ADD COLUMN elective_hours INTEGER NULL",
    );

    await _addColumnIfMissing(
      tableName: 'complementary_activities',
      columnName: 'academic_profile_id',
      statement:
          "ALTER TABLE complementary_activities ADD COLUMN academic_profile_id TEXT NULL",
    );
    await _addColumnIfMissing(
      tableName: 'internships',
      columnName: 'academic_profile_id',
      statement:
          "ALTER TABLE internships ADD COLUMN academic_profile_id TEXT NULL",
    );
    await _addColumnIfMissing(
      tableName: 'extension_activities',
      columnName: 'academic_profile_id',
      statement:
          "ALTER TABLE extension_activities ADD COLUMN academic_profile_id TEXT NULL",
    );

    if (!await _tableExists('sync_queue_entries')) {
      await m.createTable(syncQueueEntries);
    }
  }

  Future<void> _migrateFrom2To3(Migrator m) async {
    if (!await _tableExists('sync_queue_entries')) {
      await m.createTable(syncQueueEntries);
      return;
    }

    await _addColumnIfMissing(
      tableName: 'sync_queue_entries',
      columnName: 'entity_version',
      statement:
          'ALTER TABLE sync_queue_entries ADD COLUMN entity_version INTEGER NOT NULL DEFAULT 1',
    );
  }

  Future<void> _migrateFrom3To4(Migrator m) async {
    if (!await _tableExists('course_subject_lessons')) {
      await m.createTable(courseSubjectLessons);
    }
  }

  Future<void> _migrateFrom4To5(Migrator m) async {
    if (!await _tableExists('attachments')) {
      await m.createTable(attachments);
    }

    await _addColumnIfMissing(
      tableName: 'complementary_activities',
      columnName: 'end_date',
      statement:
          'ALTER TABLE complementary_activities ADD COLUMN end_date INTEGER NULL',
    );

    if (await _columnExists('course_subject_lessons', 'pdf_name') &&
        await _columnExists('course_subject_lessons', 'pdf_bytes')) {
      await customStatement('''
        INSERT INTO attachments (
          id,
          created_at,
          updated_at,
          sync_status,
          is_deleted,
          owner_type,
          owner_id,
          file_name,
          file_bytes,
          mime_type,
          category,
          due_date,
          is_completed
        )
        SELECT
          'legacy_lesson_' || id,
          created_at,
          updated_at,
          sync_status,
          0,
          'course_subject_lesson',
          id,
          pdf_name,
          pdf_bytes,
          'application/pdf',
          'document',
          NULL,
          0
        FROM course_subject_lessons
        WHERE pdf_name IS NOT NULL
          AND pdf_bytes IS NOT NULL
          AND NOT EXISTS (
            SELECT 1 FROM attachments WHERE attachments.owner_type = 'course_subject_lesson' AND attachments.owner_id = course_subject_lessons.id
          )
      ''');
    }
  }

  Future<void> _migrateFrom5To6(Migrator m) async {
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'scheduled_weekday',
      statement:
          'ALTER TABLE course_subjects ADD COLUMN scheduled_weekday INTEGER NULL',
    );
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'default_lesson_hours',
      statement:
          'ALTER TABLE course_subjects ADD COLUMN default_lesson_hours REAL NULL',
    );
    await _addColumnIfMissing(
      tableName: 'course_subject_lessons',
      columnName: 'was_absent',
      statement:
          'ALTER TABLE course_subject_lessons ADD COLUMN was_absent INTEGER NOT NULL DEFAULT 0',
    );
  }

  Future<void> _migrateFrom6To7(Migrator m) async {
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'prerequisite_subject_ids_json',
      statement:
          "ALTER TABLE course_subjects ADD COLUMN prerequisite_subject_ids_json TEXT NOT NULL DEFAULT '[]'",
    );
  }

  Future<void> _migrateFrom7To8(Migrator m) async {
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'syllabus',
      statement: 'ALTER TABLE course_subjects ADD COLUMN syllabus TEXT NULL',
    );
  }

  Future<void> _migrateFrom8To9(Migrator m) async {
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'credit_source_subject_id',
      statement:
          'ALTER TABLE course_subjects ADD COLUMN credit_source_subject_id TEXT NULL',
    );
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'credit_source_profile_id',
      statement:
          'ALTER TABLE course_subjects ADD COLUMN credit_source_profile_id TEXT NULL',
    );
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'credit_status',
      statement:
          "ALTER TABLE course_subjects ADD COLUMN credit_status TEXT NOT NULL DEFAULT 'none'",
    );
    await _addColumnIfMissing(
      tableName: 'course_subjects',
      columnName: 'credit_match_score',
      statement:
          'ALTER TABLE course_subjects ADD COLUMN credit_match_score REAL NULL',
    );
  }

  Future<void> _migrateFrom9To10(Migrator m) async {
    await _addColumnIfMissing(
      tableName: 'study_sessions',
      columnName: 'academic_profile_id',
      statement:
          'ALTER TABLE study_sessions ADD COLUMN academic_profile_id TEXT NULL',
    );
  }

  Future<void> _addColumnIfMissing({
    required String tableName,
    required String columnName,
    required String statement,
  }) async {
    if (!await _columnExists(tableName, columnName)) {
      await customStatement(statement);
    }
  }

  Future<void> _cleanupOrphanedAcademicData() async {
    final now = DateTime.now();
    final activeProfileIds =
        (await (select(
              academicProfiles,
            )..where((table) => table.isDeleted.equals(false))).get())
            .map((row) => row.id)
            .toSet();

    final subjectRows = await (select(
      courseSubjects,
    )..where((table) => table.isDeleted.equals(false))).get();
    final orphanedSubjectIds = subjectRows
        .where(
          (row) =>
              row.academicProfileId != null &&
              !activeProfileIds.contains(row.academicProfileId),
        )
        .map((row) => row.id)
        .toSet();

    final complementaryIds =
        (await (select(
              complementaryActivities,
            )..where((table) => table.isDeleted.equals(false))).get())
            .where(
              (row) =>
                  row.academicProfileId != null &&
                  !activeProfileIds.contains(row.academicProfileId),
            )
            .map((row) => row.id)
            .toSet();

    final internshipIds =
        (await (select(
              internships,
            )..where((table) => table.isDeleted.equals(false))).get())
            .where(
              (row) =>
                  row.academicProfileId != null &&
                  !activeProfileIds.contains(row.academicProfileId),
            )
            .map((row) => row.id)
            .toSet();

    final extensionIds =
        (await (select(
              extensionActivities,
            )..where((table) => table.isDeleted.equals(false))).get())
            .where(
              (row) =>
                  row.academicProfileId != null &&
                  !activeProfileIds.contains(row.academicProfileId),
            )
            .map((row) => row.id)
            .toSet();

    final studySessionIds =
        (await (select(
              studySessions,
            )..where((table) => table.isDeleted.equals(false))).get())
            .where(
              (row) =>
                  row.academicProfileId != null &&
                  !activeProfileIds.contains(row.academicProfileId),
            )
            .map((row) => row.id)
            .toSet();

    final orphanedLessonIds = orphanedSubjectIds.isEmpty
        ? <String>{}
        : (await (select(courseSubjectLessons)..where(
                    (table) =>
                        table.isDeleted.equals(false) &
                        table.courseSubjectId.isIn(orphanedSubjectIds),
                  ))
                  .get())
              .map((row) => row.id)
              .toSet();

    final attachmentRows = await (select(
      attachments,
    )..where((table) => table.isDeleted.equals(false))).get();
    final orphanedAttachmentIds = attachmentRows
        .where(
          (row) =>
              (row.ownerType == 'course_subject_lesson' &&
                  orphanedLessonIds.contains(row.ownerId)) ||
              (row.ownerType == 'complementary_activity' &&
                  complementaryIds.contains(row.ownerId)) ||
              (row.ownerType == 'internship_record' &&
                  internshipIds.contains(row.ownerId)),
        )
        .map((row) => row.id)
        .toSet();

    if (orphanedSubjectIds.isEmpty &&
        orphanedLessonIds.isEmpty &&
        orphanedAttachmentIds.isEmpty &&
        complementaryIds.isEmpty &&
        internshipIds.isEmpty &&
        extensionIds.isEmpty &&
        studySessionIds.isEmpty) {
      return;
    }

    await transaction(() async {
      if (orphanedSubjectIds.isNotEmpty) {
        await (update(
          courseSubjects,
        )..where((table) => table.id.isIn(orphanedSubjectIds))).write(
          CourseSubjectsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (orphanedLessonIds.isNotEmpty) {
        await (update(
          courseSubjectLessons,
        )..where((table) => table.id.isIn(orphanedLessonIds))).write(
          CourseSubjectLessonsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (orphanedAttachmentIds.isNotEmpty) {
        await (update(
          attachments,
        )..where((table) => table.id.isIn(orphanedAttachmentIds))).write(
          AttachmentsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (complementaryIds.isNotEmpty) {
        await (update(
          complementaryActivities,
        )..where((table) => table.id.isIn(complementaryIds))).write(
          ComplementaryActivitiesCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (internshipIds.isNotEmpty) {
        await (update(
          internships,
        )..where((table) => table.id.isIn(internshipIds))).write(
          InternshipsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (extensionIds.isNotEmpty) {
        await (update(
          extensionActivities,
        )..where((table) => table.id.isIn(extensionIds))).write(
          ExtensionActivitiesCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      if (studySessionIds.isNotEmpty) {
        await (update(
          studySessions,
        )..where((table) => table.id.isIn(studySessionIds))).write(
          StudySessionsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingDelete.name),
          ),
        );
      }

      final remainingSubjectIds = subjectRows
          .where((row) => !orphanedSubjectIds.contains(row.id))
          .map((row) => row.id)
          .toSet();
      final creditRowsToClear = subjectRows
          .where(
            (row) =>
                !orphanedSubjectIds.contains(row.id) &&
                ((row.creditSourceProfileId != null &&
                        !activeProfileIds.contains(
                          row.creditSourceProfileId,
                        )) ||
                    (row.creditSourceSubjectId != null &&
                        !remainingSubjectIds.contains(
                          row.creditSourceSubjectId,
                        ))),
          )
          .map((row) => row.id)
          .toSet();
      if (creditRowsToClear.isNotEmpty) {
        await (update(
          courseSubjects,
        )..where((table) => table.id.isIn(creditRowsToClear))).write(
          CourseSubjectsCompanion(
            creditSourceSubjectId: const Value<String?>(null),
            creditSourceProfileId: const Value<String?>(null),
            creditStatus: Value(CourseSubjectCreditStatus.none.name),
            creditMatchScore: const Value<double?>(null),
            updatedAt: Value(now),
            syncStatus: Value(SyncStatus.pendingUpdate.name),
          ),
        );
      }
    });
  }

  Future<bool> _tableExists(String tableName) async {
    final result = await customSelect(
      'SELECT name FROM sqlite_master WHERE type = ?1 AND name = ?2 LIMIT 1',
      variables: [Variable.withString('table'), Variable.withString(tableName)],
    ).getSingleOrNull();

    return result != null;
  }

  Future<bool> _columnExists(String tableName, String columnName) async {
    if (!await _tableExists(tableName)) {
      return false;
    }

    final rows = await customSelect('PRAGMA table_info($tableName)').get();
    return rows.any((row) => row.read<String>('name') == columnName);
  }

  Future<void> _createIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_academic_profiles_active ON academic_profiles(is_active, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_academic_profiles_sync_status ON academic_profiles(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_course_subjects_profile ON course_subjects(academic_profile_id, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_course_subjects_weekday ON course_subjects(scheduled_weekday, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_course_subjects_status ON course_subjects(status)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_course_subjects_sync_status ON course_subjects(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_course_subject_lessons_subject ON course_subject_lessons(course_subject_id, lesson_date, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_course_subject_lessons_sync_status ON course_subject_lessons(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_course_subject_lessons_absence ON course_subject_lessons(course_subject_id, was_absent, lesson_date)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_attachments_owner ON attachments(owner_type, owner_id, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_attachments_due ON attachments(category, due_date, is_completed, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_complementary_profile ON complementary_activities(academic_profile_id, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_complementary_sync_status ON complementary_activities(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_internships_profile ON internships(academic_profile_id, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_internships_sync_status ON internships(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_extensions_profile ON extension_activities(academic_profile_id, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_extensions_sync_status ON extension_activities(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_study_subjects_sync_status ON study_subjects(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_study_topics_subject ON study_topics(study_subject_id, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_study_topics_sync_status ON study_topics(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_study_tasks_subject ON study_tasks(study_subject_id, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_study_tasks_sync_status ON study_tasks(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_study_sessions_sync_status ON study_sessions(sync_status, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_study_sessions_profile ON study_sessions(academic_profile_id, is_deleted)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_sync_queue_status ON sync_queue_entries(status, created_at)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_sync_queue_entity ON sync_queue_entries(entity_type, entity_id)',
    );
  }
}
