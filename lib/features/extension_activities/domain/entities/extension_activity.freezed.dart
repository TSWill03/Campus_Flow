// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extension_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtensionActivity {

 String get id; String? get remoteId; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted; String? get academicProfileId; String get title; String get type; DateTime get date; int get workloadHours; String? get notes; ValidationStatus get status;
/// Create a copy of ExtensionActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtensionActivityCopyWith<ExtensionActivity> get copyWith => _$ExtensionActivityCopyWithImpl<ExtensionActivity>(this as ExtensionActivity, _$identity);

  /// Serializes this ExtensionActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtensionActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.academicProfileId, academicProfileId) || other.academicProfileId == academicProfileId)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.workloadHours, workloadHours) || other.workloadHours == workloadHours)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,academicProfileId,title,type,date,workloadHours,notes,status);

@override
String toString() {
  return 'ExtensionActivity(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, academicProfileId: $academicProfileId, title: $title, type: $type, date: $date, workloadHours: $workloadHours, notes: $notes, status: $status)';
}


}

/// @nodoc
abstract mixin class $ExtensionActivityCopyWith<$Res>  {
  factory $ExtensionActivityCopyWith(ExtensionActivity value, $Res Function(ExtensionActivity) _then) = _$ExtensionActivityCopyWithImpl;
@useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String? academicProfileId, String title, String type, DateTime date, int workloadHours, String? notes, ValidationStatus status
});




}
/// @nodoc
class _$ExtensionActivityCopyWithImpl<$Res>
    implements $ExtensionActivityCopyWith<$Res> {
  _$ExtensionActivityCopyWithImpl(this._self, this._then);

  final ExtensionActivity _self;
  final $Res Function(ExtensionActivity) _then;

/// Create a copy of ExtensionActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? academicProfileId = freezed,Object? title = null,Object? type = null,Object? date = null,Object? workloadHours = null,Object? notes = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,academicProfileId: freezed == academicProfileId ? _self.academicProfileId : academicProfileId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,workloadHours: null == workloadHours ? _self.workloadHours : workloadHours // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ValidationStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ExtensionActivity].
extension ExtensionActivityPatterns on ExtensionActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtensionActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtensionActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtensionActivity value)  $default,){
final _that = this;
switch (_that) {
case _ExtensionActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtensionActivity value)?  $default,){
final _that = this;
switch (_that) {
case _ExtensionActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String title,  String type,  DateTime date,  int workloadHours,  String? notes,  ValidationStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtensionActivity() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.title,_that.type,_that.date,_that.workloadHours,_that.notes,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String title,  String type,  DateTime date,  int workloadHours,  String? notes,  ValidationStatus status)  $default,) {final _that = this;
switch (_that) {
case _ExtensionActivity():
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.title,_that.type,_that.date,_that.workloadHours,_that.notes,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String title,  String type,  DateTime date,  int workloadHours,  String? notes,  ValidationStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ExtensionActivity() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.title,_that.type,_that.date,_that.workloadHours,_that.notes,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtensionActivity implements ExtensionActivity {
  const _ExtensionActivity({required this.id, this.remoteId, required this.createdAt, required this.updatedAt, required this.syncStatus, required this.isDeleted, this.academicProfileId, required this.title, required this.type, required this.date, required this.workloadHours, this.notes, required this.status});
  factory _ExtensionActivity.fromJson(Map<String, dynamic> json) => _$ExtensionActivityFromJson(json);

@override final  String id;
@override final  String? remoteId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override final  bool isDeleted;
@override final  String? academicProfileId;
@override final  String title;
@override final  String type;
@override final  DateTime date;
@override final  int workloadHours;
@override final  String? notes;
@override final  ValidationStatus status;

/// Create a copy of ExtensionActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtensionActivityCopyWith<_ExtensionActivity> get copyWith => __$ExtensionActivityCopyWithImpl<_ExtensionActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtensionActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtensionActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.academicProfileId, academicProfileId) || other.academicProfileId == academicProfileId)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.workloadHours, workloadHours) || other.workloadHours == workloadHours)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,academicProfileId,title,type,date,workloadHours,notes,status);

@override
String toString() {
  return 'ExtensionActivity(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, academicProfileId: $academicProfileId, title: $title, type: $type, date: $date, workloadHours: $workloadHours, notes: $notes, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ExtensionActivityCopyWith<$Res> implements $ExtensionActivityCopyWith<$Res> {
  factory _$ExtensionActivityCopyWith(_ExtensionActivity value, $Res Function(_ExtensionActivity) _then) = __$ExtensionActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String? academicProfileId, String title, String type, DateTime date, int workloadHours, String? notes, ValidationStatus status
});




}
/// @nodoc
class __$ExtensionActivityCopyWithImpl<$Res>
    implements _$ExtensionActivityCopyWith<$Res> {
  __$ExtensionActivityCopyWithImpl(this._self, this._then);

  final _ExtensionActivity _self;
  final $Res Function(_ExtensionActivity) _then;

/// Create a copy of ExtensionActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? academicProfileId = freezed,Object? title = null,Object? type = null,Object? date = null,Object? workloadHours = null,Object? notes = freezed,Object? status = null,}) {
  return _then(_ExtensionActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,academicProfileId: freezed == academicProfileId ? _self.academicProfileId : academicProfileId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,workloadHours: null == workloadHours ? _self.workloadHours : workloadHours // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ValidationStatus,
  ));
}


}

// dart format on
