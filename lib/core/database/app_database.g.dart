// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AcademicProfilesTable extends AcademicProfiles
    with TableInfo<$AcademicProfilesTable, AcademicProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AcademicProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _profileNameMeta = const VerificationMeta(
    'profileName',
  );
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
    'profile_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _courseNameMeta = const VerificationMeta(
    'courseName',
  );
  @override
  late final GeneratedColumn<String> courseName = GeneratedColumn<String>(
    'course_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _institutionMeta = const VerificationMeta(
    'institution',
  );
  @override
  late final GeneratedColumn<String> institution = GeneratedColumn<String>(
    'institution',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolNameMeta = const VerificationMeta(
    'schoolName',
  );
  @override
  late final GeneratedColumn<String> schoolName = GeneratedColumn<String>(
    'school_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _campusMeta = const VerificationMeta('campus');
  @override
  late final GeneratedColumn<String> campus = GeneratedColumn<String>(
    'campus',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _degreeLabelMeta = const VerificationMeta(
    'degreeLabel',
  );
  @override
  late final GeneratedColumn<String> degreeLabel = GeneratedColumn<String>(
    'degree_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _totalCourseHoursMeta = const VerificationMeta(
    'totalCourseHours',
  );
  @override
  late final GeneratedColumn<int> totalCourseHours = GeneratedColumn<int>(
    'total_course_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semesterCountMeta = const VerificationMeta(
    'semesterCount',
  );
  @override
  late final GeneratedColumn<int> semesterCount = GeneratedColumn<int>(
    'semester_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requiredComplementaryHoursMeta =
      const VerificationMeta('requiredComplementaryHours');
  @override
  late final GeneratedColumn<int> requiredComplementaryHours =
      GeneratedColumn<int>(
        'required_complementary_hours',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _requiredInternshipHoursMeta =
      const VerificationMeta('requiredInternshipHours');
  @override
  late final GeneratedColumn<int> requiredInternshipHours =
      GeneratedColumn<int>(
        'required_internship_hours',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _requiredExtensionHoursMeta =
      const VerificationMeta('requiredExtensionHours');
  @override
  late final GeneratedColumn<int> requiredExtensionHours = GeneratedColumn<int>(
    'required_extension_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    profileName,
    courseName,
    institution,
    schoolName,
    campus,
    degreeLabel,
    isActive,
    totalCourseHours,
    semesterCount,
    requiredComplementaryHours,
    requiredInternshipHours,
    requiredExtensionHours,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'academic_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<AcademicProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('profile_name')) {
      context.handle(
        _profileNameMeta,
        profileName.isAcceptableOrUnknown(
          data['profile_name']!,
          _profileNameMeta,
        ),
      );
    }
    if (data.containsKey('course_name')) {
      context.handle(
        _courseNameMeta,
        courseName.isAcceptableOrUnknown(data['course_name']!, _courseNameMeta),
      );
    } else if (isInserting) {
      context.missing(_courseNameMeta);
    }
    if (data.containsKey('institution')) {
      context.handle(
        _institutionMeta,
        institution.isAcceptableOrUnknown(
          data['institution']!,
          _institutionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institutionMeta);
    }
    if (data.containsKey('school_name')) {
      context.handle(
        _schoolNameMeta,
        schoolName.isAcceptableOrUnknown(data['school_name']!, _schoolNameMeta),
      );
    }
    if (data.containsKey('campus')) {
      context.handle(
        _campusMeta,
        campus.isAcceptableOrUnknown(data['campus']!, _campusMeta),
      );
    }
    if (data.containsKey('degree_label')) {
      context.handle(
        _degreeLabelMeta,
        degreeLabel.isAcceptableOrUnknown(
          data['degree_label']!,
          _degreeLabelMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('total_course_hours')) {
      context.handle(
        _totalCourseHoursMeta,
        totalCourseHours.isAcceptableOrUnknown(
          data['total_course_hours']!,
          _totalCourseHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalCourseHoursMeta);
    }
    if (data.containsKey('semester_count')) {
      context.handle(
        _semesterCountMeta,
        semesterCount.isAcceptableOrUnknown(
          data['semester_count']!,
          _semesterCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_semesterCountMeta);
    }
    if (data.containsKey('required_complementary_hours')) {
      context.handle(
        _requiredComplementaryHoursMeta,
        requiredComplementaryHours.isAcceptableOrUnknown(
          data['required_complementary_hours']!,
          _requiredComplementaryHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredComplementaryHoursMeta);
    }
    if (data.containsKey('required_internship_hours')) {
      context.handle(
        _requiredInternshipHoursMeta,
        requiredInternshipHours.isAcceptableOrUnknown(
          data['required_internship_hours']!,
          _requiredInternshipHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredInternshipHoursMeta);
    }
    if (data.containsKey('required_extension_hours')) {
      context.handle(
        _requiredExtensionHoursMeta,
        requiredExtensionHours.isAcceptableOrUnknown(
          data['required_extension_hours']!,
          _requiredExtensionHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredExtensionHoursMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AcademicProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AcademicProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      profileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_name'],
      )!,
      courseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_name'],
      )!,
      institution: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}institution'],
      )!,
      schoolName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_name'],
      ),
      campus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campus'],
      ),
      degreeLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}degree_label'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      totalCourseHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_course_hours'],
      )!,
      semesterCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester_count'],
      )!,
      requiredComplementaryHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}required_complementary_hours'],
      )!,
      requiredInternshipHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}required_internship_hours'],
      )!,
      requiredExtensionHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}required_extension_hours'],
      )!,
    );
  }

  @override
  $AcademicProfilesTable createAlias(String alias) {
    return $AcademicProfilesTable(attachedDatabase, alias);
  }
}

class AcademicProfileRow extends DataClass
    implements Insertable<AcademicProfileRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String profileName;
  final String courseName;
  final String institution;
  final String? schoolName;
  final String? campus;
  final String? degreeLabel;
  final bool isActive;
  final int totalCourseHours;
  final int semesterCount;
  final int requiredComplementaryHours;
  final int requiredInternshipHours;
  final int requiredExtensionHours;
  const AcademicProfileRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    required this.profileName,
    required this.courseName,
    required this.institution,
    this.schoolName,
    this.campus,
    this.degreeLabel,
    required this.isActive,
    required this.totalCourseHours,
    required this.semesterCount,
    required this.requiredComplementaryHours,
    required this.requiredInternshipHours,
    required this.requiredExtensionHours,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['profile_name'] = Variable<String>(profileName);
    map['course_name'] = Variable<String>(courseName);
    map['institution'] = Variable<String>(institution);
    if (!nullToAbsent || schoolName != null) {
      map['school_name'] = Variable<String>(schoolName);
    }
    if (!nullToAbsent || campus != null) {
      map['campus'] = Variable<String>(campus);
    }
    if (!nullToAbsent || degreeLabel != null) {
      map['degree_label'] = Variable<String>(degreeLabel);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['total_course_hours'] = Variable<int>(totalCourseHours);
    map['semester_count'] = Variable<int>(semesterCount);
    map['required_complementary_hours'] = Variable<int>(
      requiredComplementaryHours,
    );
    map['required_internship_hours'] = Variable<int>(requiredInternshipHours);
    map['required_extension_hours'] = Variable<int>(requiredExtensionHours);
    return map;
  }

  AcademicProfilesCompanion toCompanion(bool nullToAbsent) {
    return AcademicProfilesCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      profileName: Value(profileName),
      courseName: Value(courseName),
      institution: Value(institution),
      schoolName: schoolName == null && nullToAbsent
          ? const Value.absent()
          : Value(schoolName),
      campus: campus == null && nullToAbsent
          ? const Value.absent()
          : Value(campus),
      degreeLabel: degreeLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(degreeLabel),
      isActive: Value(isActive),
      totalCourseHours: Value(totalCourseHours),
      semesterCount: Value(semesterCount),
      requiredComplementaryHours: Value(requiredComplementaryHours),
      requiredInternshipHours: Value(requiredInternshipHours),
      requiredExtensionHours: Value(requiredExtensionHours),
    );
  }

  factory AcademicProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AcademicProfileRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      profileName: serializer.fromJson<String>(json['profileName']),
      courseName: serializer.fromJson<String>(json['courseName']),
      institution: serializer.fromJson<String>(json['institution']),
      schoolName: serializer.fromJson<String?>(json['schoolName']),
      campus: serializer.fromJson<String?>(json['campus']),
      degreeLabel: serializer.fromJson<String?>(json['degreeLabel']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      totalCourseHours: serializer.fromJson<int>(json['totalCourseHours']),
      semesterCount: serializer.fromJson<int>(json['semesterCount']),
      requiredComplementaryHours: serializer.fromJson<int>(
        json['requiredComplementaryHours'],
      ),
      requiredInternshipHours: serializer.fromJson<int>(
        json['requiredInternshipHours'],
      ),
      requiredExtensionHours: serializer.fromJson<int>(
        json['requiredExtensionHours'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'profileName': serializer.toJson<String>(profileName),
      'courseName': serializer.toJson<String>(courseName),
      'institution': serializer.toJson<String>(institution),
      'schoolName': serializer.toJson<String?>(schoolName),
      'campus': serializer.toJson<String?>(campus),
      'degreeLabel': serializer.toJson<String?>(degreeLabel),
      'isActive': serializer.toJson<bool>(isActive),
      'totalCourseHours': serializer.toJson<int>(totalCourseHours),
      'semesterCount': serializer.toJson<int>(semesterCount),
      'requiredComplementaryHours': serializer.toJson<int>(
        requiredComplementaryHours,
      ),
      'requiredInternshipHours': serializer.toJson<int>(
        requiredInternshipHours,
      ),
      'requiredExtensionHours': serializer.toJson<int>(requiredExtensionHours),
    };
  }

  AcademicProfileRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    String? profileName,
    String? courseName,
    String? institution,
    Value<String?> schoolName = const Value.absent(),
    Value<String?> campus = const Value.absent(),
    Value<String?> degreeLabel = const Value.absent(),
    bool? isActive,
    int? totalCourseHours,
    int? semesterCount,
    int? requiredComplementaryHours,
    int? requiredInternshipHours,
    int? requiredExtensionHours,
  }) => AcademicProfileRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    profileName: profileName ?? this.profileName,
    courseName: courseName ?? this.courseName,
    institution: institution ?? this.institution,
    schoolName: schoolName.present ? schoolName.value : this.schoolName,
    campus: campus.present ? campus.value : this.campus,
    degreeLabel: degreeLabel.present ? degreeLabel.value : this.degreeLabel,
    isActive: isActive ?? this.isActive,
    totalCourseHours: totalCourseHours ?? this.totalCourseHours,
    semesterCount: semesterCount ?? this.semesterCount,
    requiredComplementaryHours:
        requiredComplementaryHours ?? this.requiredComplementaryHours,
    requiredInternshipHours:
        requiredInternshipHours ?? this.requiredInternshipHours,
    requiredExtensionHours:
        requiredExtensionHours ?? this.requiredExtensionHours,
  );
  AcademicProfileRow copyWithCompanion(AcademicProfilesCompanion data) {
    return AcademicProfileRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      profileName: data.profileName.present
          ? data.profileName.value
          : this.profileName,
      courseName: data.courseName.present
          ? data.courseName.value
          : this.courseName,
      institution: data.institution.present
          ? data.institution.value
          : this.institution,
      schoolName: data.schoolName.present
          ? data.schoolName.value
          : this.schoolName,
      campus: data.campus.present ? data.campus.value : this.campus,
      degreeLabel: data.degreeLabel.present
          ? data.degreeLabel.value
          : this.degreeLabel,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      totalCourseHours: data.totalCourseHours.present
          ? data.totalCourseHours.value
          : this.totalCourseHours,
      semesterCount: data.semesterCount.present
          ? data.semesterCount.value
          : this.semesterCount,
      requiredComplementaryHours: data.requiredComplementaryHours.present
          ? data.requiredComplementaryHours.value
          : this.requiredComplementaryHours,
      requiredInternshipHours: data.requiredInternshipHours.present
          ? data.requiredInternshipHours.value
          : this.requiredInternshipHours,
      requiredExtensionHours: data.requiredExtensionHours.present
          ? data.requiredExtensionHours.value
          : this.requiredExtensionHours,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AcademicProfileRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('profileName: $profileName, ')
          ..write('courseName: $courseName, ')
          ..write('institution: $institution, ')
          ..write('schoolName: $schoolName, ')
          ..write('campus: $campus, ')
          ..write('degreeLabel: $degreeLabel, ')
          ..write('isActive: $isActive, ')
          ..write('totalCourseHours: $totalCourseHours, ')
          ..write('semesterCount: $semesterCount, ')
          ..write('requiredComplementaryHours: $requiredComplementaryHours, ')
          ..write('requiredInternshipHours: $requiredInternshipHours, ')
          ..write('requiredExtensionHours: $requiredExtensionHours')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    profileName,
    courseName,
    institution,
    schoolName,
    campus,
    degreeLabel,
    isActive,
    totalCourseHours,
    semesterCount,
    requiredComplementaryHours,
    requiredInternshipHours,
    requiredExtensionHours,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AcademicProfileRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.profileName == this.profileName &&
          other.courseName == this.courseName &&
          other.institution == this.institution &&
          other.schoolName == this.schoolName &&
          other.campus == this.campus &&
          other.degreeLabel == this.degreeLabel &&
          other.isActive == this.isActive &&
          other.totalCourseHours == this.totalCourseHours &&
          other.semesterCount == this.semesterCount &&
          other.requiredComplementaryHours == this.requiredComplementaryHours &&
          other.requiredInternshipHours == this.requiredInternshipHours &&
          other.requiredExtensionHours == this.requiredExtensionHours);
}

class AcademicProfilesCompanion extends UpdateCompanion<AcademicProfileRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String> profileName;
  final Value<String> courseName;
  final Value<String> institution;
  final Value<String?> schoolName;
  final Value<String?> campus;
  final Value<String?> degreeLabel;
  final Value<bool> isActive;
  final Value<int> totalCourseHours;
  final Value<int> semesterCount;
  final Value<int> requiredComplementaryHours;
  final Value<int> requiredInternshipHours;
  final Value<int> requiredExtensionHours;
  final Value<int> rowid;
  const AcademicProfilesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.profileName = const Value.absent(),
    this.courseName = const Value.absent(),
    this.institution = const Value.absent(),
    this.schoolName = const Value.absent(),
    this.campus = const Value.absent(),
    this.degreeLabel = const Value.absent(),
    this.isActive = const Value.absent(),
    this.totalCourseHours = const Value.absent(),
    this.semesterCount = const Value.absent(),
    this.requiredComplementaryHours = const Value.absent(),
    this.requiredInternshipHours = const Value.absent(),
    this.requiredExtensionHours = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AcademicProfilesCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    this.profileName = const Value.absent(),
    required String courseName,
    required String institution,
    this.schoolName = const Value.absent(),
    this.campus = const Value.absent(),
    this.degreeLabel = const Value.absent(),
    this.isActive = const Value.absent(),
    required int totalCourseHours,
    required int semesterCount,
    required int requiredComplementaryHours,
    required int requiredInternshipHours,
    required int requiredExtensionHours,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       courseName = Value(courseName),
       institution = Value(institution),
       totalCourseHours = Value(totalCourseHours),
       semesterCount = Value(semesterCount),
       requiredComplementaryHours = Value(requiredComplementaryHours),
       requiredInternshipHours = Value(requiredInternshipHours),
       requiredExtensionHours = Value(requiredExtensionHours);
  static Insertable<AcademicProfileRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? profileName,
    Expression<String>? courseName,
    Expression<String>? institution,
    Expression<String>? schoolName,
    Expression<String>? campus,
    Expression<String>? degreeLabel,
    Expression<bool>? isActive,
    Expression<int>? totalCourseHours,
    Expression<int>? semesterCount,
    Expression<int>? requiredComplementaryHours,
    Expression<int>? requiredInternshipHours,
    Expression<int>? requiredExtensionHours,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (profileName != null) 'profile_name': profileName,
      if (courseName != null) 'course_name': courseName,
      if (institution != null) 'institution': institution,
      if (schoolName != null) 'school_name': schoolName,
      if (campus != null) 'campus': campus,
      if (degreeLabel != null) 'degree_label': degreeLabel,
      if (isActive != null) 'is_active': isActive,
      if (totalCourseHours != null) 'total_course_hours': totalCourseHours,
      if (semesterCount != null) 'semester_count': semesterCount,
      if (requiredComplementaryHours != null)
        'required_complementary_hours': requiredComplementaryHours,
      if (requiredInternshipHours != null)
        'required_internship_hours': requiredInternshipHours,
      if (requiredExtensionHours != null)
        'required_extension_hours': requiredExtensionHours,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AcademicProfilesCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String>? profileName,
    Value<String>? courseName,
    Value<String>? institution,
    Value<String?>? schoolName,
    Value<String?>? campus,
    Value<String?>? degreeLabel,
    Value<bool>? isActive,
    Value<int>? totalCourseHours,
    Value<int>? semesterCount,
    Value<int>? requiredComplementaryHours,
    Value<int>? requiredInternshipHours,
    Value<int>? requiredExtensionHours,
    Value<int>? rowid,
  }) {
    return AcademicProfilesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      profileName: profileName ?? this.profileName,
      courseName: courseName ?? this.courseName,
      institution: institution ?? this.institution,
      schoolName: schoolName ?? this.schoolName,
      campus: campus ?? this.campus,
      degreeLabel: degreeLabel ?? this.degreeLabel,
      isActive: isActive ?? this.isActive,
      totalCourseHours: totalCourseHours ?? this.totalCourseHours,
      semesterCount: semesterCount ?? this.semesterCount,
      requiredComplementaryHours:
          requiredComplementaryHours ?? this.requiredComplementaryHours,
      requiredInternshipHours:
          requiredInternshipHours ?? this.requiredInternshipHours,
      requiredExtensionHours:
          requiredExtensionHours ?? this.requiredExtensionHours,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (courseName.present) {
      map['course_name'] = Variable<String>(courseName.value);
    }
    if (institution.present) {
      map['institution'] = Variable<String>(institution.value);
    }
    if (schoolName.present) {
      map['school_name'] = Variable<String>(schoolName.value);
    }
    if (campus.present) {
      map['campus'] = Variable<String>(campus.value);
    }
    if (degreeLabel.present) {
      map['degree_label'] = Variable<String>(degreeLabel.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (totalCourseHours.present) {
      map['total_course_hours'] = Variable<int>(totalCourseHours.value);
    }
    if (semesterCount.present) {
      map['semester_count'] = Variable<int>(semesterCount.value);
    }
    if (requiredComplementaryHours.present) {
      map['required_complementary_hours'] = Variable<int>(
        requiredComplementaryHours.value,
      );
    }
    if (requiredInternshipHours.present) {
      map['required_internship_hours'] = Variable<int>(
        requiredInternshipHours.value,
      );
    }
    if (requiredExtensionHours.present) {
      map['required_extension_hours'] = Variable<int>(
        requiredExtensionHours.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AcademicProfilesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('profileName: $profileName, ')
          ..write('courseName: $courseName, ')
          ..write('institution: $institution, ')
          ..write('schoolName: $schoolName, ')
          ..write('campus: $campus, ')
          ..write('degreeLabel: $degreeLabel, ')
          ..write('isActive: $isActive, ')
          ..write('totalCourseHours: $totalCourseHours, ')
          ..write('semesterCount: $semesterCount, ')
          ..write('requiredComplementaryHours: $requiredComplementaryHours, ')
          ..write('requiredInternshipHours: $requiredInternshipHours, ')
          ..write('requiredExtensionHours: $requiredExtensionHours, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CourseSubjectsTable extends CourseSubjects
    with TableInfo<$CourseSubjectsTable, CourseSubjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseSubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _academicProfileIdMeta = const VerificationMeta(
    'academicProfileId',
  );
  @override
  late final GeneratedColumn<String> academicProfileId =
      GeneratedColumn<String>(
        'academic_profile_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES academic_profiles (id)',
        ),
      );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workloadHoursMeta = const VerificationMeta(
    'workloadHours',
  );
  @override
  late final GeneratedColumn<int> workloadHours = GeneratedColumn<int>(
    'workload_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _electiveHoursMeta = const VerificationMeta(
    'electiveHours',
  );
  @override
  late final GeneratedColumn<int> electiveHours = GeneratedColumn<int>(
    'elective_hours',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _suggestedSemesterMeta = const VerificationMeta(
    'suggestedSemester',
  );
  @override
  late final GeneratedColumn<int> suggestedSemester = GeneratedColumn<int>(
    'suggested_semester',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prerequisiteSubjectIdsJsonMeta =
      const VerificationMeta('prerequisiteSubjectIdsJson');
  @override
  late final GeneratedColumn<String> prerequisiteSubjectIdsJson =
      GeneratedColumn<String>(
        'prerequisite_subject_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _scheduledWeekdayMeta = const VerificationMeta(
    'scheduledWeekday',
  );
  @override
  late final GeneratedColumn<int> scheduledWeekday = GeneratedColumn<int>(
    'scheduled_weekday',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultLessonHoursMeta =
      const VerificationMeta('defaultLessonHours');
  @override
  late final GeneratedColumn<double> defaultLessonHours =
      GeneratedColumn<double>(
        'default_lesson_hours',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditSourceSubjectIdMeta =
      const VerificationMeta('creditSourceSubjectId');
  @override
  late final GeneratedColumn<String> creditSourceSubjectId =
      GeneratedColumn<String>(
        'credit_source_subject_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _creditSourceProfileIdMeta =
      const VerificationMeta('creditSourceProfileId');
  @override
  late final GeneratedColumn<String> creditSourceProfileId =
      GeneratedColumn<String>(
        'credit_source_profile_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _creditStatusMeta = const VerificationMeta(
    'creditStatus',
  );
  @override
  late final GeneratedColumn<String> creditStatus = GeneratedColumn<String>(
    'credit_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _creditMatchScoreMeta = const VerificationMeta(
    'creditMatchScore',
  );
  @override
  late final GeneratedColumn<double> creditMatchScore = GeneratedColumn<double>(
    'credit_match_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syllabusMeta = const VerificationMeta(
    'syllabus',
  );
  @override
  late final GeneratedColumn<String> syllabus = GeneratedColumn<String>(
    'syllabus',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    academicProfileId,
    name,
    code,
    workloadHours,
    electiveHours,
    suggestedSemester,
    prerequisiteSubjectIdsJson,
    scheduledWeekday,
    defaultLessonHours,
    type,
    status,
    creditSourceSubjectId,
    creditSourceProfileId,
    creditStatus,
    creditMatchScore,
    syllabus,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseSubjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('academic_profile_id')) {
      context.handle(
        _academicProfileIdMeta,
        academicProfileId.isAcceptableOrUnknown(
          data['academic_profile_id']!,
          _academicProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('workload_hours')) {
      context.handle(
        _workloadHoursMeta,
        workloadHours.isAcceptableOrUnknown(
          data['workload_hours']!,
          _workloadHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workloadHoursMeta);
    }
    if (data.containsKey('elective_hours')) {
      context.handle(
        _electiveHoursMeta,
        electiveHours.isAcceptableOrUnknown(
          data['elective_hours']!,
          _electiveHoursMeta,
        ),
      );
    }
    if (data.containsKey('suggested_semester')) {
      context.handle(
        _suggestedSemesterMeta,
        suggestedSemester.isAcceptableOrUnknown(
          data['suggested_semester']!,
          _suggestedSemesterMeta,
        ),
      );
    }
    if (data.containsKey('prerequisite_subject_ids_json')) {
      context.handle(
        _prerequisiteSubjectIdsJsonMeta,
        prerequisiteSubjectIdsJson.isAcceptableOrUnknown(
          data['prerequisite_subject_ids_json']!,
          _prerequisiteSubjectIdsJsonMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_weekday')) {
      context.handle(
        _scheduledWeekdayMeta,
        scheduledWeekday.isAcceptableOrUnknown(
          data['scheduled_weekday']!,
          _scheduledWeekdayMeta,
        ),
      );
    }
    if (data.containsKey('default_lesson_hours')) {
      context.handle(
        _defaultLessonHoursMeta,
        defaultLessonHours.isAcceptableOrUnknown(
          data['default_lesson_hours']!,
          _defaultLessonHoursMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('credit_source_subject_id')) {
      context.handle(
        _creditSourceSubjectIdMeta,
        creditSourceSubjectId.isAcceptableOrUnknown(
          data['credit_source_subject_id']!,
          _creditSourceSubjectIdMeta,
        ),
      );
    }
    if (data.containsKey('credit_source_profile_id')) {
      context.handle(
        _creditSourceProfileIdMeta,
        creditSourceProfileId.isAcceptableOrUnknown(
          data['credit_source_profile_id']!,
          _creditSourceProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('credit_status')) {
      context.handle(
        _creditStatusMeta,
        creditStatus.isAcceptableOrUnknown(
          data['credit_status']!,
          _creditStatusMeta,
        ),
      );
    }
    if (data.containsKey('credit_match_score')) {
      context.handle(
        _creditMatchScoreMeta,
        creditMatchScore.isAcceptableOrUnknown(
          data['credit_match_score']!,
          _creditMatchScoreMeta,
        ),
      );
    }
    if (data.containsKey('syllabus')) {
      context.handle(
        _syllabusMeta,
        syllabus.isAcceptableOrUnknown(data['syllabus']!, _syllabusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseSubjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseSubjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      academicProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_profile_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      workloadHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workload_hours'],
      )!,
      electiveHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elective_hours'],
      ),
      suggestedSemester: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}suggested_semester'],
      ),
      prerequisiteSubjectIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prerequisite_subject_ids_json'],
      )!,
      scheduledWeekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scheduled_weekday'],
      ),
      defaultLessonHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_lesson_hours'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      creditSourceSubjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_source_subject_id'],
      ),
      creditSourceProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_source_profile_id'],
      ),
      creditStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_status'],
      )!,
      creditMatchScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_match_score'],
      ),
      syllabus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}syllabus'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $CourseSubjectsTable createAlias(String alias) {
    return $CourseSubjectsTable(attachedDatabase, alias);
  }
}

class CourseSubjectRow extends DataClass
    implements Insertable<CourseSubjectRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String? academicProfileId;
  final String name;
  final String? code;
  final int workloadHours;
  final int? electiveHours;
  final int? suggestedSemester;
  final String prerequisiteSubjectIdsJson;
  final int? scheduledWeekday;
  final double? defaultLessonHours;
  final String type;
  final String status;
  final String? creditSourceSubjectId;
  final String? creditSourceProfileId;
  final String creditStatus;
  final double? creditMatchScore;
  final String? syllabus;
  final String? notes;
  const CourseSubjectRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    this.academicProfileId,
    required this.name,
    this.code,
    required this.workloadHours,
    this.electiveHours,
    this.suggestedSemester,
    required this.prerequisiteSubjectIdsJson,
    this.scheduledWeekday,
    this.defaultLessonHours,
    required this.type,
    required this.status,
    this.creditSourceSubjectId,
    this.creditSourceProfileId,
    required this.creditStatus,
    this.creditMatchScore,
    this.syllabus,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || academicProfileId != null) {
      map['academic_profile_id'] = Variable<String>(academicProfileId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['workload_hours'] = Variable<int>(workloadHours);
    if (!nullToAbsent || electiveHours != null) {
      map['elective_hours'] = Variable<int>(electiveHours);
    }
    if (!nullToAbsent || suggestedSemester != null) {
      map['suggested_semester'] = Variable<int>(suggestedSemester);
    }
    map['prerequisite_subject_ids_json'] = Variable<String>(
      prerequisiteSubjectIdsJson,
    );
    if (!nullToAbsent || scheduledWeekday != null) {
      map['scheduled_weekday'] = Variable<int>(scheduledWeekday);
    }
    if (!nullToAbsent || defaultLessonHours != null) {
      map['default_lesson_hours'] = Variable<double>(defaultLessonHours);
    }
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || creditSourceSubjectId != null) {
      map['credit_source_subject_id'] = Variable<String>(creditSourceSubjectId);
    }
    if (!nullToAbsent || creditSourceProfileId != null) {
      map['credit_source_profile_id'] = Variable<String>(creditSourceProfileId);
    }
    map['credit_status'] = Variable<String>(creditStatus);
    if (!nullToAbsent || creditMatchScore != null) {
      map['credit_match_score'] = Variable<double>(creditMatchScore);
    }
    if (!nullToAbsent || syllabus != null) {
      map['syllabus'] = Variable<String>(syllabus);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  CourseSubjectsCompanion toCompanion(bool nullToAbsent) {
    return CourseSubjectsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      academicProfileId: academicProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(academicProfileId),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      workloadHours: Value(workloadHours),
      electiveHours: electiveHours == null && nullToAbsent
          ? const Value.absent()
          : Value(electiveHours),
      suggestedSemester: suggestedSemester == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestedSemester),
      prerequisiteSubjectIdsJson: Value(prerequisiteSubjectIdsJson),
      scheduledWeekday: scheduledWeekday == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledWeekday),
      defaultLessonHours: defaultLessonHours == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultLessonHours),
      type: Value(type),
      status: Value(status),
      creditSourceSubjectId: creditSourceSubjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(creditSourceSubjectId),
      creditSourceProfileId: creditSourceProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(creditSourceProfileId),
      creditStatus: Value(creditStatus),
      creditMatchScore: creditMatchScore == null && nullToAbsent
          ? const Value.absent()
          : Value(creditMatchScore),
      syllabus: syllabus == null && nullToAbsent
          ? const Value.absent()
          : Value(syllabus),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory CourseSubjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseSubjectRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      academicProfileId: serializer.fromJson<String?>(
        json['academicProfileId'],
      ),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      workloadHours: serializer.fromJson<int>(json['workloadHours']),
      electiveHours: serializer.fromJson<int?>(json['electiveHours']),
      suggestedSemester: serializer.fromJson<int?>(json['suggestedSemester']),
      prerequisiteSubjectIdsJson: serializer.fromJson<String>(
        json['prerequisiteSubjectIdsJson'],
      ),
      scheduledWeekday: serializer.fromJson<int?>(json['scheduledWeekday']),
      defaultLessonHours: serializer.fromJson<double?>(
        json['defaultLessonHours'],
      ),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      creditSourceSubjectId: serializer.fromJson<String?>(
        json['creditSourceSubjectId'],
      ),
      creditSourceProfileId: serializer.fromJson<String?>(
        json['creditSourceProfileId'],
      ),
      creditStatus: serializer.fromJson<String>(json['creditStatus']),
      creditMatchScore: serializer.fromJson<double?>(json['creditMatchScore']),
      syllabus: serializer.fromJson<String?>(json['syllabus']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'academicProfileId': serializer.toJson<String?>(academicProfileId),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'workloadHours': serializer.toJson<int>(workloadHours),
      'electiveHours': serializer.toJson<int?>(electiveHours),
      'suggestedSemester': serializer.toJson<int?>(suggestedSemester),
      'prerequisiteSubjectIdsJson': serializer.toJson<String>(
        prerequisiteSubjectIdsJson,
      ),
      'scheduledWeekday': serializer.toJson<int?>(scheduledWeekday),
      'defaultLessonHours': serializer.toJson<double?>(defaultLessonHours),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'creditSourceSubjectId': serializer.toJson<String?>(
        creditSourceSubjectId,
      ),
      'creditSourceProfileId': serializer.toJson<String?>(
        creditSourceProfileId,
      ),
      'creditStatus': serializer.toJson<String>(creditStatus),
      'creditMatchScore': serializer.toJson<double?>(creditMatchScore),
      'syllabus': serializer.toJson<String?>(syllabus),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  CourseSubjectRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    Value<String?> academicProfileId = const Value.absent(),
    String? name,
    Value<String?> code = const Value.absent(),
    int? workloadHours,
    Value<int?> electiveHours = const Value.absent(),
    Value<int?> suggestedSemester = const Value.absent(),
    String? prerequisiteSubjectIdsJson,
    Value<int?> scheduledWeekday = const Value.absent(),
    Value<double?> defaultLessonHours = const Value.absent(),
    String? type,
    String? status,
    Value<String?> creditSourceSubjectId = const Value.absent(),
    Value<String?> creditSourceProfileId = const Value.absent(),
    String? creditStatus,
    Value<double?> creditMatchScore = const Value.absent(),
    Value<String?> syllabus = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => CourseSubjectRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    academicProfileId: academicProfileId.present
        ? academicProfileId.value
        : this.academicProfileId,
    name: name ?? this.name,
    code: code.present ? code.value : this.code,
    workloadHours: workloadHours ?? this.workloadHours,
    electiveHours: electiveHours.present
        ? electiveHours.value
        : this.electiveHours,
    suggestedSemester: suggestedSemester.present
        ? suggestedSemester.value
        : this.suggestedSemester,
    prerequisiteSubjectIdsJson:
        prerequisiteSubjectIdsJson ?? this.prerequisiteSubjectIdsJson,
    scheduledWeekday: scheduledWeekday.present
        ? scheduledWeekday.value
        : this.scheduledWeekday,
    defaultLessonHours: defaultLessonHours.present
        ? defaultLessonHours.value
        : this.defaultLessonHours,
    type: type ?? this.type,
    status: status ?? this.status,
    creditSourceSubjectId: creditSourceSubjectId.present
        ? creditSourceSubjectId.value
        : this.creditSourceSubjectId,
    creditSourceProfileId: creditSourceProfileId.present
        ? creditSourceProfileId.value
        : this.creditSourceProfileId,
    creditStatus: creditStatus ?? this.creditStatus,
    creditMatchScore: creditMatchScore.present
        ? creditMatchScore.value
        : this.creditMatchScore,
    syllabus: syllabus.present ? syllabus.value : this.syllabus,
    notes: notes.present ? notes.value : this.notes,
  );
  CourseSubjectRow copyWithCompanion(CourseSubjectsCompanion data) {
    return CourseSubjectRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      academicProfileId: data.academicProfileId.present
          ? data.academicProfileId.value
          : this.academicProfileId,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      workloadHours: data.workloadHours.present
          ? data.workloadHours.value
          : this.workloadHours,
      electiveHours: data.electiveHours.present
          ? data.electiveHours.value
          : this.electiveHours,
      suggestedSemester: data.suggestedSemester.present
          ? data.suggestedSemester.value
          : this.suggestedSemester,
      prerequisiteSubjectIdsJson: data.prerequisiteSubjectIdsJson.present
          ? data.prerequisiteSubjectIdsJson.value
          : this.prerequisiteSubjectIdsJson,
      scheduledWeekday: data.scheduledWeekday.present
          ? data.scheduledWeekday.value
          : this.scheduledWeekday,
      defaultLessonHours: data.defaultLessonHours.present
          ? data.defaultLessonHours.value
          : this.defaultLessonHours,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      creditSourceSubjectId: data.creditSourceSubjectId.present
          ? data.creditSourceSubjectId.value
          : this.creditSourceSubjectId,
      creditSourceProfileId: data.creditSourceProfileId.present
          ? data.creditSourceProfileId.value
          : this.creditSourceProfileId,
      creditStatus: data.creditStatus.present
          ? data.creditStatus.value
          : this.creditStatus,
      creditMatchScore: data.creditMatchScore.present
          ? data.creditMatchScore.value
          : this.creditMatchScore,
      syllabus: data.syllabus.present ? data.syllabus.value : this.syllabus,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseSubjectRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('academicProfileId: $academicProfileId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('workloadHours: $workloadHours, ')
          ..write('electiveHours: $electiveHours, ')
          ..write('suggestedSemester: $suggestedSemester, ')
          ..write('prerequisiteSubjectIdsJson: $prerequisiteSubjectIdsJson, ')
          ..write('scheduledWeekday: $scheduledWeekday, ')
          ..write('defaultLessonHours: $defaultLessonHours, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('creditSourceSubjectId: $creditSourceSubjectId, ')
          ..write('creditSourceProfileId: $creditSourceProfileId, ')
          ..write('creditStatus: $creditStatus, ')
          ..write('creditMatchScore: $creditMatchScore, ')
          ..write('syllabus: $syllabus, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    academicProfileId,
    name,
    code,
    workloadHours,
    electiveHours,
    suggestedSemester,
    prerequisiteSubjectIdsJson,
    scheduledWeekday,
    defaultLessonHours,
    type,
    status,
    creditSourceSubjectId,
    creditSourceProfileId,
    creditStatus,
    creditMatchScore,
    syllabus,
    notes,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseSubjectRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.academicProfileId == this.academicProfileId &&
          other.name == this.name &&
          other.code == this.code &&
          other.workloadHours == this.workloadHours &&
          other.electiveHours == this.electiveHours &&
          other.suggestedSemester == this.suggestedSemester &&
          other.prerequisiteSubjectIdsJson == this.prerequisiteSubjectIdsJson &&
          other.scheduledWeekday == this.scheduledWeekday &&
          other.defaultLessonHours == this.defaultLessonHours &&
          other.type == this.type &&
          other.status == this.status &&
          other.creditSourceSubjectId == this.creditSourceSubjectId &&
          other.creditSourceProfileId == this.creditSourceProfileId &&
          other.creditStatus == this.creditStatus &&
          other.creditMatchScore == this.creditMatchScore &&
          other.syllabus == this.syllabus &&
          other.notes == this.notes);
}

class CourseSubjectsCompanion extends UpdateCompanion<CourseSubjectRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String?> academicProfileId;
  final Value<String> name;
  final Value<String?> code;
  final Value<int> workloadHours;
  final Value<int?> electiveHours;
  final Value<int?> suggestedSemester;
  final Value<String> prerequisiteSubjectIdsJson;
  final Value<int?> scheduledWeekday;
  final Value<double?> defaultLessonHours;
  final Value<String> type;
  final Value<String> status;
  final Value<String?> creditSourceSubjectId;
  final Value<String?> creditSourceProfileId;
  final Value<String> creditStatus;
  final Value<double?> creditMatchScore;
  final Value<String?> syllabus;
  final Value<String?> notes;
  final Value<int> rowid;
  const CourseSubjectsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.academicProfileId = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.workloadHours = const Value.absent(),
    this.electiveHours = const Value.absent(),
    this.suggestedSemester = const Value.absent(),
    this.prerequisiteSubjectIdsJson = const Value.absent(),
    this.scheduledWeekday = const Value.absent(),
    this.defaultLessonHours = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.creditSourceSubjectId = const Value.absent(),
    this.creditSourceProfileId = const Value.absent(),
    this.creditStatus = const Value.absent(),
    this.creditMatchScore = const Value.absent(),
    this.syllabus = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CourseSubjectsCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    this.academicProfileId = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    required int workloadHours,
    this.electiveHours = const Value.absent(),
    this.suggestedSemester = const Value.absent(),
    this.prerequisiteSubjectIdsJson = const Value.absent(),
    this.scheduledWeekday = const Value.absent(),
    this.defaultLessonHours = const Value.absent(),
    required String type,
    required String status,
    this.creditSourceSubjectId = const Value.absent(),
    this.creditSourceProfileId = const Value.absent(),
    this.creditStatus = const Value.absent(),
    this.creditMatchScore = const Value.absent(),
    this.syllabus = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       name = Value(name),
       workloadHours = Value(workloadHours),
       type = Value(type),
       status = Value(status);
  static Insertable<CourseSubjectRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? academicProfileId,
    Expression<String>? name,
    Expression<String>? code,
    Expression<int>? workloadHours,
    Expression<int>? electiveHours,
    Expression<int>? suggestedSemester,
    Expression<String>? prerequisiteSubjectIdsJson,
    Expression<int>? scheduledWeekday,
    Expression<double>? defaultLessonHours,
    Expression<String>? type,
    Expression<String>? status,
    Expression<String>? creditSourceSubjectId,
    Expression<String>? creditSourceProfileId,
    Expression<String>? creditStatus,
    Expression<double>? creditMatchScore,
    Expression<String>? syllabus,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (academicProfileId != null) 'academic_profile_id': academicProfileId,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (workloadHours != null) 'workload_hours': workloadHours,
      if (electiveHours != null) 'elective_hours': electiveHours,
      if (suggestedSemester != null) 'suggested_semester': suggestedSemester,
      if (prerequisiteSubjectIdsJson != null)
        'prerequisite_subject_ids_json': prerequisiteSubjectIdsJson,
      if (scheduledWeekday != null) 'scheduled_weekday': scheduledWeekday,
      if (defaultLessonHours != null)
        'default_lesson_hours': defaultLessonHours,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (creditSourceSubjectId != null)
        'credit_source_subject_id': creditSourceSubjectId,
      if (creditSourceProfileId != null)
        'credit_source_profile_id': creditSourceProfileId,
      if (creditStatus != null) 'credit_status': creditStatus,
      if (creditMatchScore != null) 'credit_match_score': creditMatchScore,
      if (syllabus != null) 'syllabus': syllabus,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CourseSubjectsCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String?>? academicProfileId,
    Value<String>? name,
    Value<String?>? code,
    Value<int>? workloadHours,
    Value<int?>? electiveHours,
    Value<int?>? suggestedSemester,
    Value<String>? prerequisiteSubjectIdsJson,
    Value<int?>? scheduledWeekday,
    Value<double?>? defaultLessonHours,
    Value<String>? type,
    Value<String>? status,
    Value<String?>? creditSourceSubjectId,
    Value<String?>? creditSourceProfileId,
    Value<String>? creditStatus,
    Value<double?>? creditMatchScore,
    Value<String?>? syllabus,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return CourseSubjectsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      academicProfileId: academicProfileId ?? this.academicProfileId,
      name: name ?? this.name,
      code: code ?? this.code,
      workloadHours: workloadHours ?? this.workloadHours,
      electiveHours: electiveHours ?? this.electiveHours,
      suggestedSemester: suggestedSemester ?? this.suggestedSemester,
      prerequisiteSubjectIdsJson:
          prerequisiteSubjectIdsJson ?? this.prerequisiteSubjectIdsJson,
      scheduledWeekday: scheduledWeekday ?? this.scheduledWeekday,
      defaultLessonHours: defaultLessonHours ?? this.defaultLessonHours,
      type: type ?? this.type,
      status: status ?? this.status,
      creditSourceSubjectId:
          creditSourceSubjectId ?? this.creditSourceSubjectId,
      creditSourceProfileId:
          creditSourceProfileId ?? this.creditSourceProfileId,
      creditStatus: creditStatus ?? this.creditStatus,
      creditMatchScore: creditMatchScore ?? this.creditMatchScore,
      syllabus: syllabus ?? this.syllabus,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (academicProfileId.present) {
      map['academic_profile_id'] = Variable<String>(academicProfileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (workloadHours.present) {
      map['workload_hours'] = Variable<int>(workloadHours.value);
    }
    if (electiveHours.present) {
      map['elective_hours'] = Variable<int>(electiveHours.value);
    }
    if (suggestedSemester.present) {
      map['suggested_semester'] = Variable<int>(suggestedSemester.value);
    }
    if (prerequisiteSubjectIdsJson.present) {
      map['prerequisite_subject_ids_json'] = Variable<String>(
        prerequisiteSubjectIdsJson.value,
      );
    }
    if (scheduledWeekday.present) {
      map['scheduled_weekday'] = Variable<int>(scheduledWeekday.value);
    }
    if (defaultLessonHours.present) {
      map['default_lesson_hours'] = Variable<double>(defaultLessonHours.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (creditSourceSubjectId.present) {
      map['credit_source_subject_id'] = Variable<String>(
        creditSourceSubjectId.value,
      );
    }
    if (creditSourceProfileId.present) {
      map['credit_source_profile_id'] = Variable<String>(
        creditSourceProfileId.value,
      );
    }
    if (creditStatus.present) {
      map['credit_status'] = Variable<String>(creditStatus.value);
    }
    if (creditMatchScore.present) {
      map['credit_match_score'] = Variable<double>(creditMatchScore.value);
    }
    if (syllabus.present) {
      map['syllabus'] = Variable<String>(syllabus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseSubjectsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('academicProfileId: $academicProfileId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('workloadHours: $workloadHours, ')
          ..write('electiveHours: $electiveHours, ')
          ..write('suggestedSemester: $suggestedSemester, ')
          ..write('prerequisiteSubjectIdsJson: $prerequisiteSubjectIdsJson, ')
          ..write('scheduledWeekday: $scheduledWeekday, ')
          ..write('defaultLessonHours: $defaultLessonHours, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('creditSourceSubjectId: $creditSourceSubjectId, ')
          ..write('creditSourceProfileId: $creditSourceProfileId, ')
          ..write('creditStatus: $creditStatus, ')
          ..write('creditMatchScore: $creditMatchScore, ')
          ..write('syllabus: $syllabus, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CourseSubjectLessonsTable extends CourseSubjectLessons
    with TableInfo<$CourseSubjectLessonsTable, CourseSubjectLessonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseSubjectLessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _courseSubjectIdMeta = const VerificationMeta(
    'courseSubjectId',
  );
  @override
  late final GeneratedColumn<String> courseSubjectId = GeneratedColumn<String>(
    'course_subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES course_subjects (id)',
    ),
  );
  static const VerificationMeta _lessonDateMeta = const VerificationMeta(
    'lessonDate',
  );
  @override
  late final GeneratedColumn<DateTime> lessonDate = GeneratedColumn<DateTime>(
    'lesson_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonHoursMeta = const VerificationMeta(
    'lessonHours',
  );
  @override
  late final GeneratedColumn<double> lessonHours = GeneratedColumn<double>(
    'lesson_hours',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coveredContentMeta = const VerificationMeta(
    'coveredContent',
  );
  @override
  late final GeneratedColumn<String> coveredContent = GeneratedColumn<String>(
    'covered_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityDescriptionMeta =
      const VerificationMeta('activityDescription');
  @override
  late final GeneratedColumn<String> activityDescription =
      GeneratedColumn<String>(
        'activity_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _assessmentDescriptionMeta =
      const VerificationMeta('assessmentDescription');
  @override
  late final GeneratedColumn<String> assessmentDescription =
      GeneratedColumn<String>(
        'assessment_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _assessmentDateMeta = const VerificationMeta(
    'assessmentDate',
  );
  @override
  late final GeneratedColumn<DateTime> assessmentDate =
      GeneratedColumn<DateTime>(
        'assessment_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _pdfNameMeta = const VerificationMeta(
    'pdfName',
  );
  @override
  late final GeneratedColumn<String> pdfName = GeneratedColumn<String>(
    'pdf_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pdfBytesMeta = const VerificationMeta(
    'pdfBytes',
  );
  @override
  late final GeneratedColumn<Uint8List> pdfBytes = GeneratedColumn<Uint8List>(
    'pdf_bytes',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wasAbsentMeta = const VerificationMeta(
    'wasAbsent',
  );
  @override
  late final GeneratedColumn<bool> wasAbsent = GeneratedColumn<bool>(
    'was_absent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_absent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    courseSubjectId,
    lessonDate,
    lessonHours,
    coveredContent,
    description,
    activityDescription,
    assessmentDescription,
    assessmentDate,
    pdfName,
    pdfBytes,
    wasAbsent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_subject_lessons';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseSubjectLessonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('course_subject_id')) {
      context.handle(
        _courseSubjectIdMeta,
        courseSubjectId.isAcceptableOrUnknown(
          data['course_subject_id']!,
          _courseSubjectIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courseSubjectIdMeta);
    }
    if (data.containsKey('lesson_date')) {
      context.handle(
        _lessonDateMeta,
        lessonDate.isAcceptableOrUnknown(data['lesson_date']!, _lessonDateMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonDateMeta);
    }
    if (data.containsKey('lesson_hours')) {
      context.handle(
        _lessonHoursMeta,
        lessonHours.isAcceptableOrUnknown(
          data['lesson_hours']!,
          _lessonHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lessonHoursMeta);
    }
    if (data.containsKey('covered_content')) {
      context.handle(
        _coveredContentMeta,
        coveredContent.isAcceptableOrUnknown(
          data['covered_content']!,
          _coveredContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coveredContentMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('activity_description')) {
      context.handle(
        _activityDescriptionMeta,
        activityDescription.isAcceptableOrUnknown(
          data['activity_description']!,
          _activityDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('assessment_description')) {
      context.handle(
        _assessmentDescriptionMeta,
        assessmentDescription.isAcceptableOrUnknown(
          data['assessment_description']!,
          _assessmentDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('assessment_date')) {
      context.handle(
        _assessmentDateMeta,
        assessmentDate.isAcceptableOrUnknown(
          data['assessment_date']!,
          _assessmentDateMeta,
        ),
      );
    }
    if (data.containsKey('pdf_name')) {
      context.handle(
        _pdfNameMeta,
        pdfName.isAcceptableOrUnknown(data['pdf_name']!, _pdfNameMeta),
      );
    }
    if (data.containsKey('pdf_bytes')) {
      context.handle(
        _pdfBytesMeta,
        pdfBytes.isAcceptableOrUnknown(data['pdf_bytes']!, _pdfBytesMeta),
      );
    }
    if (data.containsKey('was_absent')) {
      context.handle(
        _wasAbsentMeta,
        wasAbsent.isAcceptableOrUnknown(data['was_absent']!, _wasAbsentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseSubjectLessonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseSubjectLessonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      courseSubjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_subject_id'],
      )!,
      lessonDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}lesson_date'],
      )!,
      lessonHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lesson_hours'],
      )!,
      coveredContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}covered_content'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      activityDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_description'],
      ),
      assessmentDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assessment_description'],
      ),
      assessmentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}assessment_date'],
      ),
      pdfName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_name'],
      ),
      pdfBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}pdf_bytes'],
      ),
      wasAbsent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_absent'],
      )!,
    );
  }

  @override
  $CourseSubjectLessonsTable createAlias(String alias) {
    return $CourseSubjectLessonsTable(attachedDatabase, alias);
  }
}

class CourseSubjectLessonRow extends DataClass
    implements Insertable<CourseSubjectLessonRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String courseSubjectId;
  final DateTime lessonDate;
  final double lessonHours;
  final String coveredContent;
  final String? description;
  final String? activityDescription;
  final String? assessmentDescription;
  final DateTime? assessmentDate;
  final String? pdfName;
  final Uint8List? pdfBytes;
  final bool wasAbsent;
  const CourseSubjectLessonRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    required this.courseSubjectId,
    required this.lessonDate,
    required this.lessonHours,
    required this.coveredContent,
    this.description,
    this.activityDescription,
    this.assessmentDescription,
    this.assessmentDate,
    this.pdfName,
    this.pdfBytes,
    required this.wasAbsent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['course_subject_id'] = Variable<String>(courseSubjectId);
    map['lesson_date'] = Variable<DateTime>(lessonDate);
    map['lesson_hours'] = Variable<double>(lessonHours);
    map['covered_content'] = Variable<String>(coveredContent);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || activityDescription != null) {
      map['activity_description'] = Variable<String>(activityDescription);
    }
    if (!nullToAbsent || assessmentDescription != null) {
      map['assessment_description'] = Variable<String>(assessmentDescription);
    }
    if (!nullToAbsent || assessmentDate != null) {
      map['assessment_date'] = Variable<DateTime>(assessmentDate);
    }
    if (!nullToAbsent || pdfName != null) {
      map['pdf_name'] = Variable<String>(pdfName);
    }
    if (!nullToAbsent || pdfBytes != null) {
      map['pdf_bytes'] = Variable<Uint8List>(pdfBytes);
    }
    map['was_absent'] = Variable<bool>(wasAbsent);
    return map;
  }

  CourseSubjectLessonsCompanion toCompanion(bool nullToAbsent) {
    return CourseSubjectLessonsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      courseSubjectId: Value(courseSubjectId),
      lessonDate: Value(lessonDate),
      lessonHours: Value(lessonHours),
      coveredContent: Value(coveredContent),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      activityDescription: activityDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(activityDescription),
      assessmentDescription: assessmentDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(assessmentDescription),
      assessmentDate: assessmentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(assessmentDate),
      pdfName: pdfName == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfName),
      pdfBytes: pdfBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfBytes),
      wasAbsent: Value(wasAbsent),
    );
  }

  factory CourseSubjectLessonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseSubjectLessonRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      courseSubjectId: serializer.fromJson<String>(json['courseSubjectId']),
      lessonDate: serializer.fromJson<DateTime>(json['lessonDate']),
      lessonHours: serializer.fromJson<double>(json['lessonHours']),
      coveredContent: serializer.fromJson<String>(json['coveredContent']),
      description: serializer.fromJson<String?>(json['description']),
      activityDescription: serializer.fromJson<String?>(
        json['activityDescription'],
      ),
      assessmentDescription: serializer.fromJson<String?>(
        json['assessmentDescription'],
      ),
      assessmentDate: serializer.fromJson<DateTime?>(json['assessmentDate']),
      pdfName: serializer.fromJson<String?>(json['pdfName']),
      pdfBytes: serializer.fromJson<Uint8List?>(json['pdfBytes']),
      wasAbsent: serializer.fromJson<bool>(json['wasAbsent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'courseSubjectId': serializer.toJson<String>(courseSubjectId),
      'lessonDate': serializer.toJson<DateTime>(lessonDate),
      'lessonHours': serializer.toJson<double>(lessonHours),
      'coveredContent': serializer.toJson<String>(coveredContent),
      'description': serializer.toJson<String?>(description),
      'activityDescription': serializer.toJson<String?>(activityDescription),
      'assessmentDescription': serializer.toJson<String?>(
        assessmentDescription,
      ),
      'assessmentDate': serializer.toJson<DateTime?>(assessmentDate),
      'pdfName': serializer.toJson<String?>(pdfName),
      'pdfBytes': serializer.toJson<Uint8List?>(pdfBytes),
      'wasAbsent': serializer.toJson<bool>(wasAbsent),
    };
  }

  CourseSubjectLessonRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    String? courseSubjectId,
    DateTime? lessonDate,
    double? lessonHours,
    String? coveredContent,
    Value<String?> description = const Value.absent(),
    Value<String?> activityDescription = const Value.absent(),
    Value<String?> assessmentDescription = const Value.absent(),
    Value<DateTime?> assessmentDate = const Value.absent(),
    Value<String?> pdfName = const Value.absent(),
    Value<Uint8List?> pdfBytes = const Value.absent(),
    bool? wasAbsent,
  }) => CourseSubjectLessonRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    courseSubjectId: courseSubjectId ?? this.courseSubjectId,
    lessonDate: lessonDate ?? this.lessonDate,
    lessonHours: lessonHours ?? this.lessonHours,
    coveredContent: coveredContent ?? this.coveredContent,
    description: description.present ? description.value : this.description,
    activityDescription: activityDescription.present
        ? activityDescription.value
        : this.activityDescription,
    assessmentDescription: assessmentDescription.present
        ? assessmentDescription.value
        : this.assessmentDescription,
    assessmentDate: assessmentDate.present
        ? assessmentDate.value
        : this.assessmentDate,
    pdfName: pdfName.present ? pdfName.value : this.pdfName,
    pdfBytes: pdfBytes.present ? pdfBytes.value : this.pdfBytes,
    wasAbsent: wasAbsent ?? this.wasAbsent,
  );
  CourseSubjectLessonRow copyWithCompanion(CourseSubjectLessonsCompanion data) {
    return CourseSubjectLessonRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      courseSubjectId: data.courseSubjectId.present
          ? data.courseSubjectId.value
          : this.courseSubjectId,
      lessonDate: data.lessonDate.present
          ? data.lessonDate.value
          : this.lessonDate,
      lessonHours: data.lessonHours.present
          ? data.lessonHours.value
          : this.lessonHours,
      coveredContent: data.coveredContent.present
          ? data.coveredContent.value
          : this.coveredContent,
      description: data.description.present
          ? data.description.value
          : this.description,
      activityDescription: data.activityDescription.present
          ? data.activityDescription.value
          : this.activityDescription,
      assessmentDescription: data.assessmentDescription.present
          ? data.assessmentDescription.value
          : this.assessmentDescription,
      assessmentDate: data.assessmentDate.present
          ? data.assessmentDate.value
          : this.assessmentDate,
      pdfName: data.pdfName.present ? data.pdfName.value : this.pdfName,
      pdfBytes: data.pdfBytes.present ? data.pdfBytes.value : this.pdfBytes,
      wasAbsent: data.wasAbsent.present ? data.wasAbsent.value : this.wasAbsent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseSubjectLessonRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('courseSubjectId: $courseSubjectId, ')
          ..write('lessonDate: $lessonDate, ')
          ..write('lessonHours: $lessonHours, ')
          ..write('coveredContent: $coveredContent, ')
          ..write('description: $description, ')
          ..write('activityDescription: $activityDescription, ')
          ..write('assessmentDescription: $assessmentDescription, ')
          ..write('assessmentDate: $assessmentDate, ')
          ..write('pdfName: $pdfName, ')
          ..write('pdfBytes: $pdfBytes, ')
          ..write('wasAbsent: $wasAbsent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    courseSubjectId,
    lessonDate,
    lessonHours,
    coveredContent,
    description,
    activityDescription,
    assessmentDescription,
    assessmentDate,
    pdfName,
    $driftBlobEquality.hash(pdfBytes),
    wasAbsent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseSubjectLessonRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.courseSubjectId == this.courseSubjectId &&
          other.lessonDate == this.lessonDate &&
          other.lessonHours == this.lessonHours &&
          other.coveredContent == this.coveredContent &&
          other.description == this.description &&
          other.activityDescription == this.activityDescription &&
          other.assessmentDescription == this.assessmentDescription &&
          other.assessmentDate == this.assessmentDate &&
          other.pdfName == this.pdfName &&
          $driftBlobEquality.equals(other.pdfBytes, this.pdfBytes) &&
          other.wasAbsent == this.wasAbsent);
}

class CourseSubjectLessonsCompanion
    extends UpdateCompanion<CourseSubjectLessonRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String> courseSubjectId;
  final Value<DateTime> lessonDate;
  final Value<double> lessonHours;
  final Value<String> coveredContent;
  final Value<String?> description;
  final Value<String?> activityDescription;
  final Value<String?> assessmentDescription;
  final Value<DateTime?> assessmentDate;
  final Value<String?> pdfName;
  final Value<Uint8List?> pdfBytes;
  final Value<bool> wasAbsent;
  final Value<int> rowid;
  const CourseSubjectLessonsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.courseSubjectId = const Value.absent(),
    this.lessonDate = const Value.absent(),
    this.lessonHours = const Value.absent(),
    this.coveredContent = const Value.absent(),
    this.description = const Value.absent(),
    this.activityDescription = const Value.absent(),
    this.assessmentDescription = const Value.absent(),
    this.assessmentDate = const Value.absent(),
    this.pdfName = const Value.absent(),
    this.pdfBytes = const Value.absent(),
    this.wasAbsent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CourseSubjectLessonsCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    required String courseSubjectId,
    required DateTime lessonDate,
    required double lessonHours,
    required String coveredContent,
    this.description = const Value.absent(),
    this.activityDescription = const Value.absent(),
    this.assessmentDescription = const Value.absent(),
    this.assessmentDate = const Value.absent(),
    this.pdfName = const Value.absent(),
    this.pdfBytes = const Value.absent(),
    this.wasAbsent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       courseSubjectId = Value(courseSubjectId),
       lessonDate = Value(lessonDate),
       lessonHours = Value(lessonHours),
       coveredContent = Value(coveredContent);
  static Insertable<CourseSubjectLessonRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? courseSubjectId,
    Expression<DateTime>? lessonDate,
    Expression<double>? lessonHours,
    Expression<String>? coveredContent,
    Expression<String>? description,
    Expression<String>? activityDescription,
    Expression<String>? assessmentDescription,
    Expression<DateTime>? assessmentDate,
    Expression<String>? pdfName,
    Expression<Uint8List>? pdfBytes,
    Expression<bool>? wasAbsent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (courseSubjectId != null) 'course_subject_id': courseSubjectId,
      if (lessonDate != null) 'lesson_date': lessonDate,
      if (lessonHours != null) 'lesson_hours': lessonHours,
      if (coveredContent != null) 'covered_content': coveredContent,
      if (description != null) 'description': description,
      if (activityDescription != null)
        'activity_description': activityDescription,
      if (assessmentDescription != null)
        'assessment_description': assessmentDescription,
      if (assessmentDate != null) 'assessment_date': assessmentDate,
      if (pdfName != null) 'pdf_name': pdfName,
      if (pdfBytes != null) 'pdf_bytes': pdfBytes,
      if (wasAbsent != null) 'was_absent': wasAbsent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CourseSubjectLessonsCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String>? courseSubjectId,
    Value<DateTime>? lessonDate,
    Value<double>? lessonHours,
    Value<String>? coveredContent,
    Value<String?>? description,
    Value<String?>? activityDescription,
    Value<String?>? assessmentDescription,
    Value<DateTime?>? assessmentDate,
    Value<String?>? pdfName,
    Value<Uint8List?>? pdfBytes,
    Value<bool>? wasAbsent,
    Value<int>? rowid,
  }) {
    return CourseSubjectLessonsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      courseSubjectId: courseSubjectId ?? this.courseSubjectId,
      lessonDate: lessonDate ?? this.lessonDate,
      lessonHours: lessonHours ?? this.lessonHours,
      coveredContent: coveredContent ?? this.coveredContent,
      description: description ?? this.description,
      activityDescription: activityDescription ?? this.activityDescription,
      assessmentDescription:
          assessmentDescription ?? this.assessmentDescription,
      assessmentDate: assessmentDate ?? this.assessmentDate,
      pdfName: pdfName ?? this.pdfName,
      pdfBytes: pdfBytes ?? this.pdfBytes,
      wasAbsent: wasAbsent ?? this.wasAbsent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (courseSubjectId.present) {
      map['course_subject_id'] = Variable<String>(courseSubjectId.value);
    }
    if (lessonDate.present) {
      map['lesson_date'] = Variable<DateTime>(lessonDate.value);
    }
    if (lessonHours.present) {
      map['lesson_hours'] = Variable<double>(lessonHours.value);
    }
    if (coveredContent.present) {
      map['covered_content'] = Variable<String>(coveredContent.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (activityDescription.present) {
      map['activity_description'] = Variable<String>(activityDescription.value);
    }
    if (assessmentDescription.present) {
      map['assessment_description'] = Variable<String>(
        assessmentDescription.value,
      );
    }
    if (assessmentDate.present) {
      map['assessment_date'] = Variable<DateTime>(assessmentDate.value);
    }
    if (pdfName.present) {
      map['pdf_name'] = Variable<String>(pdfName.value);
    }
    if (pdfBytes.present) {
      map['pdf_bytes'] = Variable<Uint8List>(pdfBytes.value);
    }
    if (wasAbsent.present) {
      map['was_absent'] = Variable<bool>(wasAbsent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseSubjectLessonsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('courseSubjectId: $courseSubjectId, ')
          ..write('lessonDate: $lessonDate, ')
          ..write('lessonHours: $lessonHours, ')
          ..write('coveredContent: $coveredContent, ')
          ..write('description: $description, ')
          ..write('activityDescription: $activityDescription, ')
          ..write('assessmentDescription: $assessmentDescription, ')
          ..write('assessmentDate: $assessmentDate, ')
          ..write('pdfName: $pdfName, ')
          ..write('pdfBytes: $pdfBytes, ')
          ..write('wasAbsent: $wasAbsent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, AttachmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ownerTypeMeta = const VerificationMeta(
    'ownerType',
  );
  @override
  late final GeneratedColumn<String> ownerType = GeneratedColumn<String>(
    'owner_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileBytesMeta = const VerificationMeta(
    'fileBytes',
  );
  @override
  late final GeneratedColumn<Uint8List> fileBytes = GeneratedColumn<Uint8List>(
    'file_bytes',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    ownerType,
    ownerId,
    fileName,
    fileBytes,
    mimeType,
    category,
    dueDate,
    isCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttachmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('owner_type')) {
      context.handle(
        _ownerTypeMeta,
        ownerType.isAcceptableOrUnknown(data['owner_type']!, _ownerTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerTypeMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_bytes')) {
      context.handle(
        _fileBytesMeta,
        fileBytes.isAcceptableOrUnknown(data['file_bytes']!, _fileBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_fileBytesMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      ownerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_type'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      fileBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}file_bytes'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class AttachmentRow extends DataClass implements Insertable<AttachmentRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String ownerType;
  final String ownerId;
  final String fileName;
  final Uint8List fileBytes;
  final String? mimeType;
  final String category;
  final DateTime? dueDate;
  final bool isCompleted;
  const AttachmentRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    required this.ownerType,
    required this.ownerId,
    required this.fileName,
    required this.fileBytes,
    this.mimeType,
    required this.category,
    this.dueDate,
    required this.isCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['owner_type'] = Variable<String>(ownerType);
    map['owner_id'] = Variable<String>(ownerId);
    map['file_name'] = Variable<String>(fileName);
    map['file_bytes'] = Variable<Uint8List>(fileBytes);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      ownerType: Value(ownerType),
      ownerId: Value(ownerId),
      fileName: Value(fileName),
      fileBytes: Value(fileBytes),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      category: Value(category),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      isCompleted: Value(isCompleted),
    );
  }

  factory AttachmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      ownerType: serializer.fromJson<String>(json['ownerType']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      fileBytes: serializer.fromJson<Uint8List>(json['fileBytes']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      category: serializer.fromJson<String>(json['category']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'ownerType': serializer.toJson<String>(ownerType),
      'ownerId': serializer.toJson<String>(ownerId),
      'fileName': serializer.toJson<String>(fileName),
      'fileBytes': serializer.toJson<Uint8List>(fileBytes),
      'mimeType': serializer.toJson<String?>(mimeType),
      'category': serializer.toJson<String>(category),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  AttachmentRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    String? ownerType,
    String? ownerId,
    String? fileName,
    Uint8List? fileBytes,
    Value<String?> mimeType = const Value.absent(),
    String? category,
    Value<DateTime?> dueDate = const Value.absent(),
    bool? isCompleted,
  }) => AttachmentRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    ownerType: ownerType ?? this.ownerType,
    ownerId: ownerId ?? this.ownerId,
    fileName: fileName ?? this.fileName,
    fileBytes: fileBytes ?? this.fileBytes,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    category: category ?? this.category,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    isCompleted: isCompleted ?? this.isCompleted,
  );
  AttachmentRow copyWithCompanion(AttachmentsCompanion data) {
    return AttachmentRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      ownerType: data.ownerType.present ? data.ownerType.value : this.ownerType,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      fileBytes: data.fileBytes.present ? data.fileBytes.value : this.fileBytes,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      category: data.category.present ? data.category.value : this.category,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('fileName: $fileName, ')
          ..write('fileBytes: $fileBytes, ')
          ..write('mimeType: $mimeType, ')
          ..write('category: $category, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    ownerType,
    ownerId,
    fileName,
    $driftBlobEquality.hash(fileBytes),
    mimeType,
    category,
    dueDate,
    isCompleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.ownerType == this.ownerType &&
          other.ownerId == this.ownerId &&
          other.fileName == this.fileName &&
          $driftBlobEquality.equals(other.fileBytes, this.fileBytes) &&
          other.mimeType == this.mimeType &&
          other.category == this.category &&
          other.dueDate == this.dueDate &&
          other.isCompleted == this.isCompleted);
}

class AttachmentsCompanion extends UpdateCompanion<AttachmentRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String> ownerType;
  final Value<String> ownerId;
  final Value<String> fileName;
  final Value<Uint8List> fileBytes;
  final Value<String?> mimeType;
  final Value<String> category;
  final Value<DateTime?> dueDate;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.ownerType = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.fileBytes = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.category = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    required String ownerType,
    required String ownerId,
    required String fileName,
    required Uint8List fileBytes,
    this.mimeType = const Value.absent(),
    required String category,
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       ownerType = Value(ownerType),
       ownerId = Value(ownerId),
       fileName = Value(fileName),
       fileBytes = Value(fileBytes),
       category = Value(category);
  static Insertable<AttachmentRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? ownerType,
    Expression<String>? ownerId,
    Expression<String>? fileName,
    Expression<Uint8List>? fileBytes,
    Expression<String>? mimeType,
    Expression<String>? category,
    Expression<DateTime>? dueDate,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (ownerType != null) 'owner_type': ownerType,
      if (ownerId != null) 'owner_id': ownerId,
      if (fileName != null) 'file_name': fileName,
      if (fileBytes != null) 'file_bytes': fileBytes,
      if (mimeType != null) 'mime_type': mimeType,
      if (category != null) 'category': category,
      if (dueDate != null) 'due_date': dueDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentsCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String>? ownerType,
    Value<String>? ownerId,
    Value<String>? fileName,
    Value<Uint8List>? fileBytes,
    Value<String?>? mimeType,
    Value<String>? category,
    Value<DateTime?>? dueDate,
    Value<bool>? isCompleted,
    Value<int>? rowid,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      ownerType: ownerType ?? this.ownerType,
      ownerId: ownerId ?? this.ownerId,
      fileName: fileName ?? this.fileName,
      fileBytes: fileBytes ?? this.fileBytes,
      mimeType: mimeType ?? this.mimeType,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (ownerType.present) {
      map['owner_type'] = Variable<String>(ownerType.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (fileBytes.present) {
      map['file_bytes'] = Variable<Uint8List>(fileBytes.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('fileName: $fileName, ')
          ..write('fileBytes: $fileBytes, ')
          ..write('mimeType: $mimeType, ')
          ..write('category: $category, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ComplementaryActivitiesTable extends ComplementaryActivities
    with TableInfo<$ComplementaryActivitiesTable, ComplementaryActivityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComplementaryActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _academicProfileIdMeta = const VerificationMeta(
    'academicProfileId',
  );
  @override
  late final GeneratedColumn<String> academicProfileId =
      GeneratedColumn<String>(
        'academic_profile_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES academic_profiles (id)',
        ),
      );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workloadHoursMeta = const VerificationMeta(
    'workloadHours',
  );
  @override
  late final GeneratedColumn<int> workloadHours = GeneratedColumn<int>(
    'workload_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    academicProfileId,
    title,
    category,
    date,
    endDate,
    workloadHours,
    notes,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'complementary_activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<ComplementaryActivityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('academic_profile_id')) {
      context.handle(
        _academicProfileIdMeta,
        academicProfileId.isAcceptableOrUnknown(
          data['academic_profile_id']!,
          _academicProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('workload_hours')) {
      context.handle(
        _workloadHoursMeta,
        workloadHours.isAcceptableOrUnknown(
          data['workload_hours']!,
          _workloadHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workloadHoursMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComplementaryActivityRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComplementaryActivityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      academicProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_profile_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      workloadHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workload_hours'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ComplementaryActivitiesTable createAlias(String alias) {
    return $ComplementaryActivitiesTable(attachedDatabase, alias);
  }
}

class ComplementaryActivityRow extends DataClass
    implements Insertable<ComplementaryActivityRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String? academicProfileId;
  final String title;
  final String category;
  final DateTime date;
  final DateTime? endDate;
  final int workloadHours;
  final String? notes;
  final String status;
  const ComplementaryActivityRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    this.academicProfileId,
    required this.title,
    required this.category,
    required this.date,
    this.endDate,
    required this.workloadHours,
    this.notes,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || academicProfileId != null) {
      map['academic_profile_id'] = Variable<String>(academicProfileId);
    }
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['workload_hours'] = Variable<int>(workloadHours);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  ComplementaryActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ComplementaryActivitiesCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      academicProfileId: academicProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(academicProfileId),
      title: Value(title),
      category: Value(category),
      date: Value(date),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      workloadHours: Value(workloadHours),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
    );
  }

  factory ComplementaryActivityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComplementaryActivityRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      academicProfileId: serializer.fromJson<String?>(
        json['academicProfileId'],
      ),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      date: serializer.fromJson<DateTime>(json['date']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      workloadHours: serializer.fromJson<int>(json['workloadHours']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'academicProfileId': serializer.toJson<String?>(academicProfileId),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'date': serializer.toJson<DateTime>(date),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'workloadHours': serializer.toJson<int>(workloadHours),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
    };
  }

  ComplementaryActivityRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    Value<String?> academicProfileId = const Value.absent(),
    String? title,
    String? category,
    DateTime? date,
    Value<DateTime?> endDate = const Value.absent(),
    int? workloadHours,
    Value<String?> notes = const Value.absent(),
    String? status,
  }) => ComplementaryActivityRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    academicProfileId: academicProfileId.present
        ? academicProfileId.value
        : this.academicProfileId,
    title: title ?? this.title,
    category: category ?? this.category,
    date: date ?? this.date,
    endDate: endDate.present ? endDate.value : this.endDate,
    workloadHours: workloadHours ?? this.workloadHours,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
  );
  ComplementaryActivityRow copyWithCompanion(
    ComplementaryActivitiesCompanion data,
  ) {
    return ComplementaryActivityRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      academicProfileId: data.academicProfileId.present
          ? data.academicProfileId.value
          : this.academicProfileId,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      date: data.date.present ? data.date.value : this.date,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      workloadHours: data.workloadHours.present
          ? data.workloadHours.value
          : this.workloadHours,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComplementaryActivityRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('academicProfileId: $academicProfileId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('endDate: $endDate, ')
          ..write('workloadHours: $workloadHours, ')
          ..write('notes: $notes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    academicProfileId,
    title,
    category,
    date,
    endDate,
    workloadHours,
    notes,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComplementaryActivityRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.academicProfileId == this.academicProfileId &&
          other.title == this.title &&
          other.category == this.category &&
          other.date == this.date &&
          other.endDate == this.endDate &&
          other.workloadHours == this.workloadHours &&
          other.notes == this.notes &&
          other.status == this.status);
}

class ComplementaryActivitiesCompanion
    extends UpdateCompanion<ComplementaryActivityRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String?> academicProfileId;
  final Value<String> title;
  final Value<String> category;
  final Value<DateTime> date;
  final Value<DateTime?> endDate;
  final Value<int> workloadHours;
  final Value<String?> notes;
  final Value<String> status;
  final Value<int> rowid;
  const ComplementaryActivitiesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.academicProfileId = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.date = const Value.absent(),
    this.endDate = const Value.absent(),
    this.workloadHours = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ComplementaryActivitiesCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    this.academicProfileId = const Value.absent(),
    required String title,
    required String category,
    required DateTime date,
    this.endDate = const Value.absent(),
    required int workloadHours,
    this.notes = const Value.absent(),
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       title = Value(title),
       category = Value(category),
       date = Value(date),
       workloadHours = Value(workloadHours),
       status = Value(status);
  static Insertable<ComplementaryActivityRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? academicProfileId,
    Expression<String>? title,
    Expression<String>? category,
    Expression<DateTime>? date,
    Expression<DateTime>? endDate,
    Expression<int>? workloadHours,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (academicProfileId != null) 'academic_profile_id': academicProfileId,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (date != null) 'date': date,
      if (endDate != null) 'end_date': endDate,
      if (workloadHours != null) 'workload_hours': workloadHours,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ComplementaryActivitiesCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String?>? academicProfileId,
    Value<String>? title,
    Value<String>? category,
    Value<DateTime>? date,
    Value<DateTime?>? endDate,
    Value<int>? workloadHours,
    Value<String?>? notes,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return ComplementaryActivitiesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      academicProfileId: academicProfileId ?? this.academicProfileId,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      workloadHours: workloadHours ?? this.workloadHours,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (academicProfileId.present) {
      map['academic_profile_id'] = Variable<String>(academicProfileId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (workloadHours.present) {
      map['workload_hours'] = Variable<int>(workloadHours.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComplementaryActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('academicProfileId: $academicProfileId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('endDate: $endDate, ')
          ..write('workloadHours: $workloadHours, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InternshipsTable extends Internships
    with TableInfo<$InternshipsTable, InternshipRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InternshipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _academicProfileIdMeta = const VerificationMeta(
    'academicProfileId',
  );
  @override
  late final GeneratedColumn<String> academicProfileId =
      GeneratedColumn<String>(
        'academic_profile_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES academic_profiles (id)',
        ),
      );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supervisorMeta = const VerificationMeta(
    'supervisor',
  );
  @override
  late final GeneratedColumn<String> supervisor = GeneratedColumn<String>(
    'supervisor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalHoursMeta = const VerificationMeta(
    'totalHours',
  );
  @override
  late final GeneratedColumn<int> totalHours = GeneratedColumn<int>(
    'total_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedHoursMeta = const VerificationMeta(
    'completedHours',
  );
  @override
  late final GeneratedColumn<int> completedHours = GeneratedColumn<int>(
    'completed_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    academicProfileId,
    location,
    supervisor,
    startDate,
    endDate,
    totalHours,
    completedHours,
    status,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'internships';
  @override
  VerificationContext validateIntegrity(
    Insertable<InternshipRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('academic_profile_id')) {
      context.handle(
        _academicProfileIdMeta,
        academicProfileId.isAcceptableOrUnknown(
          data['academic_profile_id']!,
          _academicProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('supervisor')) {
      context.handle(
        _supervisorMeta,
        supervisor.isAcceptableOrUnknown(data['supervisor']!, _supervisorMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('total_hours')) {
      context.handle(
        _totalHoursMeta,
        totalHours.isAcceptableOrUnknown(data['total_hours']!, _totalHoursMeta),
      );
    } else if (isInserting) {
      context.missing(_totalHoursMeta);
    }
    if (data.containsKey('completed_hours')) {
      context.handle(
        _completedHoursMeta,
        completedHours.isAcceptableOrUnknown(
          data['completed_hours']!,
          _completedHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedHoursMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InternshipRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InternshipRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      academicProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_profile_id'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      supervisor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supervisor'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      totalHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_hours'],
      )!,
      completedHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_hours'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $InternshipsTable createAlias(String alias) {
    return $InternshipsTable(attachedDatabase, alias);
  }
}

class InternshipRow extends DataClass implements Insertable<InternshipRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String? academicProfileId;
  final String location;
  final String? supervisor;
  final DateTime startDate;
  final DateTime? endDate;
  final int totalHours;
  final int completedHours;
  final String status;
  final String? notes;
  const InternshipRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    this.academicProfileId,
    required this.location,
    this.supervisor,
    required this.startDate,
    this.endDate,
    required this.totalHours,
    required this.completedHours,
    required this.status,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || academicProfileId != null) {
      map['academic_profile_id'] = Variable<String>(academicProfileId);
    }
    map['location'] = Variable<String>(location);
    if (!nullToAbsent || supervisor != null) {
      map['supervisor'] = Variable<String>(supervisor);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['total_hours'] = Variable<int>(totalHours);
    map['completed_hours'] = Variable<int>(completedHours);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  InternshipsCompanion toCompanion(bool nullToAbsent) {
    return InternshipsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      academicProfileId: academicProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(academicProfileId),
      location: Value(location),
      supervisor: supervisor == null && nullToAbsent
          ? const Value.absent()
          : Value(supervisor),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      totalHours: Value(totalHours),
      completedHours: Value(completedHours),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory InternshipRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InternshipRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      academicProfileId: serializer.fromJson<String?>(
        json['academicProfileId'],
      ),
      location: serializer.fromJson<String>(json['location']),
      supervisor: serializer.fromJson<String?>(json['supervisor']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      totalHours: serializer.fromJson<int>(json['totalHours']),
      completedHours: serializer.fromJson<int>(json['completedHours']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'academicProfileId': serializer.toJson<String?>(academicProfileId),
      'location': serializer.toJson<String>(location),
      'supervisor': serializer.toJson<String?>(supervisor),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'totalHours': serializer.toJson<int>(totalHours),
      'completedHours': serializer.toJson<int>(completedHours),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  InternshipRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    Value<String?> academicProfileId = const Value.absent(),
    String? location,
    Value<String?> supervisor = const Value.absent(),
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    int? totalHours,
    int? completedHours,
    String? status,
    Value<String?> notes = const Value.absent(),
  }) => InternshipRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    academicProfileId: academicProfileId.present
        ? academicProfileId.value
        : this.academicProfileId,
    location: location ?? this.location,
    supervisor: supervisor.present ? supervisor.value : this.supervisor,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    totalHours: totalHours ?? this.totalHours,
    completedHours: completedHours ?? this.completedHours,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
  );
  InternshipRow copyWithCompanion(InternshipsCompanion data) {
    return InternshipRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      academicProfileId: data.academicProfileId.present
          ? data.academicProfileId.value
          : this.academicProfileId,
      location: data.location.present ? data.location.value : this.location,
      supervisor: data.supervisor.present
          ? data.supervisor.value
          : this.supervisor,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      totalHours: data.totalHours.present
          ? data.totalHours.value
          : this.totalHours,
      completedHours: data.completedHours.present
          ? data.completedHours.value
          : this.completedHours,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InternshipRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('academicProfileId: $academicProfileId, ')
          ..write('location: $location, ')
          ..write('supervisor: $supervisor, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('totalHours: $totalHours, ')
          ..write('completedHours: $completedHours, ')
          ..write('status: $status, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    academicProfileId,
    location,
    supervisor,
    startDate,
    endDate,
    totalHours,
    completedHours,
    status,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InternshipRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.academicProfileId == this.academicProfileId &&
          other.location == this.location &&
          other.supervisor == this.supervisor &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.totalHours == this.totalHours &&
          other.completedHours == this.completedHours &&
          other.status == this.status &&
          other.notes == this.notes);
}

class InternshipsCompanion extends UpdateCompanion<InternshipRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String?> academicProfileId;
  final Value<String> location;
  final Value<String?> supervisor;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<int> totalHours;
  final Value<int> completedHours;
  final Value<String> status;
  final Value<String?> notes;
  final Value<int> rowid;
  const InternshipsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.academicProfileId = const Value.absent(),
    this.location = const Value.absent(),
    this.supervisor = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.totalHours = const Value.absent(),
    this.completedHours = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InternshipsCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    this.academicProfileId = const Value.absent(),
    required String location,
    this.supervisor = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required int totalHours,
    required int completedHours,
    required String status,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       location = Value(location),
       startDate = Value(startDate),
       totalHours = Value(totalHours),
       completedHours = Value(completedHours),
       status = Value(status);
  static Insertable<InternshipRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? academicProfileId,
    Expression<String>? location,
    Expression<String>? supervisor,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? totalHours,
    Expression<int>? completedHours,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (academicProfileId != null) 'academic_profile_id': academicProfileId,
      if (location != null) 'location': location,
      if (supervisor != null) 'supervisor': supervisor,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (totalHours != null) 'total_hours': totalHours,
      if (completedHours != null) 'completed_hours': completedHours,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InternshipsCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String?>? academicProfileId,
    Value<String>? location,
    Value<String?>? supervisor,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<int>? totalHours,
    Value<int>? completedHours,
    Value<String>? status,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return InternshipsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      academicProfileId: academicProfileId ?? this.academicProfileId,
      location: location ?? this.location,
      supervisor: supervisor ?? this.supervisor,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalHours: totalHours ?? this.totalHours,
      completedHours: completedHours ?? this.completedHours,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (academicProfileId.present) {
      map['academic_profile_id'] = Variable<String>(academicProfileId.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (supervisor.present) {
      map['supervisor'] = Variable<String>(supervisor.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (totalHours.present) {
      map['total_hours'] = Variable<int>(totalHours.value);
    }
    if (completedHours.present) {
      map['completed_hours'] = Variable<int>(completedHours.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InternshipsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('academicProfileId: $academicProfileId, ')
          ..write('location: $location, ')
          ..write('supervisor: $supervisor, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('totalHours: $totalHours, ')
          ..write('completedHours: $completedHours, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExtensionActivitiesTable extends ExtensionActivities
    with TableInfo<$ExtensionActivitiesTable, ExtensionActivityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExtensionActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _academicProfileIdMeta = const VerificationMeta(
    'academicProfileId',
  );
  @override
  late final GeneratedColumn<String> academicProfileId =
      GeneratedColumn<String>(
        'academic_profile_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES academic_profiles (id)',
        ),
      );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workloadHoursMeta = const VerificationMeta(
    'workloadHours',
  );
  @override
  late final GeneratedColumn<int> workloadHours = GeneratedColumn<int>(
    'workload_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    academicProfileId,
    title,
    type,
    date,
    workloadHours,
    notes,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'extension_activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExtensionActivityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('academic_profile_id')) {
      context.handle(
        _academicProfileIdMeta,
        academicProfileId.isAcceptableOrUnknown(
          data['academic_profile_id']!,
          _academicProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('workload_hours')) {
      context.handle(
        _workloadHoursMeta,
        workloadHours.isAcceptableOrUnknown(
          data['workload_hours']!,
          _workloadHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workloadHoursMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExtensionActivityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExtensionActivityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      academicProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_profile_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      workloadHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workload_hours'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ExtensionActivitiesTable createAlias(String alias) {
    return $ExtensionActivitiesTable(attachedDatabase, alias);
  }
}

class ExtensionActivityRow extends DataClass
    implements Insertable<ExtensionActivityRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String? academicProfileId;
  final String title;
  final String type;
  final DateTime date;
  final int workloadHours;
  final String? notes;
  final String status;
  const ExtensionActivityRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    this.academicProfileId,
    required this.title,
    required this.type,
    required this.date,
    required this.workloadHours,
    this.notes,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || academicProfileId != null) {
      map['academic_profile_id'] = Variable<String>(academicProfileId);
    }
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    map['workload_hours'] = Variable<int>(workloadHours);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  ExtensionActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ExtensionActivitiesCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      academicProfileId: academicProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(academicProfileId),
      title: Value(title),
      type: Value(type),
      date: Value(date),
      workloadHours: Value(workloadHours),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
    );
  }

  factory ExtensionActivityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExtensionActivityRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      academicProfileId: serializer.fromJson<String?>(
        json['academicProfileId'],
      ),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      workloadHours: serializer.fromJson<int>(json['workloadHours']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'academicProfileId': serializer.toJson<String?>(academicProfileId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'workloadHours': serializer.toJson<int>(workloadHours),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
    };
  }

  ExtensionActivityRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    Value<String?> academicProfileId = const Value.absent(),
    String? title,
    String? type,
    DateTime? date,
    int? workloadHours,
    Value<String?> notes = const Value.absent(),
    String? status,
  }) => ExtensionActivityRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    academicProfileId: academicProfileId.present
        ? academicProfileId.value
        : this.academicProfileId,
    title: title ?? this.title,
    type: type ?? this.type,
    date: date ?? this.date,
    workloadHours: workloadHours ?? this.workloadHours,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
  );
  ExtensionActivityRow copyWithCompanion(ExtensionActivitiesCompanion data) {
    return ExtensionActivityRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      academicProfileId: data.academicProfileId.present
          ? data.academicProfileId.value
          : this.academicProfileId,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      workloadHours: data.workloadHours.present
          ? data.workloadHours.value
          : this.workloadHours,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExtensionActivityRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('academicProfileId: $academicProfileId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('workloadHours: $workloadHours, ')
          ..write('notes: $notes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    academicProfileId,
    title,
    type,
    date,
    workloadHours,
    notes,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExtensionActivityRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.academicProfileId == this.academicProfileId &&
          other.title == this.title &&
          other.type == this.type &&
          other.date == this.date &&
          other.workloadHours == this.workloadHours &&
          other.notes == this.notes &&
          other.status == this.status);
}

class ExtensionActivitiesCompanion
    extends UpdateCompanion<ExtensionActivityRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String?> academicProfileId;
  final Value<String> title;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<int> workloadHours;
  final Value<String?> notes;
  final Value<String> status;
  final Value<int> rowid;
  const ExtensionActivitiesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.academicProfileId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.workloadHours = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExtensionActivitiesCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    this.academicProfileId = const Value.absent(),
    required String title,
    required String type,
    required DateTime date,
    required int workloadHours,
    this.notes = const Value.absent(),
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       title = Value(title),
       type = Value(type),
       date = Value(date),
       workloadHours = Value(workloadHours),
       status = Value(status);
  static Insertable<ExtensionActivityRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? academicProfileId,
    Expression<String>? title,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<int>? workloadHours,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (academicProfileId != null) 'academic_profile_id': academicProfileId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (workloadHours != null) 'workload_hours': workloadHours,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExtensionActivitiesCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String?>? academicProfileId,
    Value<String>? title,
    Value<String>? type,
    Value<DateTime>? date,
    Value<int>? workloadHours,
    Value<String?>? notes,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return ExtensionActivitiesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      academicProfileId: academicProfileId ?? this.academicProfileId,
      title: title ?? this.title,
      type: type ?? this.type,
      date: date ?? this.date,
      workloadHours: workloadHours ?? this.workloadHours,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (academicProfileId.present) {
      map['academic_profile_id'] = Variable<String>(academicProfileId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (workloadHours.present) {
      map['workload_hours'] = Variable<int>(workloadHours.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExtensionActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('academicProfileId: $academicProfileId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('workloadHours: $workloadHours, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudySubjectsTable extends StudySubjects
    with TableInfo<$StudySubjectsTable, StudySubjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    name,
    colorValue,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySubjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySubjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySubjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $StudySubjectsTable createAlias(String alias) {
    return $StudySubjectsTable(attachedDatabase, alias);
  }
}

class StudySubjectRow extends DataClass implements Insertable<StudySubjectRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String name;
  final int? colorValue;
  final String? description;
  const StudySubjectRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    required this.name,
    this.colorValue,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  StudySubjectsCompanion toCompanion(bool nullToAbsent) {
    return StudySubjectsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      name: Value(name),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory StudySubjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySubjectRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int?>(colorValue),
      'description': serializer.toJson<String?>(description),
    };
  }

  StudySubjectRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    String? name,
    Value<int?> colorValue = const Value.absent(),
    Value<String?> description = const Value.absent(),
  }) => StudySubjectRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    name: name ?? this.name,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    description: description.present ? description.value : this.description,
  );
  StudySubjectRow copyWithCompanion(StudySubjectsCompanion data) {
    return StudySubjectRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      name: data.name.present ? data.name.value : this.name,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySubjectRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    name,
    colorValue,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySubjectRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.name == this.name &&
          other.colorValue == this.colorValue &&
          other.description == this.description);
}

class StudySubjectsCompanion extends UpdateCompanion<StudySubjectRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String> name;
  final Value<int?> colorValue;
  final Value<String?> description;
  final Value<int> rowid;
  const StudySubjectsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudySubjectsCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    required String name,
    this.colorValue = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       name = Value(name);
  static Insertable<StudySubjectRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? name,
    Expression<int>? colorValue,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudySubjectsCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String>? name,
    Value<int?>? colorValue,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return StudySubjectsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySubjectsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyTopicsTable extends StudyTopics
    with TableInfo<$StudyTopicsTable, StudyTopicRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyTopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _studySubjectIdMeta = const VerificationMeta(
    'studySubjectId',
  );
  @override
  late final GeneratedColumn<String> studySubjectId = GeneratedColumn<String>(
    'study_subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_subjects (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    studySubjectId,
    name,
    description,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyTopicRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('study_subject_id')) {
      context.handle(
        _studySubjectIdMeta,
        studySubjectId.isAcceptableOrUnknown(
          data['study_subject_id']!,
          _studySubjectIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studySubjectIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyTopicRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyTopicRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      studySubjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_subject_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $StudyTopicsTable createAlias(String alias) {
    return $StudyTopicsTable(attachedDatabase, alias);
  }
}

class StudyTopicRow extends DataClass implements Insertable<StudyTopicRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String studySubjectId;
  final String name;
  final String? description;
  final String status;
  const StudyTopicRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    required this.studySubjectId,
    required this.name,
    this.description,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['study_subject_id'] = Variable<String>(studySubjectId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  StudyTopicsCompanion toCompanion(bool nullToAbsent) {
    return StudyTopicsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      studySubjectId: Value(studySubjectId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
    );
  }

  factory StudyTopicRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyTopicRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      studySubjectId: serializer.fromJson<String>(json['studySubjectId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'studySubjectId': serializer.toJson<String>(studySubjectId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
    };
  }

  StudyTopicRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    String? studySubjectId,
    String? name,
    Value<String?> description = const Value.absent(),
    String? status,
  }) => StudyTopicRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    studySubjectId: studySubjectId ?? this.studySubjectId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    status: status ?? this.status,
  );
  StudyTopicRow copyWithCompanion(StudyTopicsCompanion data) {
    return StudyTopicRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      studySubjectId: data.studySubjectId.present
          ? data.studySubjectId.value
          : this.studySubjectId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyTopicRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('studySubjectId: $studySubjectId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    studySubjectId,
    name,
    description,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyTopicRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.studySubjectId == this.studySubjectId &&
          other.name == this.name &&
          other.description == this.description &&
          other.status == this.status);
}

class StudyTopicsCompanion extends UpdateCompanion<StudyTopicRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String> studySubjectId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> status;
  final Value<int> rowid;
  const StudyTopicsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.studySubjectId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyTopicsCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    required String studySubjectId,
    required String name,
    this.description = const Value.absent(),
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       studySubjectId = Value(studySubjectId),
       name = Value(name),
       status = Value(status);
  static Insertable<StudyTopicRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? studySubjectId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (studySubjectId != null) 'study_subject_id': studySubjectId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyTopicsCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String>? studySubjectId,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return StudyTopicsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      studySubjectId: studySubjectId ?? this.studySubjectId,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (studySubjectId.present) {
      map['study_subject_id'] = Variable<String>(studySubjectId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyTopicsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('studySubjectId: $studySubjectId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyTasksTable extends StudyTasks
    with TableInfo<$StudyTasksTable, StudyTaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _studySubjectIdMeta = const VerificationMeta(
    'studySubjectId',
  );
  @override
  late final GeneratedColumn<String> studySubjectId = GeneratedColumn<String>(
    'study_subject_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_subjects (id)',
    ),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    title,
    description,
    studySubjectId,
    dueDate,
    priority,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyTaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('study_subject_id')) {
      context.handle(
        _studySubjectIdMeta,
        studySubjectId.isAcceptableOrUnknown(
          data['study_subject_id']!,
          _studySubjectIdMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyTaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyTaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      studySubjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_subject_id'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $StudyTasksTable createAlias(String alias) {
    return $StudyTasksTable(attachedDatabase, alias);
  }
}

class StudyTaskRow extends DataClass implements Insertable<StudyTaskRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String title;
  final String? description;
  final String? studySubjectId;
  final DateTime? dueDate;
  final String priority;
  final String status;
  const StudyTaskRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    required this.title,
    this.description,
    this.studySubjectId,
    this.dueDate,
    required this.priority,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || studySubjectId != null) {
      map['study_subject_id'] = Variable<String>(studySubjectId);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['priority'] = Variable<String>(priority);
    map['status'] = Variable<String>(status);
    return map;
  }

  StudyTasksCompanion toCompanion(bool nullToAbsent) {
    return StudyTasksCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      studySubjectId: studySubjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(studySubjectId),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      priority: Value(priority),
      status: Value(status),
    );
  }

  factory StudyTaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyTaskRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      studySubjectId: serializer.fromJson<String?>(json['studySubjectId']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      priority: serializer.fromJson<String>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'studySubjectId': serializer.toJson<String?>(studySubjectId),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'priority': serializer.toJson<String>(priority),
      'status': serializer.toJson<String>(status),
    };
  }

  StudyTaskRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> studySubjectId = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    String? priority,
    String? status,
  }) => StudyTaskRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    studySubjectId: studySubjectId.present
        ? studySubjectId.value
        : this.studySubjectId,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    priority: priority ?? this.priority,
    status: status ?? this.status,
  );
  StudyTaskRow copyWithCompanion(StudyTasksCompanion data) {
    return StudyTaskRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      studySubjectId: data.studySubjectId.present
          ? data.studySubjectId.value
          : this.studySubjectId,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyTaskRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('studySubjectId: $studySubjectId, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    title,
    description,
    studySubjectId,
    dueDate,
    priority,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyTaskRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.title == this.title &&
          other.description == this.description &&
          other.studySubjectId == this.studySubjectId &&
          other.dueDate == this.dueDate &&
          other.priority == this.priority &&
          other.status == this.status);
}

class StudyTasksCompanion extends UpdateCompanion<StudyTaskRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> studySubjectId;
  final Value<DateTime?> dueDate;
  final Value<String> priority;
  final Value<String> status;
  final Value<int> rowid;
  const StudyTasksCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.studySubjectId = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyTasksCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.studySubjectId = const Value.absent(),
    this.dueDate = const Value.absent(),
    required String priority,
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       title = Value(title),
       priority = Value(priority),
       status = Value(status);
  static Insertable<StudyTaskRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? studySubjectId,
    Expression<DateTime>? dueDate,
    Expression<String>? priority,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (studySubjectId != null) 'study_subject_id': studySubjectId,
      if (dueDate != null) 'due_date': dueDate,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyTasksCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? studySubjectId,
    Value<DateTime?>? dueDate,
    Value<String>? priority,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return StudyTasksCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      title: title ?? this.title,
      description: description ?? this.description,
      studySubjectId: studySubjectId ?? this.studySubjectId,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (studySubjectId.present) {
      map['study_subject_id'] = Variable<String>(studySubjectId.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyTasksCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('studySubjectId: $studySubjectId, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudySessionsTable extends StudySessions
    with TableInfo<$StudySessionsTable, StudySessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _studySubjectIdMeta = const VerificationMeta(
    'studySubjectId',
  );
  @override
  late final GeneratedColumn<String> studySubjectId = GeneratedColumn<String>(
    'study_subject_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_subjects (id)',
    ),
  );
  static const VerificationMeta _studyTopicIdMeta = const VerificationMeta(
    'studyTopicId',
  );
  @override
  late final GeneratedColumn<String> studyTopicId = GeneratedColumn<String>(
    'study_topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_topics (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    studySubjectId,
    studyTopicId,
    startedAt,
    endedAt,
    durationMinutes,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('study_subject_id')) {
      context.handle(
        _studySubjectIdMeta,
        studySubjectId.isAcceptableOrUnknown(
          data['study_subject_id']!,
          _studySubjectIdMeta,
        ),
      );
    }
    if (data.containsKey('study_topic_id')) {
      context.handle(
        _studyTopicIdMeta,
        studyTopicId.isAcceptableOrUnknown(
          data['study_topic_id']!,
          _studyTopicIdMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      studySubjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_subject_id'],
      ),
      studyTopicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_topic_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $StudySessionsTable createAlias(String alias) {
    return $StudySessionsTable(attachedDatabase, alias);
  }
}

class StudySessionRow extends DataClass implements Insertable<StudySessionRow> {
  final String id;
  final String? remoteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final bool isDeleted;
  final String? studySubjectId;
  final String? studyTopicId;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationMinutes;
  final String? notes;
  const StudySessionRow({
    required this.id,
    this.remoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
    this.studySubjectId,
    this.studyTopicId,
    required this.startedAt,
    required this.endedAt,
    required this.durationMinutes,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || studySubjectId != null) {
      map['study_subject_id'] = Variable<String>(studySubjectId);
    }
    if (!nullToAbsent || studyTopicId != null) {
      map['study_topic_id'] = Variable<String>(studyTopicId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  StudySessionsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
      studySubjectId: studySubjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(studySubjectId),
      studyTopicId: studyTopicId == null && nullToAbsent
          ? const Value.absent()
          : Value(studyTopicId),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      durationMinutes: Value(durationMinutes),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory StudySessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySessionRow(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      studySubjectId: serializer.fromJson<String?>(json['studySubjectId']),
      studyTopicId: serializer.fromJson<String?>(json['studyTopicId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'studySubjectId': serializer.toJson<String?>(studySubjectId),
      'studyTopicId': serializer.toJson<String?>(studyTopicId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  StudySessionRow copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    bool? isDeleted,
    Value<String?> studySubjectId = const Value.absent(),
    Value<String?> studyTopicId = const Value.absent(),
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    Value<String?> notes = const Value.absent(),
  }) => StudySessionRow(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    studySubjectId: studySubjectId.present
        ? studySubjectId.value
        : this.studySubjectId,
    studyTopicId: studyTopicId.present ? studyTopicId.value : this.studyTopicId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    notes: notes.present ? notes.value : this.notes,
  );
  StudySessionRow copyWithCompanion(StudySessionsCompanion data) {
    return StudySessionRow(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      studySubjectId: data.studySubjectId.present
          ? data.studySubjectId.value
          : this.studySubjectId,
      studyTopicId: data.studyTopicId.present
          ? data.studyTopicId.value
          : this.studyTopicId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionRow(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('studySubjectId: $studySubjectId, ')
          ..write('studyTopicId: $studyTopicId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
    studySubjectId,
    studyTopicId,
    startedAt,
    endedAt,
    durationMinutes,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySessionRow &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted &&
          other.studySubjectId == this.studySubjectId &&
          other.studyTopicId == this.studyTopicId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.durationMinutes == this.durationMinutes &&
          other.notes == this.notes);
}

class StudySessionsCompanion extends UpdateCompanion<StudySessionRow> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<bool> isDeleted;
  final Value<String?> studySubjectId;
  final Value<String?> studyTopicId;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<int> durationMinutes;
  final Value<String?> notes;
  final Value<int> rowid;
  const StudySessionsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.studySubjectId = const Value.absent(),
    this.studyTopicId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudySessionsCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncStatus,
    this.isDeleted = const Value.absent(),
    this.studySubjectId = const Value.absent(),
    this.studyTopicId = const Value.absent(),
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationMinutes,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       syncStatus = Value(syncStatus),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       durationMinutes = Value(durationMinutes);
  static Insertable<StudySessionRow> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isDeleted,
    Expression<String>? studySubjectId,
    Expression<String>? studyTopicId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? durationMinutes,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (studySubjectId != null) 'study_subject_id': studySubjectId,
      if (studyTopicId != null) 'study_topic_id': studyTopicId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudySessionsCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<bool>? isDeleted,
    Value<String?>? studySubjectId,
    Value<String?>? studyTopicId,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<int>? durationMinutes,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return StudySessionsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      studySubjectId: studySubjectId ?? this.studySubjectId,
      studyTopicId: studyTopicId ?? this.studyTopicId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (studySubjectId.present) {
      map['study_subject_id'] = Variable<String>(studySubjectId.value);
    }
    if (studyTopicId.present) {
      map['study_topic_id'] = Variable<String>(studyTopicId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('studySubjectId: $studySubjectId, ')
          ..write('studyTopicId: $studyTopicId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueEntriesTable extends SyncQueueEntries
    with TableInfo<$SyncQueueEntriesTable, SyncQueueEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityVersionMeta = const VerificationMeta(
    'entityVersion',
  );
  @override
  late final GeneratedColumn<int> entityVersion = GeneratedColumn<int>(
    'entity_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conflictPolicyMeta = const VerificationMeta(
    'conflictPolicy',
  );
  @override
  late final GeneratedColumn<String> conflictPolicy = GeneratedColumn<String>(
    'conflict_policy',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('client_wins'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    entityVersion,
    operation,
    payloadJson,
    status,
    deviceId,
    conflictPolicy,
    retryCount,
    createdAt,
    lastAttemptAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('entity_version')) {
      context.handle(
        _entityVersionMeta,
        entityVersion.isAcceptableOrUnknown(
          data['entity_version']!,
          _entityVersionMeta,
        ),
      );
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('conflict_policy')) {
      context.handle(
        _conflictPolicyMeta,
        conflictPolicy.isAcceptableOrUnknown(
          data['conflict_policy']!,
          _conflictPolicyMeta,
        ),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      entityVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_version'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      conflictPolicy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conflict_policy'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $SyncQueueEntriesTable createAlias(String alias) {
    return $SyncQueueEntriesTable(attachedDatabase, alias);
  }
}

class SyncQueueEntryRow extends DataClass
    implements Insertable<SyncQueueEntryRow> {
  final String id;
  final String entityType;
  final String entityId;
  final int entityVersion;
  final String operation;
  final String payloadJson;
  final String status;
  final String? deviceId;
  final String conflictPolicy;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  final DateTime? lastSyncedAt;
  const SyncQueueEntryRow({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.entityVersion,
    required this.operation,
    required this.payloadJson,
    required this.status,
    this.deviceId,
    required this.conflictPolicy,
    required this.retryCount,
    required this.createdAt,
    this.lastAttemptAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['entity_version'] = Variable<int>(entityVersion);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['conflict_policy'] = Variable<String>(conflictPolicy);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  SyncQueueEntriesCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueEntriesCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      entityVersion: Value(entityVersion),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      status: Value(status),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      conflictPolicy: Value(conflictPolicy),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory SyncQueueEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueEntryRow(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      entityVersion: serializer.fromJson<int>(json['entityVersion']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      status: serializer.fromJson<String>(json['status']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      conflictPolicy: serializer.fromJson<String>(json['conflictPolicy']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'entityVersion': serializer.toJson<int>(entityVersion),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'status': serializer.toJson<String>(status),
      'deviceId': serializer.toJson<String?>(deviceId),
      'conflictPolicy': serializer.toJson<String>(conflictPolicy),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  SyncQueueEntryRow copyWith({
    String? id,
    String? entityType,
    String? entityId,
    int? entityVersion,
    String? operation,
    String? payloadJson,
    String? status,
    Value<String?> deviceId = const Value.absent(),
    String? conflictPolicy,
    int? retryCount,
    DateTime? createdAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => SyncQueueEntryRow(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    entityVersion: entityVersion ?? this.entityVersion,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    status: status ?? this.status,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    conflictPolicy: conflictPolicy ?? this.conflictPolicy,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  SyncQueueEntryRow copyWithCompanion(SyncQueueEntriesCompanion data) {
    return SyncQueueEntryRow(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      entityVersion: data.entityVersion.present
          ? data.entityVersion.value
          : this.entityVersion,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      status: data.status.present ? data.status.value : this.status,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      conflictPolicy: data.conflictPolicy.present
          ? data.conflictPolicy.value
          : this.conflictPolicy,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueEntryRow(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('entityVersion: $entityVersion, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('deviceId: $deviceId, ')
          ..write('conflictPolicy: $conflictPolicy, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    entityVersion,
    operation,
    payloadJson,
    status,
    deviceId,
    conflictPolicy,
    retryCount,
    createdAt,
    lastAttemptAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueEntryRow &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.entityVersion == this.entityVersion &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.status == this.status &&
          other.deviceId == this.deviceId &&
          other.conflictPolicy == this.conflictPolicy &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SyncQueueEntriesCompanion extends UpdateCompanion<SyncQueueEntryRow> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<int> entityVersion;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<String> status;
  final Value<String?> deviceId;
  final Value<String> conflictPolicy;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const SyncQueueEntriesCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.entityVersion = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.status = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.conflictPolicy = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueEntriesCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    this.entityVersion = const Value.absent(),
    required String operation,
    required String payloadJson,
    this.status = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.conflictPolicy = const Value.absent(),
    this.retryCount = const Value.absent(),
    required DateTime createdAt,
    this.lastAttemptAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueEntryRow> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<int>? entityVersion,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<String>? status,
    Expression<String>? deviceId,
    Expression<String>? conflictPolicy,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (entityVersion != null) 'entity_version': entityVersion,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (status != null) 'status': status,
      if (deviceId != null) 'device_id': deviceId,
      if (conflictPolicy != null) 'conflict_policy': conflictPolicy,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<int>? entityVersion,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<String>? status,
    Value<String?>? deviceId,
    Value<String>? conflictPolicy,
    Value<int>? retryCount,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return SyncQueueEntriesCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      entityVersion: entityVersion ?? this.entityVersion,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      status: status ?? this.status,
      deviceId: deviceId ?? this.deviceId,
      conflictPolicy: conflictPolicy ?? this.conflictPolicy,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (entityVersion.present) {
      map['entity_version'] = Variable<int>(entityVersion.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (conflictPolicy.present) {
      map['conflict_policy'] = Variable<String>(conflictPolicy.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueEntriesCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('entityVersion: $entityVersion, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('deviceId: $deviceId, ')
          ..write('conflictPolicy: $conflictPolicy, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AcademicProfilesTable academicProfiles = $AcademicProfilesTable(
    this,
  );
  late final $CourseSubjectsTable courseSubjects = $CourseSubjectsTable(this);
  late final $CourseSubjectLessonsTable courseSubjectLessons =
      $CourseSubjectLessonsTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $ComplementaryActivitiesTable complementaryActivities =
      $ComplementaryActivitiesTable(this);
  late final $InternshipsTable internships = $InternshipsTable(this);
  late final $ExtensionActivitiesTable extensionActivities =
      $ExtensionActivitiesTable(this);
  late final $StudySubjectsTable studySubjects = $StudySubjectsTable(this);
  late final $StudyTopicsTable studyTopics = $StudyTopicsTable(this);
  late final $StudyTasksTable studyTasks = $StudyTasksTable(this);
  late final $StudySessionsTable studySessions = $StudySessionsTable(this);
  late final $SyncQueueEntriesTable syncQueueEntries = $SyncQueueEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    academicProfiles,
    courseSubjects,
    courseSubjectLessons,
    attachments,
    complementaryActivities,
    internships,
    extensionActivities,
    studySubjects,
    studyTopics,
    studyTasks,
    studySessions,
    syncQueueEntries,
  ];
}

typedef $$AcademicProfilesTableCreateCompanionBuilder =
    AcademicProfilesCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      Value<String> profileName,
      required String courseName,
      required String institution,
      Value<String?> schoolName,
      Value<String?> campus,
      Value<String?> degreeLabel,
      Value<bool> isActive,
      required int totalCourseHours,
      required int semesterCount,
      required int requiredComplementaryHours,
      required int requiredInternshipHours,
      required int requiredExtensionHours,
      Value<int> rowid,
    });
typedef $$AcademicProfilesTableUpdateCompanionBuilder =
    AcademicProfilesCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String> profileName,
      Value<String> courseName,
      Value<String> institution,
      Value<String?> schoolName,
      Value<String?> campus,
      Value<String?> degreeLabel,
      Value<bool> isActive,
      Value<int> totalCourseHours,
      Value<int> semesterCount,
      Value<int> requiredComplementaryHours,
      Value<int> requiredInternshipHours,
      Value<int> requiredExtensionHours,
      Value<int> rowid,
    });

final class $$AcademicProfilesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AcademicProfilesTable,
          AcademicProfileRow
        > {
  $$AcademicProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$CourseSubjectsTable, List<CourseSubjectRow>>
  _courseSubjectsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.courseSubjects,
    aliasName: $_aliasNameGenerator(
      db.academicProfiles.id,
      db.courseSubjects.academicProfileId,
    ),
  );

  $$CourseSubjectsTableProcessedTableManager get courseSubjectsRefs {
    final manager = $$CourseSubjectsTableTableManager($_db, $_db.courseSubjects)
        .filter(
          (f) => f.academicProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_courseSubjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ComplementaryActivitiesTable,
    List<ComplementaryActivityRow>
  >
  _complementaryActivitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.complementaryActivities,
        aliasName: $_aliasNameGenerator(
          db.academicProfiles.id,
          db.complementaryActivities.academicProfileId,
        ),
      );

  $$ComplementaryActivitiesTableProcessedTableManager
  get complementaryActivitiesRefs {
    final manager =
        $$ComplementaryActivitiesTableTableManager(
          $_db,
          $_db.complementaryActivities,
        ).filter(
          (f) => f.academicProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _complementaryActivitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InternshipsTable, List<InternshipRow>>
  _internshipsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.internships,
    aliasName: $_aliasNameGenerator(
      db.academicProfiles.id,
      db.internships.academicProfileId,
    ),
  );

  $$InternshipsTableProcessedTableManager get internshipsRefs {
    final manager = $$InternshipsTableTableManager($_db, $_db.internships)
        .filter(
          (f) => f.academicProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_internshipsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ExtensionActivitiesTable,
    List<ExtensionActivityRow>
  >
  _extensionActivitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.extensionActivities,
        aliasName: $_aliasNameGenerator(
          db.academicProfiles.id,
          db.extensionActivities.academicProfileId,
        ),
      );

  $$ExtensionActivitiesTableProcessedTableManager get extensionActivitiesRefs {
    final manager =
        $$ExtensionActivitiesTableTableManager(
          $_db,
          $_db.extensionActivities,
        ).filter(
          (f) => f.academicProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _extensionActivitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AcademicProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $AcademicProfilesTable> {
  $$AcademicProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campus => $composableBuilder(
    column: $table.campus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get degreeLabel => $composableBuilder(
    column: $table.degreeLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCourseHours => $composableBuilder(
    column: $table.totalCourseHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semesterCount => $composableBuilder(
    column: $table.semesterCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get requiredComplementaryHours => $composableBuilder(
    column: $table.requiredComplementaryHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get requiredInternshipHours => $composableBuilder(
    column: $table.requiredInternshipHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get requiredExtensionHours => $composableBuilder(
    column: $table.requiredExtensionHours,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> courseSubjectsRefs(
    Expression<bool> Function($$CourseSubjectsTableFilterComposer f) f,
  ) {
    final $$CourseSubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseSubjects,
      getReferencedColumn: (t) => t.academicProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseSubjectsTableFilterComposer(
            $db: $db,
            $table: $db.courseSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> complementaryActivitiesRefs(
    Expression<bool> Function($$ComplementaryActivitiesTableFilterComposer f) f,
  ) {
    final $$ComplementaryActivitiesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.complementaryActivities,
          getReferencedColumn: (t) => t.academicProfileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ComplementaryActivitiesTableFilterComposer(
                $db: $db,
                $table: $db.complementaryActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> internshipsRefs(
    Expression<bool> Function($$InternshipsTableFilterComposer f) f,
  ) {
    final $$InternshipsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.internships,
      getReferencedColumn: (t) => t.academicProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InternshipsTableFilterComposer(
            $db: $db,
            $table: $db.internships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> extensionActivitiesRefs(
    Expression<bool> Function($$ExtensionActivitiesTableFilterComposer f) f,
  ) {
    final $$ExtensionActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.extensionActivities,
      getReferencedColumn: (t) => t.academicProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExtensionActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.extensionActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AcademicProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $AcademicProfilesTable> {
  $$AcademicProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campus => $composableBuilder(
    column: $table.campus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get degreeLabel => $composableBuilder(
    column: $table.degreeLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCourseHours => $composableBuilder(
    column: $table.totalCourseHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semesterCount => $composableBuilder(
    column: $table.semesterCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get requiredComplementaryHours => $composableBuilder(
    column: $table.requiredComplementaryHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get requiredInternshipHours => $composableBuilder(
    column: $table.requiredInternshipHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get requiredExtensionHours => $composableBuilder(
    column: $table.requiredExtensionHours,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AcademicProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AcademicProfilesTable> {
  $$AcademicProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => column,
  );

  GeneratedColumn<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get campus =>
      $composableBuilder(column: $table.campus, builder: (column) => column);

  GeneratedColumn<String> get degreeLabel => $composableBuilder(
    column: $table.degreeLabel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get totalCourseHours => $composableBuilder(
    column: $table.totalCourseHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get semesterCount => $composableBuilder(
    column: $table.semesterCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get requiredComplementaryHours => $composableBuilder(
    column: $table.requiredComplementaryHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get requiredInternshipHours => $composableBuilder(
    column: $table.requiredInternshipHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get requiredExtensionHours => $composableBuilder(
    column: $table.requiredExtensionHours,
    builder: (column) => column,
  );

  Expression<T> courseSubjectsRefs<T extends Object>(
    Expression<T> Function($$CourseSubjectsTableAnnotationComposer a) f,
  ) {
    final $$CourseSubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseSubjects,
      getReferencedColumn: (t) => t.academicProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseSubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.courseSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> complementaryActivitiesRefs<T extends Object>(
    Expression<T> Function($$ComplementaryActivitiesTableAnnotationComposer a)
    f,
  ) {
    final $$ComplementaryActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.complementaryActivities,
          getReferencedColumn: (t) => t.academicProfileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ComplementaryActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.complementaryActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> internshipsRefs<T extends Object>(
    Expression<T> Function($$InternshipsTableAnnotationComposer a) f,
  ) {
    final $$InternshipsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.internships,
      getReferencedColumn: (t) => t.academicProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InternshipsTableAnnotationComposer(
            $db: $db,
            $table: $db.internships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> extensionActivitiesRefs<T extends Object>(
    Expression<T> Function($$ExtensionActivitiesTableAnnotationComposer a) f,
  ) {
    final $$ExtensionActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.extensionActivities,
          getReferencedColumn: (t) => t.academicProfileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExtensionActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.extensionActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AcademicProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AcademicProfilesTable,
          AcademicProfileRow,
          $$AcademicProfilesTableFilterComposer,
          $$AcademicProfilesTableOrderingComposer,
          $$AcademicProfilesTableAnnotationComposer,
          $$AcademicProfilesTableCreateCompanionBuilder,
          $$AcademicProfilesTableUpdateCompanionBuilder,
          (AcademicProfileRow, $$AcademicProfilesTableReferences),
          AcademicProfileRow,
          PrefetchHooks Function({
            bool courseSubjectsRefs,
            bool complementaryActivitiesRefs,
            bool internshipsRefs,
            bool extensionActivitiesRefs,
          })
        > {
  $$AcademicProfilesTableTableManager(
    _$AppDatabase db,
    $AcademicProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AcademicProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AcademicProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AcademicProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> profileName = const Value.absent(),
                Value<String> courseName = const Value.absent(),
                Value<String> institution = const Value.absent(),
                Value<String?> schoolName = const Value.absent(),
                Value<String?> campus = const Value.absent(),
                Value<String?> degreeLabel = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> totalCourseHours = const Value.absent(),
                Value<int> semesterCount = const Value.absent(),
                Value<int> requiredComplementaryHours = const Value.absent(),
                Value<int> requiredInternshipHours = const Value.absent(),
                Value<int> requiredExtensionHours = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AcademicProfilesCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                profileName: profileName,
                courseName: courseName,
                institution: institution,
                schoolName: schoolName,
                campus: campus,
                degreeLabel: degreeLabel,
                isActive: isActive,
                totalCourseHours: totalCourseHours,
                semesterCount: semesterCount,
                requiredComplementaryHours: requiredComplementaryHours,
                requiredInternshipHours: requiredInternshipHours,
                requiredExtensionHours: requiredExtensionHours,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                Value<String> profileName = const Value.absent(),
                required String courseName,
                required String institution,
                Value<String?> schoolName = const Value.absent(),
                Value<String?> campus = const Value.absent(),
                Value<String?> degreeLabel = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required int totalCourseHours,
                required int semesterCount,
                required int requiredComplementaryHours,
                required int requiredInternshipHours,
                required int requiredExtensionHours,
                Value<int> rowid = const Value.absent(),
              }) => AcademicProfilesCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                profileName: profileName,
                courseName: courseName,
                institution: institution,
                schoolName: schoolName,
                campus: campus,
                degreeLabel: degreeLabel,
                isActive: isActive,
                totalCourseHours: totalCourseHours,
                semesterCount: semesterCount,
                requiredComplementaryHours: requiredComplementaryHours,
                requiredInternshipHours: requiredInternshipHours,
                requiredExtensionHours: requiredExtensionHours,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AcademicProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                courseSubjectsRefs = false,
                complementaryActivitiesRefs = false,
                internshipsRefs = false,
                extensionActivitiesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (courseSubjectsRefs) db.courseSubjects,
                    if (complementaryActivitiesRefs) db.complementaryActivities,
                    if (internshipsRefs) db.internships,
                    if (extensionActivitiesRefs) db.extensionActivities,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (courseSubjectsRefs)
                        await $_getPrefetchedData<
                          AcademicProfileRow,
                          $AcademicProfilesTable,
                          CourseSubjectRow
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicProfilesTableReferences
                              ._courseSubjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).courseSubjectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicProfileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (complementaryActivitiesRefs)
                        await $_getPrefetchedData<
                          AcademicProfileRow,
                          $AcademicProfilesTable,
                          ComplementaryActivityRow
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicProfilesTableReferences
                              ._complementaryActivitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).complementaryActivitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicProfileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (internshipsRefs)
                        await $_getPrefetchedData<
                          AcademicProfileRow,
                          $AcademicProfilesTable,
                          InternshipRow
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicProfilesTableReferences
                              ._internshipsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).internshipsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicProfileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (extensionActivitiesRefs)
                        await $_getPrefetchedData<
                          AcademicProfileRow,
                          $AcademicProfilesTable,
                          ExtensionActivityRow
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicProfilesTableReferences
                              ._extensionActivitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).extensionActivitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicProfileId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AcademicProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AcademicProfilesTable,
      AcademicProfileRow,
      $$AcademicProfilesTableFilterComposer,
      $$AcademicProfilesTableOrderingComposer,
      $$AcademicProfilesTableAnnotationComposer,
      $$AcademicProfilesTableCreateCompanionBuilder,
      $$AcademicProfilesTableUpdateCompanionBuilder,
      (AcademicProfileRow, $$AcademicProfilesTableReferences),
      AcademicProfileRow,
      PrefetchHooks Function({
        bool courseSubjectsRefs,
        bool complementaryActivitiesRefs,
        bool internshipsRefs,
        bool extensionActivitiesRefs,
      })
    >;
typedef $$CourseSubjectsTableCreateCompanionBuilder =
    CourseSubjectsCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      Value<String?> academicProfileId,
      required String name,
      Value<String?> code,
      required int workloadHours,
      Value<int?> electiveHours,
      Value<int?> suggestedSemester,
      Value<String> prerequisiteSubjectIdsJson,
      Value<int?> scheduledWeekday,
      Value<double?> defaultLessonHours,
      required String type,
      required String status,
      Value<String?> creditSourceSubjectId,
      Value<String?> creditSourceProfileId,
      Value<String> creditStatus,
      Value<double?> creditMatchScore,
      Value<String?> syllabus,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$CourseSubjectsTableUpdateCompanionBuilder =
    CourseSubjectsCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String?> academicProfileId,
      Value<String> name,
      Value<String?> code,
      Value<int> workloadHours,
      Value<int?> electiveHours,
      Value<int?> suggestedSemester,
      Value<String> prerequisiteSubjectIdsJson,
      Value<int?> scheduledWeekday,
      Value<double?> defaultLessonHours,
      Value<String> type,
      Value<String> status,
      Value<String?> creditSourceSubjectId,
      Value<String?> creditSourceProfileId,
      Value<String> creditStatus,
      Value<double?> creditMatchScore,
      Value<String?> syllabus,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$CourseSubjectsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CourseSubjectsTable, CourseSubjectRow> {
  $$CourseSubjectsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AcademicProfilesTable _academicProfileIdTable(_$AppDatabase db) =>
      db.academicProfiles.createAlias(
        $_aliasNameGenerator(
          db.courseSubjects.academicProfileId,
          db.academicProfiles.id,
        ),
      );

  $$AcademicProfilesTableProcessedTableManager? get academicProfileId {
    final $_column = $_itemColumn<String>('academic_profile_id');
    if ($_column == null) return null;
    final manager = $$AcademicProfilesTableTableManager(
      $_db,
      $_db.academicProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CourseSubjectLessonsTable,
    List<CourseSubjectLessonRow>
  >
  _courseSubjectLessonsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.courseSubjectLessons,
        aliasName: $_aliasNameGenerator(
          db.courseSubjects.id,
          db.courseSubjectLessons.courseSubjectId,
        ),
      );

  $$CourseSubjectLessonsTableProcessedTableManager
  get courseSubjectLessonsRefs {
    final manager =
        $$CourseSubjectLessonsTableTableManager(
          $_db,
          $_db.courseSubjectLessons,
        ).filter(
          (f) => f.courseSubjectId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _courseSubjectLessonsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CourseSubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $CourseSubjectsTable> {
  $$CourseSubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get electiveHours => $composableBuilder(
    column: $table.electiveHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get suggestedSemester => $composableBuilder(
    column: $table.suggestedSemester,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prerequisiteSubjectIdsJson => $composableBuilder(
    column: $table.prerequisiteSubjectIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduledWeekday => $composableBuilder(
    column: $table.scheduledWeekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultLessonHours => $composableBuilder(
    column: $table.defaultLessonHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditSourceSubjectId => $composableBuilder(
    column: $table.creditSourceSubjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditSourceProfileId => $composableBuilder(
    column: $table.creditSourceProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditStatus => $composableBuilder(
    column: $table.creditStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditMatchScore => $composableBuilder(
    column: $table.creditMatchScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syllabus => $composableBuilder(
    column: $table.syllabus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$AcademicProfilesTableFilterComposer get academicProfileId {
    final $$AcademicProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableFilterComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> courseSubjectLessonsRefs(
    Expression<bool> Function($$CourseSubjectLessonsTableFilterComposer f) f,
  ) {
    final $$CourseSubjectLessonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseSubjectLessons,
      getReferencedColumn: (t) => t.courseSubjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseSubjectLessonsTableFilterComposer(
            $db: $db,
            $table: $db.courseSubjectLessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CourseSubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $CourseSubjectsTable> {
  $$CourseSubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get electiveHours => $composableBuilder(
    column: $table.electiveHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get suggestedSemester => $composableBuilder(
    column: $table.suggestedSemester,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prerequisiteSubjectIdsJson => $composableBuilder(
    column: $table.prerequisiteSubjectIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduledWeekday => $composableBuilder(
    column: $table.scheduledWeekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultLessonHours => $composableBuilder(
    column: $table.defaultLessonHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditSourceSubjectId => $composableBuilder(
    column: $table.creditSourceSubjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditSourceProfileId => $composableBuilder(
    column: $table.creditSourceProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditStatus => $composableBuilder(
    column: $table.creditStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditMatchScore => $composableBuilder(
    column: $table.creditMatchScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syllabus => $composableBuilder(
    column: $table.syllabus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$AcademicProfilesTableOrderingComposer get academicProfileId {
    final $$AcademicProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CourseSubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourseSubjectsTable> {
  $$CourseSubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get electiveHours => $composableBuilder(
    column: $table.electiveHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get suggestedSemester => $composableBuilder(
    column: $table.suggestedSemester,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prerequisiteSubjectIdsJson => $composableBuilder(
    column: $table.prerequisiteSubjectIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduledWeekday => $composableBuilder(
    column: $table.scheduledWeekday,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultLessonHours => $composableBuilder(
    column: $table.defaultLessonHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get creditSourceSubjectId => $composableBuilder(
    column: $table.creditSourceSubjectId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creditSourceProfileId => $composableBuilder(
    column: $table.creditSourceProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creditStatus => $composableBuilder(
    column: $table.creditStatus,
    builder: (column) => column,
  );

  GeneratedColumn<double> get creditMatchScore => $composableBuilder(
    column: $table.creditMatchScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syllabus =>
      $composableBuilder(column: $table.syllabus, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$AcademicProfilesTableAnnotationComposer get academicProfileId {
    final $$AcademicProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> courseSubjectLessonsRefs<T extends Object>(
    Expression<T> Function($$CourseSubjectLessonsTableAnnotationComposer a) f,
  ) {
    final $$CourseSubjectLessonsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.courseSubjectLessons,
          getReferencedColumn: (t) => t.courseSubjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CourseSubjectLessonsTableAnnotationComposer(
                $db: $db,
                $table: $db.courseSubjectLessons,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CourseSubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CourseSubjectsTable,
          CourseSubjectRow,
          $$CourseSubjectsTableFilterComposer,
          $$CourseSubjectsTableOrderingComposer,
          $$CourseSubjectsTableAnnotationComposer,
          $$CourseSubjectsTableCreateCompanionBuilder,
          $$CourseSubjectsTableUpdateCompanionBuilder,
          (CourseSubjectRow, $$CourseSubjectsTableReferences),
          CourseSubjectRow,
          PrefetchHooks Function({
            bool academicProfileId,
            bool courseSubjectLessonsRefs,
          })
        > {
  $$CourseSubjectsTableTableManager(
    _$AppDatabase db,
    $CourseSubjectsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CourseSubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CourseSubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CourseSubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> academicProfileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<int> workloadHours = const Value.absent(),
                Value<int?> electiveHours = const Value.absent(),
                Value<int?> suggestedSemester = const Value.absent(),
                Value<String> prerequisiteSubjectIdsJson = const Value.absent(),
                Value<int?> scheduledWeekday = const Value.absent(),
                Value<double?> defaultLessonHours = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> creditSourceSubjectId = const Value.absent(),
                Value<String?> creditSourceProfileId = const Value.absent(),
                Value<String> creditStatus = const Value.absent(),
                Value<double?> creditMatchScore = const Value.absent(),
                Value<String?> syllabus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CourseSubjectsCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                academicProfileId: academicProfileId,
                name: name,
                code: code,
                workloadHours: workloadHours,
                electiveHours: electiveHours,
                suggestedSemester: suggestedSemester,
                prerequisiteSubjectIdsJson: prerequisiteSubjectIdsJson,
                scheduledWeekday: scheduledWeekday,
                defaultLessonHours: defaultLessonHours,
                type: type,
                status: status,
                creditSourceSubjectId: creditSourceSubjectId,
                creditSourceProfileId: creditSourceProfileId,
                creditStatus: creditStatus,
                creditMatchScore: creditMatchScore,
                syllabus: syllabus,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> academicProfileId = const Value.absent(),
                required String name,
                Value<String?> code = const Value.absent(),
                required int workloadHours,
                Value<int?> electiveHours = const Value.absent(),
                Value<int?> suggestedSemester = const Value.absent(),
                Value<String> prerequisiteSubjectIdsJson = const Value.absent(),
                Value<int?> scheduledWeekday = const Value.absent(),
                Value<double?> defaultLessonHours = const Value.absent(),
                required String type,
                required String status,
                Value<String?> creditSourceSubjectId = const Value.absent(),
                Value<String?> creditSourceProfileId = const Value.absent(),
                Value<String> creditStatus = const Value.absent(),
                Value<double?> creditMatchScore = const Value.absent(),
                Value<String?> syllabus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CourseSubjectsCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                academicProfileId: academicProfileId,
                name: name,
                code: code,
                workloadHours: workloadHours,
                electiveHours: electiveHours,
                suggestedSemester: suggestedSemester,
                prerequisiteSubjectIdsJson: prerequisiteSubjectIdsJson,
                scheduledWeekday: scheduledWeekday,
                defaultLessonHours: defaultLessonHours,
                type: type,
                status: status,
                creditSourceSubjectId: creditSourceSubjectId,
                creditSourceProfileId: creditSourceProfileId,
                creditStatus: creditStatus,
                creditMatchScore: creditMatchScore,
                syllabus: syllabus,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CourseSubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({academicProfileId = false, courseSubjectLessonsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (courseSubjectLessonsRefs) db.courseSubjectLessons,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (academicProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.academicProfileId,
                                    referencedTable:
                                        $$CourseSubjectsTableReferences
                                            ._academicProfileIdTable(db),
                                    referencedColumn:
                                        $$CourseSubjectsTableReferences
                                            ._academicProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (courseSubjectLessonsRefs)
                        await $_getPrefetchedData<
                          CourseSubjectRow,
                          $CourseSubjectsTable,
                          CourseSubjectLessonRow
                        >(
                          currentTable: table,
                          referencedTable: $$CourseSubjectsTableReferences
                              ._courseSubjectLessonsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CourseSubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).courseSubjectLessonsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.courseSubjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CourseSubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CourseSubjectsTable,
      CourseSubjectRow,
      $$CourseSubjectsTableFilterComposer,
      $$CourseSubjectsTableOrderingComposer,
      $$CourseSubjectsTableAnnotationComposer,
      $$CourseSubjectsTableCreateCompanionBuilder,
      $$CourseSubjectsTableUpdateCompanionBuilder,
      (CourseSubjectRow, $$CourseSubjectsTableReferences),
      CourseSubjectRow,
      PrefetchHooks Function({
        bool academicProfileId,
        bool courseSubjectLessonsRefs,
      })
    >;
typedef $$CourseSubjectLessonsTableCreateCompanionBuilder =
    CourseSubjectLessonsCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      required String courseSubjectId,
      required DateTime lessonDate,
      required double lessonHours,
      required String coveredContent,
      Value<String?> description,
      Value<String?> activityDescription,
      Value<String?> assessmentDescription,
      Value<DateTime?> assessmentDate,
      Value<String?> pdfName,
      Value<Uint8List?> pdfBytes,
      Value<bool> wasAbsent,
      Value<int> rowid,
    });
typedef $$CourseSubjectLessonsTableUpdateCompanionBuilder =
    CourseSubjectLessonsCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String> courseSubjectId,
      Value<DateTime> lessonDate,
      Value<double> lessonHours,
      Value<String> coveredContent,
      Value<String?> description,
      Value<String?> activityDescription,
      Value<String?> assessmentDescription,
      Value<DateTime?> assessmentDate,
      Value<String?> pdfName,
      Value<Uint8List?> pdfBytes,
      Value<bool> wasAbsent,
      Value<int> rowid,
    });

final class $$CourseSubjectLessonsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CourseSubjectLessonsTable,
          CourseSubjectLessonRow
        > {
  $$CourseSubjectLessonsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CourseSubjectsTable _courseSubjectIdTable(_$AppDatabase db) =>
      db.courseSubjects.createAlias(
        $_aliasNameGenerator(
          db.courseSubjectLessons.courseSubjectId,
          db.courseSubjects.id,
        ),
      );

  $$CourseSubjectsTableProcessedTableManager get courseSubjectId {
    final $_column = $_itemColumn<String>('course_subject_id')!;

    final manager = $$CourseSubjectsTableTableManager(
      $_db,
      $_db.courseSubjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseSubjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CourseSubjectLessonsTableFilterComposer
    extends Composer<_$AppDatabase, $CourseSubjectLessonsTable> {
  $$CourseSubjectLessonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lessonDate => $composableBuilder(
    column: $table.lessonDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lessonHours => $composableBuilder(
    column: $table.lessonHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coveredContent => $composableBuilder(
    column: $table.coveredContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityDescription => $composableBuilder(
    column: $table.activityDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assessmentDescription => $composableBuilder(
    column: $table.assessmentDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get assessmentDate => $composableBuilder(
    column: $table.assessmentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfName => $composableBuilder(
    column: $table.pdfName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get pdfBytes => $composableBuilder(
    column: $table.pdfBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasAbsent => $composableBuilder(
    column: $table.wasAbsent,
    builder: (column) => ColumnFilters(column),
  );

  $$CourseSubjectsTableFilterComposer get courseSubjectId {
    final $$CourseSubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseSubjectId,
      referencedTable: $db.courseSubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseSubjectsTableFilterComposer(
            $db: $db,
            $table: $db.courseSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CourseSubjectLessonsTableOrderingComposer
    extends Composer<_$AppDatabase, $CourseSubjectLessonsTable> {
  $$CourseSubjectLessonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lessonDate => $composableBuilder(
    column: $table.lessonDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lessonHours => $composableBuilder(
    column: $table.lessonHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coveredContent => $composableBuilder(
    column: $table.coveredContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityDescription => $composableBuilder(
    column: $table.activityDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assessmentDescription => $composableBuilder(
    column: $table.assessmentDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get assessmentDate => $composableBuilder(
    column: $table.assessmentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfName => $composableBuilder(
    column: $table.pdfName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get pdfBytes => $composableBuilder(
    column: $table.pdfBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasAbsent => $composableBuilder(
    column: $table.wasAbsent,
    builder: (column) => ColumnOrderings(column),
  );

  $$CourseSubjectsTableOrderingComposer get courseSubjectId {
    final $$CourseSubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseSubjectId,
      referencedTable: $db.courseSubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseSubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.courseSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CourseSubjectLessonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourseSubjectLessonsTable> {
  $$CourseSubjectLessonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get lessonDate => $composableBuilder(
    column: $table.lessonDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lessonHours => $composableBuilder(
    column: $table.lessonHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coveredContent => $composableBuilder(
    column: $table.coveredContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityDescription => $composableBuilder(
    column: $table.activityDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assessmentDescription => $composableBuilder(
    column: $table.assessmentDescription,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get assessmentDate => $composableBuilder(
    column: $table.assessmentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pdfName =>
      $composableBuilder(column: $table.pdfName, builder: (column) => column);

  GeneratedColumn<Uint8List> get pdfBytes =>
      $composableBuilder(column: $table.pdfBytes, builder: (column) => column);

  GeneratedColumn<bool> get wasAbsent =>
      $composableBuilder(column: $table.wasAbsent, builder: (column) => column);

  $$CourseSubjectsTableAnnotationComposer get courseSubjectId {
    final $$CourseSubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseSubjectId,
      referencedTable: $db.courseSubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseSubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.courseSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CourseSubjectLessonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CourseSubjectLessonsTable,
          CourseSubjectLessonRow,
          $$CourseSubjectLessonsTableFilterComposer,
          $$CourseSubjectLessonsTableOrderingComposer,
          $$CourseSubjectLessonsTableAnnotationComposer,
          $$CourseSubjectLessonsTableCreateCompanionBuilder,
          $$CourseSubjectLessonsTableUpdateCompanionBuilder,
          (CourseSubjectLessonRow, $$CourseSubjectLessonsTableReferences),
          CourseSubjectLessonRow,
          PrefetchHooks Function({bool courseSubjectId})
        > {
  $$CourseSubjectLessonsTableTableManager(
    _$AppDatabase db,
    $CourseSubjectLessonsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CourseSubjectLessonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CourseSubjectLessonsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CourseSubjectLessonsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> courseSubjectId = const Value.absent(),
                Value<DateTime> lessonDate = const Value.absent(),
                Value<double> lessonHours = const Value.absent(),
                Value<String> coveredContent = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> activityDescription = const Value.absent(),
                Value<String?> assessmentDescription = const Value.absent(),
                Value<DateTime?> assessmentDate = const Value.absent(),
                Value<String?> pdfName = const Value.absent(),
                Value<Uint8List?> pdfBytes = const Value.absent(),
                Value<bool> wasAbsent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CourseSubjectLessonsCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                courseSubjectId: courseSubjectId,
                lessonDate: lessonDate,
                lessonHours: lessonHours,
                coveredContent: coveredContent,
                description: description,
                activityDescription: activityDescription,
                assessmentDescription: assessmentDescription,
                assessmentDate: assessmentDate,
                pdfName: pdfName,
                pdfBytes: pdfBytes,
                wasAbsent: wasAbsent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                required String courseSubjectId,
                required DateTime lessonDate,
                required double lessonHours,
                required String coveredContent,
                Value<String?> description = const Value.absent(),
                Value<String?> activityDescription = const Value.absent(),
                Value<String?> assessmentDescription = const Value.absent(),
                Value<DateTime?> assessmentDate = const Value.absent(),
                Value<String?> pdfName = const Value.absent(),
                Value<Uint8List?> pdfBytes = const Value.absent(),
                Value<bool> wasAbsent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CourseSubjectLessonsCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                courseSubjectId: courseSubjectId,
                lessonDate: lessonDate,
                lessonHours: lessonHours,
                coveredContent: coveredContent,
                description: description,
                activityDescription: activityDescription,
                assessmentDescription: assessmentDescription,
                assessmentDate: assessmentDate,
                pdfName: pdfName,
                pdfBytes: pdfBytes,
                wasAbsent: wasAbsent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CourseSubjectLessonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({courseSubjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (courseSubjectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.courseSubjectId,
                                referencedTable:
                                    $$CourseSubjectLessonsTableReferences
                                        ._courseSubjectIdTable(db),
                                referencedColumn:
                                    $$CourseSubjectLessonsTableReferences
                                        ._courseSubjectIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CourseSubjectLessonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CourseSubjectLessonsTable,
      CourseSubjectLessonRow,
      $$CourseSubjectLessonsTableFilterComposer,
      $$CourseSubjectLessonsTableOrderingComposer,
      $$CourseSubjectLessonsTableAnnotationComposer,
      $$CourseSubjectLessonsTableCreateCompanionBuilder,
      $$CourseSubjectLessonsTableUpdateCompanionBuilder,
      (CourseSubjectLessonRow, $$CourseSubjectLessonsTableReferences),
      CourseSubjectLessonRow,
      PrefetchHooks Function({bool courseSubjectId})
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      required String ownerType,
      required String ownerId,
      required String fileName,
      required Uint8List fileBytes,
      Value<String?> mimeType,
      required String category,
      Value<DateTime?> dueDate,
      Value<bool> isCompleted,
      Value<int> rowid,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String> ownerType,
      Value<String> ownerId,
      Value<String> fileName,
      Value<Uint8List> fileBytes,
      Value<String?> mimeType,
      Value<String> category,
      Value<DateTime?> dueDate,
      Value<bool> isCompleted,
      Value<int> rowid,
    });

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get fileBytes => $composableBuilder(
    column: $table.fileBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get fileBytes => $composableBuilder(
    column: $table.fileBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get ownerType =>
      $composableBuilder(column: $table.ownerType, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<Uint8List> get fileBytes =>
      $composableBuilder(column: $table.fileBytes, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          AttachmentRow,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (
            AttachmentRow,
            BaseReferences<_$AppDatabase, $AttachmentsTable, AttachmentRow>,
          ),
          AttachmentRow,
          PrefetchHooks Function()
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> ownerType = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<Uint8List> fileBytes = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                ownerType: ownerType,
                ownerId: ownerId,
                fileName: fileName,
                fileBytes: fileBytes,
                mimeType: mimeType,
                category: category,
                dueDate: dueDate,
                isCompleted: isCompleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                required String ownerType,
                required String ownerId,
                required String fileName,
                required Uint8List fileBytes,
                Value<String?> mimeType = const Value.absent(),
                required String category,
                Value<DateTime?> dueDate = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                ownerType: ownerType,
                ownerId: ownerId,
                fileName: fileName,
                fileBytes: fileBytes,
                mimeType: mimeType,
                category: category,
                dueDate: dueDate,
                isCompleted: isCompleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      AttachmentRow,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (
        AttachmentRow,
        BaseReferences<_$AppDatabase, $AttachmentsTable, AttachmentRow>,
      ),
      AttachmentRow,
      PrefetchHooks Function()
    >;
typedef $$ComplementaryActivitiesTableCreateCompanionBuilder =
    ComplementaryActivitiesCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      Value<String?> academicProfileId,
      required String title,
      required String category,
      required DateTime date,
      Value<DateTime?> endDate,
      required int workloadHours,
      Value<String?> notes,
      required String status,
      Value<int> rowid,
    });
typedef $$ComplementaryActivitiesTableUpdateCompanionBuilder =
    ComplementaryActivitiesCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String?> academicProfileId,
      Value<String> title,
      Value<String> category,
      Value<DateTime> date,
      Value<DateTime?> endDate,
      Value<int> workloadHours,
      Value<String?> notes,
      Value<String> status,
      Value<int> rowid,
    });

final class $$ComplementaryActivitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ComplementaryActivitiesTable,
          ComplementaryActivityRow
        > {
  $$ComplementaryActivitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AcademicProfilesTable _academicProfileIdTable(_$AppDatabase db) =>
      db.academicProfiles.createAlias(
        $_aliasNameGenerator(
          db.complementaryActivities.academicProfileId,
          db.academicProfiles.id,
        ),
      );

  $$AcademicProfilesTableProcessedTableManager? get academicProfileId {
    final $_column = $_itemColumn<String>('academic_profile_id');
    if ($_column == null) return null;
    final manager = $$AcademicProfilesTableTableManager(
      $_db,
      $_db.academicProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ComplementaryActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ComplementaryActivitiesTable> {
  $$ComplementaryActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$AcademicProfilesTableFilterComposer get academicProfileId {
    final $$AcademicProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableFilterComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplementaryActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ComplementaryActivitiesTable> {
  $$ComplementaryActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$AcademicProfilesTableOrderingComposer get academicProfileId {
    final $$AcademicProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplementaryActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComplementaryActivitiesTable> {
  $$ComplementaryActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$AcademicProfilesTableAnnotationComposer get academicProfileId {
    final $$AcademicProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplementaryActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ComplementaryActivitiesTable,
          ComplementaryActivityRow,
          $$ComplementaryActivitiesTableFilterComposer,
          $$ComplementaryActivitiesTableOrderingComposer,
          $$ComplementaryActivitiesTableAnnotationComposer,
          $$ComplementaryActivitiesTableCreateCompanionBuilder,
          $$ComplementaryActivitiesTableUpdateCompanionBuilder,
          (ComplementaryActivityRow, $$ComplementaryActivitiesTableReferences),
          ComplementaryActivityRow,
          PrefetchHooks Function({bool academicProfileId})
        > {
  $$ComplementaryActivitiesTableTableManager(
    _$AppDatabase db,
    $ComplementaryActivitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComplementaryActivitiesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ComplementaryActivitiesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ComplementaryActivitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> academicProfileId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int> workloadHours = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ComplementaryActivitiesCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                academicProfileId: academicProfileId,
                title: title,
                category: category,
                date: date,
                endDate: endDate,
                workloadHours: workloadHours,
                notes: notes,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> academicProfileId = const Value.absent(),
                required String title,
                required String category,
                required DateTime date,
                Value<DateTime?> endDate = const Value.absent(),
                required int workloadHours,
                Value<String?> notes = const Value.absent(),
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => ComplementaryActivitiesCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                academicProfileId: academicProfileId,
                title: title,
                category: category,
                date: date,
                endDate: endDate,
                workloadHours: workloadHours,
                notes: notes,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ComplementaryActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({academicProfileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (academicProfileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.academicProfileId,
                                referencedTable:
                                    $$ComplementaryActivitiesTableReferences
                                        ._academicProfileIdTable(db),
                                referencedColumn:
                                    $$ComplementaryActivitiesTableReferences
                                        ._academicProfileIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ComplementaryActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ComplementaryActivitiesTable,
      ComplementaryActivityRow,
      $$ComplementaryActivitiesTableFilterComposer,
      $$ComplementaryActivitiesTableOrderingComposer,
      $$ComplementaryActivitiesTableAnnotationComposer,
      $$ComplementaryActivitiesTableCreateCompanionBuilder,
      $$ComplementaryActivitiesTableUpdateCompanionBuilder,
      (ComplementaryActivityRow, $$ComplementaryActivitiesTableReferences),
      ComplementaryActivityRow,
      PrefetchHooks Function({bool academicProfileId})
    >;
typedef $$InternshipsTableCreateCompanionBuilder =
    InternshipsCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      Value<String?> academicProfileId,
      required String location,
      Value<String?> supervisor,
      required DateTime startDate,
      Value<DateTime?> endDate,
      required int totalHours,
      required int completedHours,
      required String status,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$InternshipsTableUpdateCompanionBuilder =
    InternshipsCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String?> academicProfileId,
      Value<String> location,
      Value<String?> supervisor,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<int> totalHours,
      Value<int> completedHours,
      Value<String> status,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$InternshipsTableReferences
    extends BaseReferences<_$AppDatabase, $InternshipsTable, InternshipRow> {
  $$InternshipsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AcademicProfilesTable _academicProfileIdTable(_$AppDatabase db) =>
      db.academicProfiles.createAlias(
        $_aliasNameGenerator(
          db.internships.academicProfileId,
          db.academicProfiles.id,
        ),
      );

  $$AcademicProfilesTableProcessedTableManager? get academicProfileId {
    final $_column = $_itemColumn<String>('academic_profile_id');
    if ($_column == null) return null;
    final manager = $$AcademicProfilesTableTableManager(
      $_db,
      $_db.academicProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InternshipsTableFilterComposer
    extends Composer<_$AppDatabase, $InternshipsTable> {
  $$InternshipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supervisor => $composableBuilder(
    column: $table.supervisor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalHours => $composableBuilder(
    column: $table.totalHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedHours => $composableBuilder(
    column: $table.completedHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$AcademicProfilesTableFilterComposer get academicProfileId {
    final $$AcademicProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableFilterComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InternshipsTableOrderingComposer
    extends Composer<_$AppDatabase, $InternshipsTable> {
  $$InternshipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supervisor => $composableBuilder(
    column: $table.supervisor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalHours => $composableBuilder(
    column: $table.totalHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedHours => $composableBuilder(
    column: $table.completedHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$AcademicProfilesTableOrderingComposer get academicProfileId {
    final $$AcademicProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InternshipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InternshipsTable> {
  $$InternshipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get supervisor => $composableBuilder(
    column: $table.supervisor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get totalHours => $composableBuilder(
    column: $table.totalHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedHours => $composableBuilder(
    column: $table.completedHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$AcademicProfilesTableAnnotationComposer get academicProfileId {
    final $$AcademicProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InternshipsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InternshipsTable,
          InternshipRow,
          $$InternshipsTableFilterComposer,
          $$InternshipsTableOrderingComposer,
          $$InternshipsTableAnnotationComposer,
          $$InternshipsTableCreateCompanionBuilder,
          $$InternshipsTableUpdateCompanionBuilder,
          (InternshipRow, $$InternshipsTableReferences),
          InternshipRow,
          PrefetchHooks Function({bool academicProfileId})
        > {
  $$InternshipsTableTableManager(_$AppDatabase db, $InternshipsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InternshipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InternshipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InternshipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> academicProfileId = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String?> supervisor = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int> totalHours = const Value.absent(),
                Value<int> completedHours = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InternshipsCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                academicProfileId: academicProfileId,
                location: location,
                supervisor: supervisor,
                startDate: startDate,
                endDate: endDate,
                totalHours: totalHours,
                completedHours: completedHours,
                status: status,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> academicProfileId = const Value.absent(),
                required String location,
                Value<String?> supervisor = const Value.absent(),
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                required int totalHours,
                required int completedHours,
                required String status,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InternshipsCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                academicProfileId: academicProfileId,
                location: location,
                supervisor: supervisor,
                startDate: startDate,
                endDate: endDate,
                totalHours: totalHours,
                completedHours: completedHours,
                status: status,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InternshipsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({academicProfileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (academicProfileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.academicProfileId,
                                referencedTable: $$InternshipsTableReferences
                                    ._academicProfileIdTable(db),
                                referencedColumn: $$InternshipsTableReferences
                                    ._academicProfileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InternshipsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InternshipsTable,
      InternshipRow,
      $$InternshipsTableFilterComposer,
      $$InternshipsTableOrderingComposer,
      $$InternshipsTableAnnotationComposer,
      $$InternshipsTableCreateCompanionBuilder,
      $$InternshipsTableUpdateCompanionBuilder,
      (InternshipRow, $$InternshipsTableReferences),
      InternshipRow,
      PrefetchHooks Function({bool academicProfileId})
    >;
typedef $$ExtensionActivitiesTableCreateCompanionBuilder =
    ExtensionActivitiesCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      Value<String?> academicProfileId,
      required String title,
      required String type,
      required DateTime date,
      required int workloadHours,
      Value<String?> notes,
      required String status,
      Value<int> rowid,
    });
typedef $$ExtensionActivitiesTableUpdateCompanionBuilder =
    ExtensionActivitiesCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String?> academicProfileId,
      Value<String> title,
      Value<String> type,
      Value<DateTime> date,
      Value<int> workloadHours,
      Value<String?> notes,
      Value<String> status,
      Value<int> rowid,
    });

final class $$ExtensionActivitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExtensionActivitiesTable,
          ExtensionActivityRow
        > {
  $$ExtensionActivitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AcademicProfilesTable _academicProfileIdTable(_$AppDatabase db) =>
      db.academicProfiles.createAlias(
        $_aliasNameGenerator(
          db.extensionActivities.academicProfileId,
          db.academicProfiles.id,
        ),
      );

  $$AcademicProfilesTableProcessedTableManager? get academicProfileId {
    final $_column = $_itemColumn<String>('academic_profile_id');
    if ($_column == null) return null;
    final manager = $$AcademicProfilesTableTableManager(
      $_db,
      $_db.academicProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExtensionActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ExtensionActivitiesTable> {
  $$ExtensionActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$AcademicProfilesTableFilterComposer get academicProfileId {
    final $$AcademicProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableFilterComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExtensionActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExtensionActivitiesTable> {
  $$ExtensionActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$AcademicProfilesTableOrderingComposer get academicProfileId {
    final $$AcademicProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExtensionActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExtensionActivitiesTable> {
  $$ExtensionActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get workloadHours => $composableBuilder(
    column: $table.workloadHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$AcademicProfilesTableAnnotationComposer get academicProfileId {
    final $$AcademicProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicProfileId,
      referencedTable: $db.academicProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.academicProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExtensionActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExtensionActivitiesTable,
          ExtensionActivityRow,
          $$ExtensionActivitiesTableFilterComposer,
          $$ExtensionActivitiesTableOrderingComposer,
          $$ExtensionActivitiesTableAnnotationComposer,
          $$ExtensionActivitiesTableCreateCompanionBuilder,
          $$ExtensionActivitiesTableUpdateCompanionBuilder,
          (ExtensionActivityRow, $$ExtensionActivitiesTableReferences),
          ExtensionActivityRow,
          PrefetchHooks Function({bool academicProfileId})
        > {
  $$ExtensionActivitiesTableTableManager(
    _$AppDatabase db,
    $ExtensionActivitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExtensionActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExtensionActivitiesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExtensionActivitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> academicProfileId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> workloadHours = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExtensionActivitiesCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                academicProfileId: academicProfileId,
                title: title,
                type: type,
                date: date,
                workloadHours: workloadHours,
                notes: notes,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> academicProfileId = const Value.absent(),
                required String title,
                required String type,
                required DateTime date,
                required int workloadHours,
                Value<String?> notes = const Value.absent(),
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => ExtensionActivitiesCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                academicProfileId: academicProfileId,
                title: title,
                type: type,
                date: date,
                workloadHours: workloadHours,
                notes: notes,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExtensionActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({academicProfileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (academicProfileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.academicProfileId,
                                referencedTable:
                                    $$ExtensionActivitiesTableReferences
                                        ._academicProfileIdTable(db),
                                referencedColumn:
                                    $$ExtensionActivitiesTableReferences
                                        ._academicProfileIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExtensionActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExtensionActivitiesTable,
      ExtensionActivityRow,
      $$ExtensionActivitiesTableFilterComposer,
      $$ExtensionActivitiesTableOrderingComposer,
      $$ExtensionActivitiesTableAnnotationComposer,
      $$ExtensionActivitiesTableCreateCompanionBuilder,
      $$ExtensionActivitiesTableUpdateCompanionBuilder,
      (ExtensionActivityRow, $$ExtensionActivitiesTableReferences),
      ExtensionActivityRow,
      PrefetchHooks Function({bool academicProfileId})
    >;
typedef $$StudySubjectsTableCreateCompanionBuilder =
    StudySubjectsCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      required String name,
      Value<int?> colorValue,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$StudySubjectsTableUpdateCompanionBuilder =
    StudySubjectsCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String> name,
      Value<int?> colorValue,
      Value<String?> description,
      Value<int> rowid,
    });

final class $$StudySubjectsTableReferences
    extends
        BaseReferences<_$AppDatabase, $StudySubjectsTable, StudySubjectRow> {
  $$StudySubjectsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$StudyTopicsTable, List<StudyTopicRow>>
  _studyTopicsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyTopics,
    aliasName: $_aliasNameGenerator(
      db.studySubjects.id,
      db.studyTopics.studySubjectId,
    ),
  );

  $$StudyTopicsTableProcessedTableManager get studyTopicsRefs {
    final manager = $$StudyTopicsTableTableManager(
      $_db,
      $_db.studyTopics,
    ).filter((f) => f.studySubjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyTopicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudyTasksTable, List<StudyTaskRow>>
  _studyTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyTasks,
    aliasName: $_aliasNameGenerator(
      db.studySubjects.id,
      db.studyTasks.studySubjectId,
    ),
  );

  $$StudyTasksTableProcessedTableManager get studyTasksRefs {
    final manager = $$StudyTasksTableTableManager(
      $_db,
      $_db.studyTasks,
    ).filter((f) => f.studySubjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySessionRow>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: $_aliasNameGenerator(
      db.studySubjects.id,
      db.studySessions.studySubjectId,
    ),
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.studySubjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudySubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySubjectsTable> {
  $$StudySubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> studyTopicsRefs(
    Expression<bool> Function($$StudyTopicsTableFilterComposer f) f,
  ) {
    final $$StudyTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTopics,
      getReferencedColumn: (t) => t.studySubjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTopicsTableFilterComposer(
            $db: $db,
            $table: $db.studyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studyTasksRefs(
    Expression<bool> Function($$StudyTasksTableFilterComposer f) f,
  ) {
    final $$StudyTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.studySubjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableFilterComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.studySubjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudySubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySubjectsTable> {
  $$StudySubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudySubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySubjectsTable> {
  $$StudySubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> studyTopicsRefs<T extends Object>(
    Expression<T> Function($$StudyTopicsTableAnnotationComposer a) f,
  ) {
    final $$StudyTopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTopics,
      getReferencedColumn: (t) => t.studySubjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studyTasksRefs<T extends Object>(
    Expression<T> Function($$StudyTasksTableAnnotationComposer a) f,
  ) {
    final $$StudyTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.studySubjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.studySubjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudySubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySubjectsTable,
          StudySubjectRow,
          $$StudySubjectsTableFilterComposer,
          $$StudySubjectsTableOrderingComposer,
          $$StudySubjectsTableAnnotationComposer,
          $$StudySubjectsTableCreateCompanionBuilder,
          $$StudySubjectsTableUpdateCompanionBuilder,
          (StudySubjectRow, $$StudySubjectsTableReferences),
          StudySubjectRow,
          PrefetchHooks Function({
            bool studyTopicsRefs,
            bool studyTasksRefs,
            bool studySessionsRefs,
          })
        > {
  $$StudySubjectsTableTableManager(_$AppDatabase db, $StudySubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySubjectsCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                name: name,
                colorValue: colorValue,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                required String name,
                Value<int?> colorValue = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySubjectsCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                name: name,
                colorValue: colorValue,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudySubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studyTopicsRefs = false,
                studyTasksRefs = false,
                studySessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studyTopicsRefs) db.studyTopics,
                    if (studyTasksRefs) db.studyTasks,
                    if (studySessionsRefs) db.studySessions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studyTopicsRefs)
                        await $_getPrefetchedData<
                          StudySubjectRow,
                          $StudySubjectsTable,
                          StudyTopicRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudySubjectsTableReferences
                              ._studyTopicsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudySubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).studyTopicsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studySubjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studyTasksRefs)
                        await $_getPrefetchedData<
                          StudySubjectRow,
                          $StudySubjectsTable,
                          StudyTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudySubjectsTableReferences
                              ._studyTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudySubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).studyTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studySubjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studySessionsRefs)
                        await $_getPrefetchedData<
                          StudySubjectRow,
                          $StudySubjectsTable,
                          StudySessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudySubjectsTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudySubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studySubjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudySubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySubjectsTable,
      StudySubjectRow,
      $$StudySubjectsTableFilterComposer,
      $$StudySubjectsTableOrderingComposer,
      $$StudySubjectsTableAnnotationComposer,
      $$StudySubjectsTableCreateCompanionBuilder,
      $$StudySubjectsTableUpdateCompanionBuilder,
      (StudySubjectRow, $$StudySubjectsTableReferences),
      StudySubjectRow,
      PrefetchHooks Function({
        bool studyTopicsRefs,
        bool studyTasksRefs,
        bool studySessionsRefs,
      })
    >;
typedef $$StudyTopicsTableCreateCompanionBuilder =
    StudyTopicsCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      required String studySubjectId,
      required String name,
      Value<String?> description,
      required String status,
      Value<int> rowid,
    });
typedef $$StudyTopicsTableUpdateCompanionBuilder =
    StudyTopicsCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String> studySubjectId,
      Value<String> name,
      Value<String?> description,
      Value<String> status,
      Value<int> rowid,
    });

final class $$StudyTopicsTableReferences
    extends BaseReferences<_$AppDatabase, $StudyTopicsTable, StudyTopicRow> {
  $$StudyTopicsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudySubjectsTable _studySubjectIdTable(_$AppDatabase db) =>
      db.studySubjects.createAlias(
        $_aliasNameGenerator(
          db.studyTopics.studySubjectId,
          db.studySubjects.id,
        ),
      );

  $$StudySubjectsTableProcessedTableManager get studySubjectId {
    final $_column = $_itemColumn<String>('study_subject_id')!;

    final manager = $$StudySubjectsTableTableManager(
      $_db,
      $_db.studySubjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studySubjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySessionRow>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: $_aliasNameGenerator(
      db.studyTopics.id,
      db.studySessions.studyTopicId,
    ),
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.studyTopicId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudyTopicsTableFilterComposer
    extends Composer<_$AppDatabase, $StudyTopicsTable> {
  $$StudyTopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$StudySubjectsTableFilterComposer get studySubjectId {
    final $$StudySubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableFilterComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.studyTopicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyTopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyTopicsTable> {
  $$StudyTopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudySubjectsTableOrderingComposer get studySubjectId {
    final $$StudySubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyTopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyTopicsTable> {
  $$StudyTopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$StudySubjectsTableAnnotationComposer get studySubjectId {
    final $$StudySubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.studyTopicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyTopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyTopicsTable,
          StudyTopicRow,
          $$StudyTopicsTableFilterComposer,
          $$StudyTopicsTableOrderingComposer,
          $$StudyTopicsTableAnnotationComposer,
          $$StudyTopicsTableCreateCompanionBuilder,
          $$StudyTopicsTableUpdateCompanionBuilder,
          (StudyTopicRow, $$StudyTopicsTableReferences),
          StudyTopicRow,
          PrefetchHooks Function({bool studySubjectId, bool studySessionsRefs})
        > {
  $$StudyTopicsTableTableManager(_$AppDatabase db, $StudyTopicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyTopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyTopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyTopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> studySubjectId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyTopicsCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                studySubjectId: studySubjectId,
                name: name,
                description: description,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                required String studySubjectId,
                required String name,
                Value<String?> description = const Value.absent(),
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => StudyTopicsCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                studySubjectId: studySubjectId,
                name: name,
                description: description,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudyTopicsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({studySubjectId = false, studySessionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studySessionsRefs) db.studySessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studySubjectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studySubjectId,
                                    referencedTable:
                                        $$StudyTopicsTableReferences
                                            ._studySubjectIdTable(db),
                                    referencedColumn:
                                        $$StudyTopicsTableReferences
                                            ._studySubjectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studySessionsRefs)
                        await $_getPrefetchedData<
                          StudyTopicRow,
                          $StudyTopicsTable,
                          StudySessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyTopicsTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyTopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyTopicId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudyTopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyTopicsTable,
      StudyTopicRow,
      $$StudyTopicsTableFilterComposer,
      $$StudyTopicsTableOrderingComposer,
      $$StudyTopicsTableAnnotationComposer,
      $$StudyTopicsTableCreateCompanionBuilder,
      $$StudyTopicsTableUpdateCompanionBuilder,
      (StudyTopicRow, $$StudyTopicsTableReferences),
      StudyTopicRow,
      PrefetchHooks Function({bool studySubjectId, bool studySessionsRefs})
    >;
typedef $$StudyTasksTableCreateCompanionBuilder =
    StudyTasksCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      required String title,
      Value<String?> description,
      Value<String?> studySubjectId,
      Value<DateTime?> dueDate,
      required String priority,
      required String status,
      Value<int> rowid,
    });
typedef $$StudyTasksTableUpdateCompanionBuilder =
    StudyTasksCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String> title,
      Value<String?> description,
      Value<String?> studySubjectId,
      Value<DateTime?> dueDate,
      Value<String> priority,
      Value<String> status,
      Value<int> rowid,
    });

final class $$StudyTasksTableReferences
    extends BaseReferences<_$AppDatabase, $StudyTasksTable, StudyTaskRow> {
  $$StudyTasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudySubjectsTable _studySubjectIdTable(_$AppDatabase db) =>
      db.studySubjects.createAlias(
        $_aliasNameGenerator(db.studyTasks.studySubjectId, db.studySubjects.id),
      );

  $$StudySubjectsTableProcessedTableManager? get studySubjectId {
    final $_column = $_itemColumn<String>('study_subject_id');
    if ($_column == null) return null;
    final manager = $$StudySubjectsTableTableManager(
      $_db,
      $_db.studySubjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studySubjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudyTasksTableFilterComposer
    extends Composer<_$AppDatabase, $StudyTasksTable> {
  $$StudyTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$StudySubjectsTableFilterComposer get studySubjectId {
    final $$StudySubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableFilterComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyTasksTable> {
  $$StudyTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudySubjectsTableOrderingComposer get studySubjectId {
    final $$StudySubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyTasksTable> {
  $$StudyTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$StudySubjectsTableAnnotationComposer get studySubjectId {
    final $$StudySubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyTasksTable,
          StudyTaskRow,
          $$StudyTasksTableFilterComposer,
          $$StudyTasksTableOrderingComposer,
          $$StudyTasksTableAnnotationComposer,
          $$StudyTasksTableCreateCompanionBuilder,
          $$StudyTasksTableUpdateCompanionBuilder,
          (StudyTaskRow, $$StudyTasksTableReferences),
          StudyTaskRow,
          PrefetchHooks Function({bool studySubjectId})
        > {
  $$StudyTasksTableTableManager(_$AppDatabase db, $StudyTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> studySubjectId = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyTasksCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                title: title,
                description: description,
                studySubjectId: studySubjectId,
                dueDate: dueDate,
                priority: priority,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> studySubjectId = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                required String priority,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => StudyTasksCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                title: title,
                description: description,
                studySubjectId: studySubjectId,
                dueDate: dueDate,
                priority: priority,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudyTasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studySubjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (studySubjectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.studySubjectId,
                                referencedTable: $$StudyTasksTableReferences
                                    ._studySubjectIdTable(db),
                                referencedColumn: $$StudyTasksTableReferences
                                    ._studySubjectIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StudyTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyTasksTable,
      StudyTaskRow,
      $$StudyTasksTableFilterComposer,
      $$StudyTasksTableOrderingComposer,
      $$StudyTasksTableAnnotationComposer,
      $$StudyTasksTableCreateCompanionBuilder,
      $$StudyTasksTableUpdateCompanionBuilder,
      (StudyTaskRow, $$StudyTasksTableReferences),
      StudyTaskRow,
      PrefetchHooks Function({bool studySubjectId})
    >;
typedef $$StudySessionsTableCreateCompanionBuilder =
    StudySessionsCompanion Function({
      required String id,
      Value<String?> remoteId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String syncStatus,
      Value<bool> isDeleted,
      Value<String?> studySubjectId,
      Value<String?> studyTopicId,
      required DateTime startedAt,
      required DateTime endedAt,
      required int durationMinutes,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$StudySessionsTableUpdateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<bool> isDeleted,
      Value<String?> studySubjectId,
      Value<String?> studyTopicId,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
      Value<int> durationMinutes,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$StudySessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $StudySessionsTable, StudySessionRow> {
  $$StudySessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudySubjectsTable _studySubjectIdTable(_$AppDatabase db) =>
      db.studySubjects.createAlias(
        $_aliasNameGenerator(
          db.studySessions.studySubjectId,
          db.studySubjects.id,
        ),
      );

  $$StudySubjectsTableProcessedTableManager? get studySubjectId {
    final $_column = $_itemColumn<String>('study_subject_id');
    if ($_column == null) return null;
    final manager = $$StudySubjectsTableTableManager(
      $_db,
      $_db.studySubjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studySubjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudyTopicsTable _studyTopicIdTable(_$AppDatabase db) =>
      db.studyTopics.createAlias(
        $_aliasNameGenerator(db.studySessions.studyTopicId, db.studyTopics.id),
      );

  $$StudyTopicsTableProcessedTableManager? get studyTopicId {
    final $_column = $_itemColumn<String>('study_topic_id');
    if ($_column == null) return null;
    final manager = $$StudyTopicsTableTableManager(
      $_db,
      $_db.studyTopics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyTopicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$StudySubjectsTableFilterComposer get studySubjectId {
    final $$StudySubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableFilterComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyTopicsTableFilterComposer get studyTopicId {
    final $$StudyTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyTopicId,
      referencedTable: $db.studyTopics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTopicsTableFilterComposer(
            $db: $db,
            $table: $db.studyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudySubjectsTableOrderingComposer get studySubjectId {
    final $$StudySubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyTopicsTableOrderingComposer get studyTopicId {
    final $$StudyTopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyTopicId,
      referencedTable: $db.studyTopics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTopicsTableOrderingComposer(
            $db: $db,
            $table: $db.studyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$StudySubjectsTableAnnotationComposer get studySubjectId {
    final $$StudySubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studySubjectId,
      referencedTable: $db.studySubjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyTopicsTableAnnotationComposer get studyTopicId {
    final $$StudyTopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyTopicId,
      referencedTable: $db.studyTopics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionsTable,
          StudySessionRow,
          $$StudySessionsTableFilterComposer,
          $$StudySessionsTableOrderingComposer,
          $$StudySessionsTableAnnotationComposer,
          $$StudySessionsTableCreateCompanionBuilder,
          $$StudySessionsTableUpdateCompanionBuilder,
          (StudySessionRow, $$StudySessionsTableReferences),
          StudySessionRow,
          PrefetchHooks Function({bool studySubjectId, bool studyTopicId})
        > {
  $$StudySessionsTableTableManager(_$AppDatabase db, $StudySessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> studySubjectId = const Value.absent(),
                Value<String?> studyTopicId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                studySubjectId: studySubjectId,
                studyTopicId: studyTopicId,
                startedAt: startedAt,
                endedAt: endedAt,
                durationMinutes: durationMinutes,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String syncStatus,
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> studySubjectId = const Value.absent(),
                Value<String?> studyTopicId = const Value.absent(),
                required DateTime startedAt,
                required DateTime endedAt,
                required int durationMinutes,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion.insert(
                id: id,
                remoteId: remoteId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
                studySubjectId: studySubjectId,
                studyTopicId: studyTopicId,
                startedAt: startedAt,
                endedAt: endedAt,
                durationMinutes: durationMinutes,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudySessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({studySubjectId = false, studyTopicId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studySubjectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studySubjectId,
                                    referencedTable:
                                        $$StudySessionsTableReferences
                                            ._studySubjectIdTable(db),
                                    referencedColumn:
                                        $$StudySessionsTableReferences
                                            ._studySubjectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (studyTopicId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studyTopicId,
                                    referencedTable:
                                        $$StudySessionsTableReferences
                                            ._studyTopicIdTable(db),
                                    referencedColumn:
                                        $$StudySessionsTableReferences
                                            ._studyTopicIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$StudySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionsTable,
      StudySessionRow,
      $$StudySessionsTableFilterComposer,
      $$StudySessionsTableOrderingComposer,
      $$StudySessionsTableAnnotationComposer,
      $$StudySessionsTableCreateCompanionBuilder,
      $$StudySessionsTableUpdateCompanionBuilder,
      (StudySessionRow, $$StudySessionsTableReferences),
      StudySessionRow,
      PrefetchHooks Function({bool studySubjectId, bool studyTopicId})
    >;
typedef $$SyncQueueEntriesTableCreateCompanionBuilder =
    SyncQueueEntriesCompanion Function({
      required String id,
      required String entityType,
      required String entityId,
      Value<int> entityVersion,
      required String operation,
      required String payloadJson,
      Value<String> status,
      Value<String?> deviceId,
      Value<String> conflictPolicy,
      Value<int> retryCount,
      required DateTime createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$SyncQueueEntriesTableUpdateCompanionBuilder =
    SyncQueueEntriesCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<int> entityVersion,
      Value<String> operation,
      Value<String> payloadJson,
      Value<String> status,
      Value<String?> deviceId,
      Value<String> conflictPolicy,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$SyncQueueEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityVersion => $composableBuilder(
    column: $table.entityVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conflictPolicy => $composableBuilder(
    column: $table.conflictPolicy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityVersion => $composableBuilder(
    column: $table.entityVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conflictPolicy => $composableBuilder(
    column: $table.conflictPolicy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<int> get entityVersion => $composableBuilder(
    column: $table.entityVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get conflictPolicy => $composableBuilder(
    column: $table.conflictPolicy,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$SyncQueueEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueEntriesTable,
          SyncQueueEntryRow,
          $$SyncQueueEntriesTableFilterComposer,
          $$SyncQueueEntriesTableOrderingComposer,
          $$SyncQueueEntriesTableAnnotationComposer,
          $$SyncQueueEntriesTableCreateCompanionBuilder,
          $$SyncQueueEntriesTableUpdateCompanionBuilder,
          (
            SyncQueueEntryRow,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueEntriesTable,
              SyncQueueEntryRow
            >,
          ),
          SyncQueueEntryRow,
          PrefetchHooks Function()
        > {
  $$SyncQueueEntriesTableTableManager(
    _$AppDatabase db,
    $SyncQueueEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<int> entityVersion = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> conflictPolicy = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueEntriesCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                entityVersion: entityVersion,
                operation: operation,
                payloadJson: payloadJson,
                status: status,
                deviceId: deviceId,
                conflictPolicy: conflictPolicy,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                Value<int> entityVersion = const Value.absent(),
                required String operation,
                required String payloadJson,
                Value<String> status = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> conflictPolicy = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueEntriesCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                entityVersion: entityVersion,
                operation: operation,
                payloadJson: payloadJson,
                status: status,
                deviceId: deviceId,
                conflictPolicy: conflictPolicy,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueEntriesTable,
      SyncQueueEntryRow,
      $$SyncQueueEntriesTableFilterComposer,
      $$SyncQueueEntriesTableOrderingComposer,
      $$SyncQueueEntriesTableAnnotationComposer,
      $$SyncQueueEntriesTableCreateCompanionBuilder,
      $$SyncQueueEntriesTableUpdateCompanionBuilder,
      (
        SyncQueueEntryRow,
        BaseReferences<
          _$AppDatabase,
          $SyncQueueEntriesTable,
          SyncQueueEntryRow
        >,
      ),
      SyncQueueEntryRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AcademicProfilesTableTableManager get academicProfiles =>
      $$AcademicProfilesTableTableManager(_db, _db.academicProfiles);
  $$CourseSubjectsTableTableManager get courseSubjects =>
      $$CourseSubjectsTableTableManager(_db, _db.courseSubjects);
  $$CourseSubjectLessonsTableTableManager get courseSubjectLessons =>
      $$CourseSubjectLessonsTableTableManager(_db, _db.courseSubjectLessons);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$ComplementaryActivitiesTableTableManager get complementaryActivities =>
      $$ComplementaryActivitiesTableTableManager(
        _db,
        _db.complementaryActivities,
      );
  $$InternshipsTableTableManager get internships =>
      $$InternshipsTableTableManager(_db, _db.internships);
  $$ExtensionActivitiesTableTableManager get extensionActivities =>
      $$ExtensionActivitiesTableTableManager(_db, _db.extensionActivities);
  $$StudySubjectsTableTableManager get studySubjects =>
      $$StudySubjectsTableTableManager(_db, _db.studySubjects);
  $$StudyTopicsTableTableManager get studyTopics =>
      $$StudyTopicsTableTableManager(_db, _db.studyTopics);
  $$StudyTasksTableTableManager get studyTasks =>
      $$StudyTasksTableTableManager(_db, _db.studyTasks);
  $$StudySessionsTableTableManager get studySessions =>
      $$StudySessionsTableTableManager(_db, _db.studySessions);
  $$SyncQueueEntriesTableTableManager get syncQueueEntries =>
      $$SyncQueueEntriesTableTableManager(_db, _db.syncQueueEntries);
}
