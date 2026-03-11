// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_bundle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupBundle {

 int get schemaVersion; DateTime get exportedAt; List<AcademicProfile> get academicProfiles; List<CourseSubject> get courseSubjects; List<CourseSubjectLesson> get courseSubjectLessons; List<StoredAttachment> get attachments; List<ComplementaryActivity> get complementaryActivities; List<InternshipRecord> get internships; List<ExtensionActivity> get extensionActivities; List<StudySubject> get studySubjects; List<StudyTopic> get studyTopics; List<StudyTask> get studyTasks; List<StudySession> get studySessions;
/// Create a copy of BackupBundle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupBundleCopyWith<BackupBundle> get copyWith => _$BackupBundleCopyWithImpl<BackupBundle>(this as BackupBundle, _$identity);

  /// Serializes this BackupBundle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupBundle&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&const DeepCollectionEquality().equals(other.academicProfiles, academicProfiles)&&const DeepCollectionEquality().equals(other.courseSubjects, courseSubjects)&&const DeepCollectionEquality().equals(other.courseSubjectLessons, courseSubjectLessons)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&const DeepCollectionEquality().equals(other.complementaryActivities, complementaryActivities)&&const DeepCollectionEquality().equals(other.internships, internships)&&const DeepCollectionEquality().equals(other.extensionActivities, extensionActivities)&&const DeepCollectionEquality().equals(other.studySubjects, studySubjects)&&const DeepCollectionEquality().equals(other.studyTopics, studyTopics)&&const DeepCollectionEquality().equals(other.studyTasks, studyTasks)&&const DeepCollectionEquality().equals(other.studySessions, studySessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,exportedAt,const DeepCollectionEquality().hash(academicProfiles),const DeepCollectionEquality().hash(courseSubjects),const DeepCollectionEquality().hash(courseSubjectLessons),const DeepCollectionEquality().hash(attachments),const DeepCollectionEquality().hash(complementaryActivities),const DeepCollectionEquality().hash(internships),const DeepCollectionEquality().hash(extensionActivities),const DeepCollectionEquality().hash(studySubjects),const DeepCollectionEquality().hash(studyTopics),const DeepCollectionEquality().hash(studyTasks),const DeepCollectionEquality().hash(studySessions));

@override
String toString() {
  return 'BackupBundle(schemaVersion: $schemaVersion, exportedAt: $exportedAt, academicProfiles: $academicProfiles, courseSubjects: $courseSubjects, courseSubjectLessons: $courseSubjectLessons, attachments: $attachments, complementaryActivities: $complementaryActivities, internships: $internships, extensionActivities: $extensionActivities, studySubjects: $studySubjects, studyTopics: $studyTopics, studyTasks: $studyTasks, studySessions: $studySessions)';
}


}

/// @nodoc
abstract mixin class $BackupBundleCopyWith<$Res>  {
  factory $BackupBundleCopyWith(BackupBundle value, $Res Function(BackupBundle) _then) = _$BackupBundleCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, DateTime exportedAt, List<AcademicProfile> academicProfiles, List<CourseSubject> courseSubjects, List<CourseSubjectLesson> courseSubjectLessons, List<StoredAttachment> attachments, List<ComplementaryActivity> complementaryActivities, List<InternshipRecord> internships, List<ExtensionActivity> extensionActivities, List<StudySubject> studySubjects, List<StudyTopic> studyTopics, List<StudyTask> studyTasks, List<StudySession> studySessions
});




}
/// @nodoc
class _$BackupBundleCopyWithImpl<$Res>
    implements $BackupBundleCopyWith<$Res> {
  _$BackupBundleCopyWithImpl(this._self, this._then);

  final BackupBundle _self;
  final $Res Function(BackupBundle) _then;

/// Create a copy of BackupBundle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? exportedAt = null,Object? academicProfiles = null,Object? courseSubjects = null,Object? courseSubjectLessons = null,Object? attachments = null,Object? complementaryActivities = null,Object? internships = null,Object? extensionActivities = null,Object? studySubjects = null,Object? studyTopics = null,Object? studyTasks = null,Object? studySessions = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,academicProfiles: null == academicProfiles ? _self.academicProfiles : academicProfiles // ignore: cast_nullable_to_non_nullable
as List<AcademicProfile>,courseSubjects: null == courseSubjects ? _self.courseSubjects : courseSubjects // ignore: cast_nullable_to_non_nullable
as List<CourseSubject>,courseSubjectLessons: null == courseSubjectLessons ? _self.courseSubjectLessons : courseSubjectLessons // ignore: cast_nullable_to_non_nullable
as List<CourseSubjectLesson>,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<StoredAttachment>,complementaryActivities: null == complementaryActivities ? _self.complementaryActivities : complementaryActivities // ignore: cast_nullable_to_non_nullable
as List<ComplementaryActivity>,internships: null == internships ? _self.internships : internships // ignore: cast_nullable_to_non_nullable
as List<InternshipRecord>,extensionActivities: null == extensionActivities ? _self.extensionActivities : extensionActivities // ignore: cast_nullable_to_non_nullable
as List<ExtensionActivity>,studySubjects: null == studySubjects ? _self.studySubjects : studySubjects // ignore: cast_nullable_to_non_nullable
as List<StudySubject>,studyTopics: null == studyTopics ? _self.studyTopics : studyTopics // ignore: cast_nullable_to_non_nullable
as List<StudyTopic>,studyTasks: null == studyTasks ? _self.studyTasks : studyTasks // ignore: cast_nullable_to_non_nullable
as List<StudyTask>,studySessions: null == studySessions ? _self.studySessions : studySessions // ignore: cast_nullable_to_non_nullable
as List<StudySession>,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupBundle].
extension BackupBundlePatterns on BackupBundle {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupBundle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupBundle() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupBundle value)  $default,){
final _that = this;
switch (_that) {
case _BackupBundle():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupBundle value)?  $default,){
final _that = this;
switch (_that) {
case _BackupBundle() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  DateTime exportedAt,  List<AcademicProfile> academicProfiles,  List<CourseSubject> courseSubjects,  List<CourseSubjectLesson> courseSubjectLessons,  List<StoredAttachment> attachments,  List<ComplementaryActivity> complementaryActivities,  List<InternshipRecord> internships,  List<ExtensionActivity> extensionActivities,  List<StudySubject> studySubjects,  List<StudyTopic> studyTopics,  List<StudyTask> studyTasks,  List<StudySession> studySessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupBundle() when $default != null:
return $default(_that.schemaVersion,_that.exportedAt,_that.academicProfiles,_that.courseSubjects,_that.courseSubjectLessons,_that.attachments,_that.complementaryActivities,_that.internships,_that.extensionActivities,_that.studySubjects,_that.studyTopics,_that.studyTasks,_that.studySessions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  DateTime exportedAt,  List<AcademicProfile> academicProfiles,  List<CourseSubject> courseSubjects,  List<CourseSubjectLesson> courseSubjectLessons,  List<StoredAttachment> attachments,  List<ComplementaryActivity> complementaryActivities,  List<InternshipRecord> internships,  List<ExtensionActivity> extensionActivities,  List<StudySubject> studySubjects,  List<StudyTopic> studyTopics,  List<StudyTask> studyTasks,  List<StudySession> studySessions)  $default,) {final _that = this;
switch (_that) {
case _BackupBundle():
return $default(_that.schemaVersion,_that.exportedAt,_that.academicProfiles,_that.courseSubjects,_that.courseSubjectLessons,_that.attachments,_that.complementaryActivities,_that.internships,_that.extensionActivities,_that.studySubjects,_that.studyTopics,_that.studyTasks,_that.studySessions);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  DateTime exportedAt,  List<AcademicProfile> academicProfiles,  List<CourseSubject> courseSubjects,  List<CourseSubjectLesson> courseSubjectLessons,  List<StoredAttachment> attachments,  List<ComplementaryActivity> complementaryActivities,  List<InternshipRecord> internships,  List<ExtensionActivity> extensionActivities,  List<StudySubject> studySubjects,  List<StudyTopic> studyTopics,  List<StudyTask> studyTasks,  List<StudySession> studySessions)?  $default,) {final _that = this;
switch (_that) {
case _BackupBundle() when $default != null:
return $default(_that.schemaVersion,_that.exportedAt,_that.academicProfiles,_that.courseSubjects,_that.courseSubjectLessons,_that.attachments,_that.complementaryActivities,_that.internships,_that.extensionActivities,_that.studySubjects,_that.studyTopics,_that.studyTasks,_that.studySessions);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _BackupBundle implements BackupBundle {
  const _BackupBundle({required this.schemaVersion, required this.exportedAt, required final  List<AcademicProfile> academicProfiles, required final  List<CourseSubject> courseSubjects, required final  List<CourseSubjectLesson> courseSubjectLessons, required final  List<StoredAttachment> attachments, required final  List<ComplementaryActivity> complementaryActivities, required final  List<InternshipRecord> internships, required final  List<ExtensionActivity> extensionActivities, required final  List<StudySubject> studySubjects, required final  List<StudyTopic> studyTopics, required final  List<StudyTask> studyTasks, required final  List<StudySession> studySessions}): _academicProfiles = academicProfiles,_courseSubjects = courseSubjects,_courseSubjectLessons = courseSubjectLessons,_attachments = attachments,_complementaryActivities = complementaryActivities,_internships = internships,_extensionActivities = extensionActivities,_studySubjects = studySubjects,_studyTopics = studyTopics,_studyTasks = studyTasks,_studySessions = studySessions;
  factory _BackupBundle.fromJson(Map<String, dynamic> json) => _$BackupBundleFromJson(json);

@override final  int schemaVersion;
@override final  DateTime exportedAt;
 final  List<AcademicProfile> _academicProfiles;
@override List<AcademicProfile> get academicProfiles {
  if (_academicProfiles is EqualUnmodifiableListView) return _academicProfiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_academicProfiles);
}

 final  List<CourseSubject> _courseSubjects;
@override List<CourseSubject> get courseSubjects {
  if (_courseSubjects is EqualUnmodifiableListView) return _courseSubjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courseSubjects);
}

 final  List<CourseSubjectLesson> _courseSubjectLessons;
@override List<CourseSubjectLesson> get courseSubjectLessons {
  if (_courseSubjectLessons is EqualUnmodifiableListView) return _courseSubjectLessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courseSubjectLessons);
}

 final  List<StoredAttachment> _attachments;
@override List<StoredAttachment> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

 final  List<ComplementaryActivity> _complementaryActivities;
@override List<ComplementaryActivity> get complementaryActivities {
  if (_complementaryActivities is EqualUnmodifiableListView) return _complementaryActivities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_complementaryActivities);
}

 final  List<InternshipRecord> _internships;
@override List<InternshipRecord> get internships {
  if (_internships is EqualUnmodifiableListView) return _internships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_internships);
}

 final  List<ExtensionActivity> _extensionActivities;
@override List<ExtensionActivity> get extensionActivities {
  if (_extensionActivities is EqualUnmodifiableListView) return _extensionActivities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_extensionActivities);
}

 final  List<StudySubject> _studySubjects;
@override List<StudySubject> get studySubjects {
  if (_studySubjects is EqualUnmodifiableListView) return _studySubjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studySubjects);
}

 final  List<StudyTopic> _studyTopics;
@override List<StudyTopic> get studyTopics {
  if (_studyTopics is EqualUnmodifiableListView) return _studyTopics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studyTopics);
}

 final  List<StudyTask> _studyTasks;
@override List<StudyTask> get studyTasks {
  if (_studyTasks is EqualUnmodifiableListView) return _studyTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studyTasks);
}

 final  List<StudySession> _studySessions;
@override List<StudySession> get studySessions {
  if (_studySessions is EqualUnmodifiableListView) return _studySessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studySessions);
}


/// Create a copy of BackupBundle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupBundleCopyWith<_BackupBundle> get copyWith => __$BackupBundleCopyWithImpl<_BackupBundle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupBundleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupBundle&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&const DeepCollectionEquality().equals(other._academicProfiles, _academicProfiles)&&const DeepCollectionEquality().equals(other._courseSubjects, _courseSubjects)&&const DeepCollectionEquality().equals(other._courseSubjectLessons, _courseSubjectLessons)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&const DeepCollectionEquality().equals(other._complementaryActivities, _complementaryActivities)&&const DeepCollectionEquality().equals(other._internships, _internships)&&const DeepCollectionEquality().equals(other._extensionActivities, _extensionActivities)&&const DeepCollectionEquality().equals(other._studySubjects, _studySubjects)&&const DeepCollectionEquality().equals(other._studyTopics, _studyTopics)&&const DeepCollectionEquality().equals(other._studyTasks, _studyTasks)&&const DeepCollectionEquality().equals(other._studySessions, _studySessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,exportedAt,const DeepCollectionEquality().hash(_academicProfiles),const DeepCollectionEquality().hash(_courseSubjects),const DeepCollectionEquality().hash(_courseSubjectLessons),const DeepCollectionEquality().hash(_attachments),const DeepCollectionEquality().hash(_complementaryActivities),const DeepCollectionEquality().hash(_internships),const DeepCollectionEquality().hash(_extensionActivities),const DeepCollectionEquality().hash(_studySubjects),const DeepCollectionEquality().hash(_studyTopics),const DeepCollectionEquality().hash(_studyTasks),const DeepCollectionEquality().hash(_studySessions));

@override
String toString() {
  return 'BackupBundle(schemaVersion: $schemaVersion, exportedAt: $exportedAt, academicProfiles: $academicProfiles, courseSubjects: $courseSubjects, courseSubjectLessons: $courseSubjectLessons, attachments: $attachments, complementaryActivities: $complementaryActivities, internships: $internships, extensionActivities: $extensionActivities, studySubjects: $studySubjects, studyTopics: $studyTopics, studyTasks: $studyTasks, studySessions: $studySessions)';
}


}

/// @nodoc
abstract mixin class _$BackupBundleCopyWith<$Res> implements $BackupBundleCopyWith<$Res> {
  factory _$BackupBundleCopyWith(_BackupBundle value, $Res Function(_BackupBundle) _then) = __$BackupBundleCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, DateTime exportedAt, List<AcademicProfile> academicProfiles, List<CourseSubject> courseSubjects, List<CourseSubjectLesson> courseSubjectLessons, List<StoredAttachment> attachments, List<ComplementaryActivity> complementaryActivities, List<InternshipRecord> internships, List<ExtensionActivity> extensionActivities, List<StudySubject> studySubjects, List<StudyTopic> studyTopics, List<StudyTask> studyTasks, List<StudySession> studySessions
});




}
/// @nodoc
class __$BackupBundleCopyWithImpl<$Res>
    implements _$BackupBundleCopyWith<$Res> {
  __$BackupBundleCopyWithImpl(this._self, this._then);

  final _BackupBundle _self;
  final $Res Function(_BackupBundle) _then;

/// Create a copy of BackupBundle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? exportedAt = null,Object? academicProfiles = null,Object? courseSubjects = null,Object? courseSubjectLessons = null,Object? attachments = null,Object? complementaryActivities = null,Object? internships = null,Object? extensionActivities = null,Object? studySubjects = null,Object? studyTopics = null,Object? studyTasks = null,Object? studySessions = null,}) {
  return _then(_BackupBundle(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,academicProfiles: null == academicProfiles ? _self._academicProfiles : academicProfiles // ignore: cast_nullable_to_non_nullable
as List<AcademicProfile>,courseSubjects: null == courseSubjects ? _self._courseSubjects : courseSubjects // ignore: cast_nullable_to_non_nullable
as List<CourseSubject>,courseSubjectLessons: null == courseSubjectLessons ? _self._courseSubjectLessons : courseSubjectLessons // ignore: cast_nullable_to_non_nullable
as List<CourseSubjectLesson>,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<StoredAttachment>,complementaryActivities: null == complementaryActivities ? _self._complementaryActivities : complementaryActivities // ignore: cast_nullable_to_non_nullable
as List<ComplementaryActivity>,internships: null == internships ? _self._internships : internships // ignore: cast_nullable_to_non_nullable
as List<InternshipRecord>,extensionActivities: null == extensionActivities ? _self._extensionActivities : extensionActivities // ignore: cast_nullable_to_non_nullable
as List<ExtensionActivity>,studySubjects: null == studySubjects ? _self._studySubjects : studySubjects // ignore: cast_nullable_to_non_nullable
as List<StudySubject>,studyTopics: null == studyTopics ? _self._studyTopics : studyTopics // ignore: cast_nullable_to_non_nullable
as List<StudyTopic>,studyTasks: null == studyTasks ? _self._studyTasks : studyTasks // ignore: cast_nullable_to_non_nullable
as List<StudyTask>,studySessions: null == studySessions ? _self._studySessions : studySessions // ignore: cast_nullable_to_non_nullable
as List<StudySession>,
  ));
}


}

// dart format on
