// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academic_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AcademicProfile {

 String get id; String? get remoteId; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted; String get profileName; String get courseName; String get institution; String? get schoolName; String? get campus; String? get degreeLabel; bool get isActive; int get totalCourseHours; int get semesterCount; int get requiredComplementaryHours; int get requiredInternshipHours; int get requiredExtensionHours;
/// Create a copy of AcademicProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcademicProfileCopyWith<AcademicProfile> get copyWith => _$AcademicProfileCopyWithImpl<AcademicProfile>(this as AcademicProfile, _$identity);

  /// Serializes this AcademicProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcademicProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.profileName, profileName) || other.profileName == profileName)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.schoolName, schoolName) || other.schoolName == schoolName)&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.degreeLabel, degreeLabel) || other.degreeLabel == degreeLabel)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.totalCourseHours, totalCourseHours) || other.totalCourseHours == totalCourseHours)&&(identical(other.semesterCount, semesterCount) || other.semesterCount == semesterCount)&&(identical(other.requiredComplementaryHours, requiredComplementaryHours) || other.requiredComplementaryHours == requiredComplementaryHours)&&(identical(other.requiredInternshipHours, requiredInternshipHours) || other.requiredInternshipHours == requiredInternshipHours)&&(identical(other.requiredExtensionHours, requiredExtensionHours) || other.requiredExtensionHours == requiredExtensionHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,profileName,courseName,institution,schoolName,campus,degreeLabel,isActive,totalCourseHours,semesterCount,requiredComplementaryHours,requiredInternshipHours,requiredExtensionHours);

@override
String toString() {
  return 'AcademicProfile(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, profileName: $profileName, courseName: $courseName, institution: $institution, schoolName: $schoolName, campus: $campus, degreeLabel: $degreeLabel, isActive: $isActive, totalCourseHours: $totalCourseHours, semesterCount: $semesterCount, requiredComplementaryHours: $requiredComplementaryHours, requiredInternshipHours: $requiredInternshipHours, requiredExtensionHours: $requiredExtensionHours)';
}


}

/// @nodoc
abstract mixin class $AcademicProfileCopyWith<$Res>  {
  factory $AcademicProfileCopyWith(AcademicProfile value, $Res Function(AcademicProfile) _then) = _$AcademicProfileCopyWithImpl;
@useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String profileName, String courseName, String institution, String? schoolName, String? campus, String? degreeLabel, bool isActive, int totalCourseHours, int semesterCount, int requiredComplementaryHours, int requiredInternshipHours, int requiredExtensionHours
});




}
/// @nodoc
class _$AcademicProfileCopyWithImpl<$Res>
    implements $AcademicProfileCopyWith<$Res> {
  _$AcademicProfileCopyWithImpl(this._self, this._then);

  final AcademicProfile _self;
  final $Res Function(AcademicProfile) _then;

/// Create a copy of AcademicProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? profileName = null,Object? courseName = null,Object? institution = null,Object? schoolName = freezed,Object? campus = freezed,Object? degreeLabel = freezed,Object? isActive = null,Object? totalCourseHours = null,Object? semesterCount = null,Object? requiredComplementaryHours = null,Object? requiredInternshipHours = null,Object? requiredExtensionHours = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,profileName: null == profileName ? _self.profileName : profileName // ignore: cast_nullable_to_non_nullable
as String,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,schoolName: freezed == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String?,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,degreeLabel: freezed == degreeLabel ? _self.degreeLabel : degreeLabel // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,totalCourseHours: null == totalCourseHours ? _self.totalCourseHours : totalCourseHours // ignore: cast_nullable_to_non_nullable
as int,semesterCount: null == semesterCount ? _self.semesterCount : semesterCount // ignore: cast_nullable_to_non_nullable
as int,requiredComplementaryHours: null == requiredComplementaryHours ? _self.requiredComplementaryHours : requiredComplementaryHours // ignore: cast_nullable_to_non_nullable
as int,requiredInternshipHours: null == requiredInternshipHours ? _self.requiredInternshipHours : requiredInternshipHours // ignore: cast_nullable_to_non_nullable
as int,requiredExtensionHours: null == requiredExtensionHours ? _self.requiredExtensionHours : requiredExtensionHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AcademicProfile].
extension AcademicProfilePatterns on AcademicProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AcademicProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AcademicProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AcademicProfile value)  $default,){
final _that = this;
switch (_that) {
case _AcademicProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AcademicProfile value)?  $default,){
final _that = this;
switch (_that) {
case _AcademicProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String profileName,  String courseName,  String institution,  String? schoolName,  String? campus,  String? degreeLabel,  bool isActive,  int totalCourseHours,  int semesterCount,  int requiredComplementaryHours,  int requiredInternshipHours,  int requiredExtensionHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AcademicProfile() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.profileName,_that.courseName,_that.institution,_that.schoolName,_that.campus,_that.degreeLabel,_that.isActive,_that.totalCourseHours,_that.semesterCount,_that.requiredComplementaryHours,_that.requiredInternshipHours,_that.requiredExtensionHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String profileName,  String courseName,  String institution,  String? schoolName,  String? campus,  String? degreeLabel,  bool isActive,  int totalCourseHours,  int semesterCount,  int requiredComplementaryHours,  int requiredInternshipHours,  int requiredExtensionHours)  $default,) {final _that = this;
switch (_that) {
case _AcademicProfile():
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.profileName,_that.courseName,_that.institution,_that.schoolName,_that.campus,_that.degreeLabel,_that.isActive,_that.totalCourseHours,_that.semesterCount,_that.requiredComplementaryHours,_that.requiredInternshipHours,_that.requiredExtensionHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String profileName,  String courseName,  String institution,  String? schoolName,  String? campus,  String? degreeLabel,  bool isActive,  int totalCourseHours,  int semesterCount,  int requiredComplementaryHours,  int requiredInternshipHours,  int requiredExtensionHours)?  $default,) {final _that = this;
switch (_that) {
case _AcademicProfile() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.profileName,_that.courseName,_that.institution,_that.schoolName,_that.campus,_that.degreeLabel,_that.isActive,_that.totalCourseHours,_that.semesterCount,_that.requiredComplementaryHours,_that.requiredInternshipHours,_that.requiredExtensionHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AcademicProfile implements AcademicProfile {
  const _AcademicProfile({required this.id, this.remoteId, required this.createdAt, required this.updatedAt, required this.syncStatus, required this.isDeleted, required this.profileName, required this.courseName, required this.institution, this.schoolName, this.campus, this.degreeLabel, this.isActive = false, required this.totalCourseHours, required this.semesterCount, required this.requiredComplementaryHours, required this.requiredInternshipHours, required this.requiredExtensionHours});
  factory _AcademicProfile.fromJson(Map<String, dynamic> json) => _$AcademicProfileFromJson(json);

@override final  String id;
@override final  String? remoteId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override final  bool isDeleted;
@override final  String profileName;
@override final  String courseName;
@override final  String institution;
@override final  String? schoolName;
@override final  String? campus;
@override final  String? degreeLabel;
@override@JsonKey() final  bool isActive;
@override final  int totalCourseHours;
@override final  int semesterCount;
@override final  int requiredComplementaryHours;
@override final  int requiredInternshipHours;
@override final  int requiredExtensionHours;

/// Create a copy of AcademicProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcademicProfileCopyWith<_AcademicProfile> get copyWith => __$AcademicProfileCopyWithImpl<_AcademicProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AcademicProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcademicProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.profileName, profileName) || other.profileName == profileName)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.schoolName, schoolName) || other.schoolName == schoolName)&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.degreeLabel, degreeLabel) || other.degreeLabel == degreeLabel)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.totalCourseHours, totalCourseHours) || other.totalCourseHours == totalCourseHours)&&(identical(other.semesterCount, semesterCount) || other.semesterCount == semesterCount)&&(identical(other.requiredComplementaryHours, requiredComplementaryHours) || other.requiredComplementaryHours == requiredComplementaryHours)&&(identical(other.requiredInternshipHours, requiredInternshipHours) || other.requiredInternshipHours == requiredInternshipHours)&&(identical(other.requiredExtensionHours, requiredExtensionHours) || other.requiredExtensionHours == requiredExtensionHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,profileName,courseName,institution,schoolName,campus,degreeLabel,isActive,totalCourseHours,semesterCount,requiredComplementaryHours,requiredInternshipHours,requiredExtensionHours);

@override
String toString() {
  return 'AcademicProfile(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, profileName: $profileName, courseName: $courseName, institution: $institution, schoolName: $schoolName, campus: $campus, degreeLabel: $degreeLabel, isActive: $isActive, totalCourseHours: $totalCourseHours, semesterCount: $semesterCount, requiredComplementaryHours: $requiredComplementaryHours, requiredInternshipHours: $requiredInternshipHours, requiredExtensionHours: $requiredExtensionHours)';
}


}

/// @nodoc
abstract mixin class _$AcademicProfileCopyWith<$Res> implements $AcademicProfileCopyWith<$Res> {
  factory _$AcademicProfileCopyWith(_AcademicProfile value, $Res Function(_AcademicProfile) _then) = __$AcademicProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String profileName, String courseName, String institution, String? schoolName, String? campus, String? degreeLabel, bool isActive, int totalCourseHours, int semesterCount, int requiredComplementaryHours, int requiredInternshipHours, int requiredExtensionHours
});




}
/// @nodoc
class __$AcademicProfileCopyWithImpl<$Res>
    implements _$AcademicProfileCopyWith<$Res> {
  __$AcademicProfileCopyWithImpl(this._self, this._then);

  final _AcademicProfile _self;
  final $Res Function(_AcademicProfile) _then;

/// Create a copy of AcademicProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? profileName = null,Object? courseName = null,Object? institution = null,Object? schoolName = freezed,Object? campus = freezed,Object? degreeLabel = freezed,Object? isActive = null,Object? totalCourseHours = null,Object? semesterCount = null,Object? requiredComplementaryHours = null,Object? requiredInternshipHours = null,Object? requiredExtensionHours = null,}) {
  return _then(_AcademicProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,profileName: null == profileName ? _self.profileName : profileName // ignore: cast_nullable_to_non_nullable
as String,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,schoolName: freezed == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String?,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,degreeLabel: freezed == degreeLabel ? _self.degreeLabel : degreeLabel // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,totalCourseHours: null == totalCourseHours ? _self.totalCourseHours : totalCourseHours // ignore: cast_nullable_to_non_nullable
as int,semesterCount: null == semesterCount ? _self.semesterCount : semesterCount // ignore: cast_nullable_to_non_nullable
as int,requiredComplementaryHours: null == requiredComplementaryHours ? _self.requiredComplementaryHours : requiredComplementaryHours // ignore: cast_nullable_to_non_nullable
as int,requiredInternshipHours: null == requiredInternshipHours ? _self.requiredInternshipHours : requiredInternshipHours // ignore: cast_nullable_to_non_nullable
as int,requiredExtensionHours: null == requiredExtensionHours ? _self.requiredExtensionHours : requiredExtensionHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
