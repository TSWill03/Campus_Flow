// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_subject.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseSubject {

 String get id; String? get remoteId; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted; String? get academicProfileId; String get name; String? get code; int get workloadHours; int? get electiveHours; int? get suggestedSemester; CourseSubjectType get type; CourseSubjectStatus get status; String? get notes;
/// Create a copy of CourseSubject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseSubjectCopyWith<CourseSubject> get copyWith => _$CourseSubjectCopyWithImpl<CourseSubject>(this as CourseSubject, _$identity);

  /// Serializes this CourseSubject to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseSubject&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.academicProfileId, academicProfileId) || other.academicProfileId == academicProfileId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.workloadHours, workloadHours) || other.workloadHours == workloadHours)&&(identical(other.electiveHours, electiveHours) || other.electiveHours == electiveHours)&&(identical(other.suggestedSemester, suggestedSemester) || other.suggestedSemester == suggestedSemester)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,academicProfileId,name,code,workloadHours,electiveHours,suggestedSemester,type,status,notes);

@override
String toString() {
  return 'CourseSubject(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, academicProfileId: $academicProfileId, name: $name, code: $code, workloadHours: $workloadHours, electiveHours: $electiveHours, suggestedSemester: $suggestedSemester, type: $type, status: $status, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $CourseSubjectCopyWith<$Res>  {
  factory $CourseSubjectCopyWith(CourseSubject value, $Res Function(CourseSubject) _then) = _$CourseSubjectCopyWithImpl;
@useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String? academicProfileId, String name, String? code, int workloadHours, int? electiveHours, int? suggestedSemester, CourseSubjectType type, CourseSubjectStatus status, String? notes
});




}
/// @nodoc
class _$CourseSubjectCopyWithImpl<$Res>
    implements $CourseSubjectCopyWith<$Res> {
  _$CourseSubjectCopyWithImpl(this._self, this._then);

  final CourseSubject _self;
  final $Res Function(CourseSubject) _then;

/// Create a copy of CourseSubject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? academicProfileId = freezed,Object? name = null,Object? code = freezed,Object? workloadHours = null,Object? electiveHours = freezed,Object? suggestedSemester = freezed,Object? type = null,Object? status = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,academicProfileId: freezed == academicProfileId ? _self.academicProfileId : academicProfileId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,workloadHours: null == workloadHours ? _self.workloadHours : workloadHours // ignore: cast_nullable_to_non_nullable
as int,electiveHours: freezed == electiveHours ? _self.electiveHours : electiveHours // ignore: cast_nullable_to_non_nullable
as int?,suggestedSemester: freezed == suggestedSemester ? _self.suggestedSemester : suggestedSemester // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CourseSubjectType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CourseSubjectStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseSubject].
extension CourseSubjectPatterns on CourseSubject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseSubject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseSubject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseSubject value)  $default,){
final _that = this;
switch (_that) {
case _CourseSubject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseSubject value)?  $default,){
final _that = this;
switch (_that) {
case _CourseSubject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String name,  String? code,  int workloadHours,  int? electiveHours,  int? suggestedSemester,  CourseSubjectType type,  CourseSubjectStatus status,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseSubject() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.name,_that.code,_that.workloadHours,_that.electiveHours,_that.suggestedSemester,_that.type,_that.status,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String name,  String? code,  int workloadHours,  int? electiveHours,  int? suggestedSemester,  CourseSubjectType type,  CourseSubjectStatus status,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _CourseSubject():
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.name,_that.code,_that.workloadHours,_that.electiveHours,_that.suggestedSemester,_that.type,_that.status,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String name,  String? code,  int workloadHours,  int? electiveHours,  int? suggestedSemester,  CourseSubjectType type,  CourseSubjectStatus status,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _CourseSubject() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.name,_that.code,_that.workloadHours,_that.electiveHours,_that.suggestedSemester,_that.type,_that.status,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseSubject implements CourseSubject {
  const _CourseSubject({required this.id, this.remoteId, required this.createdAt, required this.updatedAt, required this.syncStatus, required this.isDeleted, this.academicProfileId, required this.name, this.code, required this.workloadHours, this.electiveHours, this.suggestedSemester, required this.type, required this.status, this.notes});
  factory _CourseSubject.fromJson(Map<String, dynamic> json) => _$CourseSubjectFromJson(json);

@override final  String id;
@override final  String? remoteId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override final  bool isDeleted;
@override final  String? academicProfileId;
@override final  String name;
@override final  String? code;
@override final  int workloadHours;
@override final  int? electiveHours;
@override final  int? suggestedSemester;
@override final  CourseSubjectType type;
@override final  CourseSubjectStatus status;
@override final  String? notes;

/// Create a copy of CourseSubject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseSubjectCopyWith<_CourseSubject> get copyWith => __$CourseSubjectCopyWithImpl<_CourseSubject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseSubjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseSubject&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.academicProfileId, academicProfileId) || other.academicProfileId == academicProfileId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.workloadHours, workloadHours) || other.workloadHours == workloadHours)&&(identical(other.electiveHours, electiveHours) || other.electiveHours == electiveHours)&&(identical(other.suggestedSemester, suggestedSemester) || other.suggestedSemester == suggestedSemester)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,academicProfileId,name,code,workloadHours,electiveHours,suggestedSemester,type,status,notes);

@override
String toString() {
  return 'CourseSubject(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, academicProfileId: $academicProfileId, name: $name, code: $code, workloadHours: $workloadHours, electiveHours: $electiveHours, suggestedSemester: $suggestedSemester, type: $type, status: $status, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CourseSubjectCopyWith<$Res> implements $CourseSubjectCopyWith<$Res> {
  factory _$CourseSubjectCopyWith(_CourseSubject value, $Res Function(_CourseSubject) _then) = __$CourseSubjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String? academicProfileId, String name, String? code, int workloadHours, int? electiveHours, int? suggestedSemester, CourseSubjectType type, CourseSubjectStatus status, String? notes
});




}
/// @nodoc
class __$CourseSubjectCopyWithImpl<$Res>
    implements _$CourseSubjectCopyWith<$Res> {
  __$CourseSubjectCopyWithImpl(this._self, this._then);

  final _CourseSubject _self;
  final $Res Function(_CourseSubject) _then;

/// Create a copy of CourseSubject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? academicProfileId = freezed,Object? name = null,Object? code = freezed,Object? workloadHours = null,Object? electiveHours = freezed,Object? suggestedSemester = freezed,Object? type = null,Object? status = null,Object? notes = freezed,}) {
  return _then(_CourseSubject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,academicProfileId: freezed == academicProfileId ? _self.academicProfileId : academicProfileId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,workloadHours: null == workloadHours ? _self.workloadHours : workloadHours // ignore: cast_nullable_to_non_nullable
as int,electiveHours: freezed == electiveHours ? _self.electiveHours : electiveHours // ignore: cast_nullable_to_non_nullable
as int?,suggestedSemester: freezed == suggestedSemester ? _self.suggestedSemester : suggestedSemester // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CourseSubjectType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CourseSubjectStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
