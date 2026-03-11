// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyTask {

 String get id; String? get remoteId; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted; String get title; String? get description; String? get studySubjectId; DateTime? get dueDate; StudyTaskPriority get priority; StudyTaskStatus get status;
/// Create a copy of StudyTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyTaskCopyWith<StudyTask> get copyWith => _$StudyTaskCopyWithImpl<StudyTask>(this as StudyTask, _$identity);

  /// Serializes this StudyTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyTask&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.studySubjectId, studySubjectId) || other.studySubjectId == studySubjectId)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,title,description,studySubjectId,dueDate,priority,status);

@override
String toString() {
  return 'StudyTask(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, title: $title, description: $description, studySubjectId: $studySubjectId, dueDate: $dueDate, priority: $priority, status: $status)';
}


}

/// @nodoc
abstract mixin class $StudyTaskCopyWith<$Res>  {
  factory $StudyTaskCopyWith(StudyTask value, $Res Function(StudyTask) _then) = _$StudyTaskCopyWithImpl;
@useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String title, String? description, String? studySubjectId, DateTime? dueDate, StudyTaskPriority priority, StudyTaskStatus status
});




}
/// @nodoc
class _$StudyTaskCopyWithImpl<$Res>
    implements $StudyTaskCopyWith<$Res> {
  _$StudyTaskCopyWithImpl(this._self, this._then);

  final StudyTask _self;
  final $Res Function(StudyTask) _then;

/// Create a copy of StudyTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? title = null,Object? description = freezed,Object? studySubjectId = freezed,Object? dueDate = freezed,Object? priority = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,studySubjectId: freezed == studySubjectId ? _self.studySubjectId : studySubjectId // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as StudyTaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudyTaskStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyTask].
extension StudyTaskPatterns on StudyTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyTask value)  $default,){
final _that = this;
switch (_that) {
case _StudyTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyTask value)?  $default,){
final _that = this;
switch (_that) {
case _StudyTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String title,  String? description,  String? studySubjectId,  DateTime? dueDate,  StudyTaskPriority priority,  StudyTaskStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyTask() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.title,_that.description,_that.studySubjectId,_that.dueDate,_that.priority,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String title,  String? description,  String? studySubjectId,  DateTime? dueDate,  StudyTaskPriority priority,  StudyTaskStatus status)  $default,) {final _that = this;
switch (_that) {
case _StudyTask():
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.title,_that.description,_that.studySubjectId,_that.dueDate,_that.priority,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String title,  String? description,  String? studySubjectId,  DateTime? dueDate,  StudyTaskPriority priority,  StudyTaskStatus status)?  $default,) {final _that = this;
switch (_that) {
case _StudyTask() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.title,_that.description,_that.studySubjectId,_that.dueDate,_that.priority,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyTask implements StudyTask {
  const _StudyTask({required this.id, this.remoteId, required this.createdAt, required this.updatedAt, required this.syncStatus, required this.isDeleted, required this.title, this.description, this.studySubjectId, this.dueDate, required this.priority, required this.status});
  factory _StudyTask.fromJson(Map<String, dynamic> json) => _$StudyTaskFromJson(json);

@override final  String id;
@override final  String? remoteId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override final  bool isDeleted;
@override final  String title;
@override final  String? description;
@override final  String? studySubjectId;
@override final  DateTime? dueDate;
@override final  StudyTaskPriority priority;
@override final  StudyTaskStatus status;

/// Create a copy of StudyTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyTaskCopyWith<_StudyTask> get copyWith => __$StudyTaskCopyWithImpl<_StudyTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyTaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyTask&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.studySubjectId, studySubjectId) || other.studySubjectId == studySubjectId)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,title,description,studySubjectId,dueDate,priority,status);

@override
String toString() {
  return 'StudyTask(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, title: $title, description: $description, studySubjectId: $studySubjectId, dueDate: $dueDate, priority: $priority, status: $status)';
}


}

/// @nodoc
abstract mixin class _$StudyTaskCopyWith<$Res> implements $StudyTaskCopyWith<$Res> {
  factory _$StudyTaskCopyWith(_StudyTask value, $Res Function(_StudyTask) _then) = __$StudyTaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String title, String? description, String? studySubjectId, DateTime? dueDate, StudyTaskPriority priority, StudyTaskStatus status
});




}
/// @nodoc
class __$StudyTaskCopyWithImpl<$Res>
    implements _$StudyTaskCopyWith<$Res> {
  __$StudyTaskCopyWithImpl(this._self, this._then);

  final _StudyTask _self;
  final $Res Function(_StudyTask) _then;

/// Create a copy of StudyTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? title = null,Object? description = freezed,Object? studySubjectId = freezed,Object? dueDate = freezed,Object? priority = null,Object? status = null,}) {
  return _then(_StudyTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,studySubjectId: freezed == studySubjectId ? _self.studySubjectId : studySubjectId // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as StudyTaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudyTaskStatus,
  ));
}


}

// dart format on
