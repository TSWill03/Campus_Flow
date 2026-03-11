// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complementary_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComplementaryActivity {

 String get id; String? get remoteId; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted; String? get academicProfileId; String get title; String get category; DateTime get date; DateTime? get endDate; int get workloadHours; String? get notes; ValidationStatus get status;
/// Create a copy of ComplementaryActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplementaryActivityCopyWith<ComplementaryActivity> get copyWith => _$ComplementaryActivityCopyWithImpl<ComplementaryActivity>(this as ComplementaryActivity, _$identity);

  /// Serializes this ComplementaryActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplementaryActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.academicProfileId, academicProfileId) || other.academicProfileId == academicProfileId)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.date, date) || other.date == date)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.workloadHours, workloadHours) || other.workloadHours == workloadHours)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,academicProfileId,title,category,date,endDate,workloadHours,notes,status);

@override
String toString() {
  return 'ComplementaryActivity(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, academicProfileId: $academicProfileId, title: $title, category: $category, date: $date, endDate: $endDate, workloadHours: $workloadHours, notes: $notes, status: $status)';
}


}

/// @nodoc
abstract mixin class $ComplementaryActivityCopyWith<$Res>  {
  factory $ComplementaryActivityCopyWith(ComplementaryActivity value, $Res Function(ComplementaryActivity) _then) = _$ComplementaryActivityCopyWithImpl;
@useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String? academicProfileId, String title, String category, DateTime date, DateTime? endDate, int workloadHours, String? notes, ValidationStatus status
});




}
/// @nodoc
class _$ComplementaryActivityCopyWithImpl<$Res>
    implements $ComplementaryActivityCopyWith<$Res> {
  _$ComplementaryActivityCopyWithImpl(this._self, this._then);

  final ComplementaryActivity _self;
  final $Res Function(ComplementaryActivity) _then;

/// Create a copy of ComplementaryActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? academicProfileId = freezed,Object? title = null,Object? category = null,Object? date = null,Object? endDate = freezed,Object? workloadHours = null,Object? notes = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,academicProfileId: freezed == academicProfileId ? _self.academicProfileId : academicProfileId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,workloadHours: null == workloadHours ? _self.workloadHours : workloadHours // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ValidationStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ComplementaryActivity].
extension ComplementaryActivityPatterns on ComplementaryActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplementaryActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplementaryActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplementaryActivity value)  $default,){
final _that = this;
switch (_that) {
case _ComplementaryActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplementaryActivity value)?  $default,){
final _that = this;
switch (_that) {
case _ComplementaryActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String title,  String category,  DateTime date,  DateTime? endDate,  int workloadHours,  String? notes,  ValidationStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplementaryActivity() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.title,_that.category,_that.date,_that.endDate,_that.workloadHours,_that.notes,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String title,  String category,  DateTime date,  DateTime? endDate,  int workloadHours,  String? notes,  ValidationStatus status)  $default,) {final _that = this;
switch (_that) {
case _ComplementaryActivity():
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.title,_that.category,_that.date,_that.endDate,_that.workloadHours,_that.notes,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String title,  String category,  DateTime date,  DateTime? endDate,  int workloadHours,  String? notes,  ValidationStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ComplementaryActivity() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.title,_that.category,_that.date,_that.endDate,_that.workloadHours,_that.notes,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplementaryActivity implements ComplementaryActivity {
  const _ComplementaryActivity({required this.id, this.remoteId, required this.createdAt, required this.updatedAt, required this.syncStatus, required this.isDeleted, this.academicProfileId, required this.title, required this.category, required this.date, this.endDate, required this.workloadHours, this.notes, required this.status});
  factory _ComplementaryActivity.fromJson(Map<String, dynamic> json) => _$ComplementaryActivityFromJson(json);

@override final  String id;
@override final  String? remoteId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override final  bool isDeleted;
@override final  String? academicProfileId;
@override final  String title;
@override final  String category;
@override final  DateTime date;
@override final  DateTime? endDate;
@override final  int workloadHours;
@override final  String? notes;
@override final  ValidationStatus status;

/// Create a copy of ComplementaryActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplementaryActivityCopyWith<_ComplementaryActivity> get copyWith => __$ComplementaryActivityCopyWithImpl<_ComplementaryActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplementaryActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplementaryActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.academicProfileId, academicProfileId) || other.academicProfileId == academicProfileId)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.date, date) || other.date == date)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.workloadHours, workloadHours) || other.workloadHours == workloadHours)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,academicProfileId,title,category,date,endDate,workloadHours,notes,status);

@override
String toString() {
  return 'ComplementaryActivity(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, academicProfileId: $academicProfileId, title: $title, category: $category, date: $date, endDate: $endDate, workloadHours: $workloadHours, notes: $notes, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ComplementaryActivityCopyWith<$Res> implements $ComplementaryActivityCopyWith<$Res> {
  factory _$ComplementaryActivityCopyWith(_ComplementaryActivity value, $Res Function(_ComplementaryActivity) _then) = __$ComplementaryActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String? academicProfileId, String title, String category, DateTime date, DateTime? endDate, int workloadHours, String? notes, ValidationStatus status
});




}
/// @nodoc
class __$ComplementaryActivityCopyWithImpl<$Res>
    implements _$ComplementaryActivityCopyWith<$Res> {
  __$ComplementaryActivityCopyWithImpl(this._self, this._then);

  final _ComplementaryActivity _self;
  final $Res Function(_ComplementaryActivity) _then;

/// Create a copy of ComplementaryActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? academicProfileId = freezed,Object? title = null,Object? category = null,Object? date = null,Object? endDate = freezed,Object? workloadHours = null,Object? notes = freezed,Object? status = null,}) {
  return _then(_ComplementaryActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,academicProfileId: freezed == academicProfileId ? _self.academicProfileId : academicProfileId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,workloadHours: null == workloadHours ? _self.workloadHours : workloadHours // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ValidationStatus,
  ));
}


}

// dart format on
