// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_subject_lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseSubjectLesson {

 String get id; String? get remoteId; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted; String get courseSubjectId; DateTime get lessonDate; double get lessonHours; String get coveredContent; String? get description; String? get activityDescription; String? get assessmentDescription; DateTime? get assessmentDate; String? get pdfName; List<int>? get pdfBytes;
/// Create a copy of CourseSubjectLesson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseSubjectLessonCopyWith<CourseSubjectLesson> get copyWith => _$CourseSubjectLessonCopyWithImpl<CourseSubjectLesson>(this as CourseSubjectLesson, _$identity);

  /// Serializes this CourseSubjectLesson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseSubjectLesson&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.courseSubjectId, courseSubjectId) || other.courseSubjectId == courseSubjectId)&&(identical(other.lessonDate, lessonDate) || other.lessonDate == lessonDate)&&(identical(other.lessonHours, lessonHours) || other.lessonHours == lessonHours)&&(identical(other.coveredContent, coveredContent) || other.coveredContent == coveredContent)&&(identical(other.description, description) || other.description == description)&&(identical(other.activityDescription, activityDescription) || other.activityDescription == activityDescription)&&(identical(other.assessmentDescription, assessmentDescription) || other.assessmentDescription == assessmentDescription)&&(identical(other.assessmentDate, assessmentDate) || other.assessmentDate == assessmentDate)&&(identical(other.pdfName, pdfName) || other.pdfName == pdfName)&&const DeepCollectionEquality().equals(other.pdfBytes, pdfBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,courseSubjectId,lessonDate,lessonHours,coveredContent,description,activityDescription,assessmentDescription,assessmentDate,pdfName,const DeepCollectionEquality().hash(pdfBytes));

@override
String toString() {
  return 'CourseSubjectLesson(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, courseSubjectId: $courseSubjectId, lessonDate: $lessonDate, lessonHours: $lessonHours, coveredContent: $coveredContent, description: $description, activityDescription: $activityDescription, assessmentDescription: $assessmentDescription, assessmentDate: $assessmentDate, pdfName: $pdfName, pdfBytes: $pdfBytes)';
}


}

/// @nodoc
abstract mixin class $CourseSubjectLessonCopyWith<$Res>  {
  factory $CourseSubjectLessonCopyWith(CourseSubjectLesson value, $Res Function(CourseSubjectLesson) _then) = _$CourseSubjectLessonCopyWithImpl;
@useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String courseSubjectId, DateTime lessonDate, double lessonHours, String coveredContent, String? description, String? activityDescription, String? assessmentDescription, DateTime? assessmentDate, String? pdfName, List<int>? pdfBytes
});




}
/// @nodoc
class _$CourseSubjectLessonCopyWithImpl<$Res>
    implements $CourseSubjectLessonCopyWith<$Res> {
  _$CourseSubjectLessonCopyWithImpl(this._self, this._then);

  final CourseSubjectLesson _self;
  final $Res Function(CourseSubjectLesson) _then;

/// Create a copy of CourseSubjectLesson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? courseSubjectId = null,Object? lessonDate = null,Object? lessonHours = null,Object? coveredContent = null,Object? description = freezed,Object? activityDescription = freezed,Object? assessmentDescription = freezed,Object? assessmentDate = freezed,Object? pdfName = freezed,Object? pdfBytes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,courseSubjectId: null == courseSubjectId ? _self.courseSubjectId : courseSubjectId // ignore: cast_nullable_to_non_nullable
as String,lessonDate: null == lessonDate ? _self.lessonDate : lessonDate // ignore: cast_nullable_to_non_nullable
as DateTime,lessonHours: null == lessonHours ? _self.lessonHours : lessonHours // ignore: cast_nullable_to_non_nullable
as double,coveredContent: null == coveredContent ? _self.coveredContent : coveredContent // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,activityDescription: freezed == activityDescription ? _self.activityDescription : activityDescription // ignore: cast_nullable_to_non_nullable
as String?,assessmentDescription: freezed == assessmentDescription ? _self.assessmentDescription : assessmentDescription // ignore: cast_nullable_to_non_nullable
as String?,assessmentDate: freezed == assessmentDate ? _self.assessmentDate : assessmentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,pdfName: freezed == pdfName ? _self.pdfName : pdfName // ignore: cast_nullable_to_non_nullable
as String?,pdfBytes: freezed == pdfBytes ? _self.pdfBytes : pdfBytes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseSubjectLesson].
extension CourseSubjectLessonPatterns on CourseSubjectLesson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseSubjectLesson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseSubjectLesson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseSubjectLesson value)  $default,){
final _that = this;
switch (_that) {
case _CourseSubjectLesson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseSubjectLesson value)?  $default,){
final _that = this;
switch (_that) {
case _CourseSubjectLesson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String courseSubjectId,  DateTime lessonDate,  double lessonHours,  String coveredContent,  String? description,  String? activityDescription,  String? assessmentDescription,  DateTime? assessmentDate,  String? pdfName,  List<int>? pdfBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseSubjectLesson() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.courseSubjectId,_that.lessonDate,_that.lessonHours,_that.coveredContent,_that.description,_that.activityDescription,_that.assessmentDescription,_that.assessmentDate,_that.pdfName,_that.pdfBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String courseSubjectId,  DateTime lessonDate,  double lessonHours,  String coveredContent,  String? description,  String? activityDescription,  String? assessmentDescription,  DateTime? assessmentDate,  String? pdfName,  List<int>? pdfBytes)  $default,) {final _that = this;
switch (_that) {
case _CourseSubjectLesson():
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.courseSubjectId,_that.lessonDate,_that.lessonHours,_that.coveredContent,_that.description,_that.activityDescription,_that.assessmentDescription,_that.assessmentDate,_that.pdfName,_that.pdfBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String courseSubjectId,  DateTime lessonDate,  double lessonHours,  String coveredContent,  String? description,  String? activityDescription,  String? assessmentDescription,  DateTime? assessmentDate,  String? pdfName,  List<int>? pdfBytes)?  $default,) {final _that = this;
switch (_that) {
case _CourseSubjectLesson() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.courseSubjectId,_that.lessonDate,_that.lessonHours,_that.coveredContent,_that.description,_that.activityDescription,_that.assessmentDescription,_that.assessmentDate,_that.pdfName,_that.pdfBytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseSubjectLesson implements CourseSubjectLesson {
  const _CourseSubjectLesson({required this.id, this.remoteId, required this.createdAt, required this.updatedAt, required this.syncStatus, required this.isDeleted, required this.courseSubjectId, required this.lessonDate, required this.lessonHours, required this.coveredContent, this.description, this.activityDescription, this.assessmentDescription, this.assessmentDate, this.pdfName, final  List<int>? pdfBytes}): _pdfBytes = pdfBytes;
  factory _CourseSubjectLesson.fromJson(Map<String, dynamic> json) => _$CourseSubjectLessonFromJson(json);

@override final  String id;
@override final  String? remoteId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override final  bool isDeleted;
@override final  String courseSubjectId;
@override final  DateTime lessonDate;
@override final  double lessonHours;
@override final  String coveredContent;
@override final  String? description;
@override final  String? activityDescription;
@override final  String? assessmentDescription;
@override final  DateTime? assessmentDate;
@override final  String? pdfName;
 final  List<int>? _pdfBytes;
@override List<int>? get pdfBytes {
  final value = _pdfBytes;
  if (value == null) return null;
  if (_pdfBytes is EqualUnmodifiableListView) return _pdfBytes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CourseSubjectLesson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseSubjectLessonCopyWith<_CourseSubjectLesson> get copyWith => __$CourseSubjectLessonCopyWithImpl<_CourseSubjectLesson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseSubjectLessonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseSubjectLesson&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.courseSubjectId, courseSubjectId) || other.courseSubjectId == courseSubjectId)&&(identical(other.lessonDate, lessonDate) || other.lessonDate == lessonDate)&&(identical(other.lessonHours, lessonHours) || other.lessonHours == lessonHours)&&(identical(other.coveredContent, coveredContent) || other.coveredContent == coveredContent)&&(identical(other.description, description) || other.description == description)&&(identical(other.activityDescription, activityDescription) || other.activityDescription == activityDescription)&&(identical(other.assessmentDescription, assessmentDescription) || other.assessmentDescription == assessmentDescription)&&(identical(other.assessmentDate, assessmentDate) || other.assessmentDate == assessmentDate)&&(identical(other.pdfName, pdfName) || other.pdfName == pdfName)&&const DeepCollectionEquality().equals(other._pdfBytes, _pdfBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,courseSubjectId,lessonDate,lessonHours,coveredContent,description,activityDescription,assessmentDescription,assessmentDate,pdfName,const DeepCollectionEquality().hash(_pdfBytes));

@override
String toString() {
  return 'CourseSubjectLesson(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, courseSubjectId: $courseSubjectId, lessonDate: $lessonDate, lessonHours: $lessonHours, coveredContent: $coveredContent, description: $description, activityDescription: $activityDescription, assessmentDescription: $assessmentDescription, assessmentDate: $assessmentDate, pdfName: $pdfName, pdfBytes: $pdfBytes)';
}


}

/// @nodoc
abstract mixin class _$CourseSubjectLessonCopyWith<$Res> implements $CourseSubjectLessonCopyWith<$Res> {
  factory _$CourseSubjectLessonCopyWith(_CourseSubjectLesson value, $Res Function(_CourseSubjectLesson) _then) = __$CourseSubjectLessonCopyWithImpl;
@override @useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String courseSubjectId, DateTime lessonDate, double lessonHours, String coveredContent, String? description, String? activityDescription, String? assessmentDescription, DateTime? assessmentDate, String? pdfName, List<int>? pdfBytes
});




}
/// @nodoc
class __$CourseSubjectLessonCopyWithImpl<$Res>
    implements _$CourseSubjectLessonCopyWith<$Res> {
  __$CourseSubjectLessonCopyWithImpl(this._self, this._then);

  final _CourseSubjectLesson _self;
  final $Res Function(_CourseSubjectLesson) _then;

/// Create a copy of CourseSubjectLesson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? courseSubjectId = null,Object? lessonDate = null,Object? lessonHours = null,Object? coveredContent = null,Object? description = freezed,Object? activityDescription = freezed,Object? assessmentDescription = freezed,Object? assessmentDate = freezed,Object? pdfName = freezed,Object? pdfBytes = freezed,}) {
  return _then(_CourseSubjectLesson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,courseSubjectId: null == courseSubjectId ? _self.courseSubjectId : courseSubjectId // ignore: cast_nullable_to_non_nullable
as String,lessonDate: null == lessonDate ? _self.lessonDate : lessonDate // ignore: cast_nullable_to_non_nullable
as DateTime,lessonHours: null == lessonHours ? _self.lessonHours : lessonHours // ignore: cast_nullable_to_non_nullable
as double,coveredContent: null == coveredContent ? _self.coveredContent : coveredContent // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,activityDescription: freezed == activityDescription ? _self.activityDescription : activityDescription // ignore: cast_nullable_to_non_nullable
as String?,assessmentDescription: freezed == assessmentDescription ? _self.assessmentDescription : assessmentDescription // ignore: cast_nullable_to_non_nullable
as String?,assessmentDate: freezed == assessmentDate ? _self.assessmentDate : assessmentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,pdfName: freezed == pdfName ? _self.pdfName : pdfName // ignore: cast_nullable_to_non_nullable
as String?,pdfBytes: freezed == pdfBytes ? _self._pdfBytes : pdfBytes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
