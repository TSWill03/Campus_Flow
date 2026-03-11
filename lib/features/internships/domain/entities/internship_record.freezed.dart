// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internship_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InternshipRecord {

 String get id; String? get remoteId; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted; String? get academicProfileId; String get location; String? get supervisor; DateTime get startDate; DateTime? get endDate; int get totalHours; int get completedHours; InternshipStatus get status; String? get notes;
/// Create a copy of InternshipRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InternshipRecordCopyWith<InternshipRecord> get copyWith => _$InternshipRecordCopyWithImpl<InternshipRecord>(this as InternshipRecord, _$identity);

  /// Serializes this InternshipRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InternshipRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.academicProfileId, academicProfileId) || other.academicProfileId == academicProfileId)&&(identical(other.location, location) || other.location == location)&&(identical(other.supervisor, supervisor) || other.supervisor == supervisor)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalHours, totalHours) || other.totalHours == totalHours)&&(identical(other.completedHours, completedHours) || other.completedHours == completedHours)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,academicProfileId,location,supervisor,startDate,endDate,totalHours,completedHours,status,notes);

@override
String toString() {
  return 'InternshipRecord(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, academicProfileId: $academicProfileId, location: $location, supervisor: $supervisor, startDate: $startDate, endDate: $endDate, totalHours: $totalHours, completedHours: $completedHours, status: $status, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $InternshipRecordCopyWith<$Res>  {
  factory $InternshipRecordCopyWith(InternshipRecord value, $Res Function(InternshipRecord) _then) = _$InternshipRecordCopyWithImpl;
@useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String? academicProfileId, String location, String? supervisor, DateTime startDate, DateTime? endDate, int totalHours, int completedHours, InternshipStatus status, String? notes
});




}
/// @nodoc
class _$InternshipRecordCopyWithImpl<$Res>
    implements $InternshipRecordCopyWith<$Res> {
  _$InternshipRecordCopyWithImpl(this._self, this._then);

  final InternshipRecord _self;
  final $Res Function(InternshipRecord) _then;

/// Create a copy of InternshipRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? academicProfileId = freezed,Object? location = null,Object? supervisor = freezed,Object? startDate = null,Object? endDate = freezed,Object? totalHours = null,Object? completedHours = null,Object? status = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,academicProfileId: freezed == academicProfileId ? _self.academicProfileId : academicProfileId // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,supervisor: freezed == supervisor ? _self.supervisor : supervisor // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,totalHours: null == totalHours ? _self.totalHours : totalHours // ignore: cast_nullable_to_non_nullable
as int,completedHours: null == completedHours ? _self.completedHours : completedHours // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InternshipStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InternshipRecord].
extension InternshipRecordPatterns on InternshipRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InternshipRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InternshipRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InternshipRecord value)  $default,){
final _that = this;
switch (_that) {
case _InternshipRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InternshipRecord value)?  $default,){
final _that = this;
switch (_that) {
case _InternshipRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String location,  String? supervisor,  DateTime startDate,  DateTime? endDate,  int totalHours,  int completedHours,  InternshipStatus status,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InternshipRecord() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.location,_that.supervisor,_that.startDate,_that.endDate,_that.totalHours,_that.completedHours,_that.status,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String location,  String? supervisor,  DateTime startDate,  DateTime? endDate,  int totalHours,  int completedHours,  InternshipStatus status,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _InternshipRecord():
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.location,_that.supervisor,_that.startDate,_that.endDate,_that.totalHours,_that.completedHours,_that.status,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  String? academicProfileId,  String location,  String? supervisor,  DateTime startDate,  DateTime? endDate,  int totalHours,  int completedHours,  InternshipStatus status,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _InternshipRecord() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.academicProfileId,_that.location,_that.supervisor,_that.startDate,_that.endDate,_that.totalHours,_that.completedHours,_that.status,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InternshipRecord implements InternshipRecord {
  const _InternshipRecord({required this.id, this.remoteId, required this.createdAt, required this.updatedAt, required this.syncStatus, required this.isDeleted, this.academicProfileId, required this.location, this.supervisor, required this.startDate, this.endDate, required this.totalHours, required this.completedHours, required this.status, this.notes});
  factory _InternshipRecord.fromJson(Map<String, dynamic> json) => _$InternshipRecordFromJson(json);

@override final  String id;
@override final  String? remoteId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override final  bool isDeleted;
@override final  String? academicProfileId;
@override final  String location;
@override final  String? supervisor;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  int totalHours;
@override final  int completedHours;
@override final  InternshipStatus status;
@override final  String? notes;

/// Create a copy of InternshipRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InternshipRecordCopyWith<_InternshipRecord> get copyWith => __$InternshipRecordCopyWithImpl<_InternshipRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InternshipRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InternshipRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.academicProfileId, academicProfileId) || other.academicProfileId == academicProfileId)&&(identical(other.location, location) || other.location == location)&&(identical(other.supervisor, supervisor) || other.supervisor == supervisor)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalHours, totalHours) || other.totalHours == totalHours)&&(identical(other.completedHours, completedHours) || other.completedHours == completedHours)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,academicProfileId,location,supervisor,startDate,endDate,totalHours,completedHours,status,notes);

@override
String toString() {
  return 'InternshipRecord(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, academicProfileId: $academicProfileId, location: $location, supervisor: $supervisor, startDate: $startDate, endDate: $endDate, totalHours: $totalHours, completedHours: $completedHours, status: $status, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$InternshipRecordCopyWith<$Res> implements $InternshipRecordCopyWith<$Res> {
  factory _$InternshipRecordCopyWith(_InternshipRecord value, $Res Function(_InternshipRecord) _then) = __$InternshipRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, String? academicProfileId, String location, String? supervisor, DateTime startDate, DateTime? endDate, int totalHours, int completedHours, InternshipStatus status, String? notes
});




}
/// @nodoc
class __$InternshipRecordCopyWithImpl<$Res>
    implements _$InternshipRecordCopyWith<$Res> {
  __$InternshipRecordCopyWithImpl(this._self, this._then);

  final _InternshipRecord _self;
  final $Res Function(_InternshipRecord) _then;

/// Create a copy of InternshipRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? academicProfileId = freezed,Object? location = null,Object? supervisor = freezed,Object? startDate = null,Object? endDate = freezed,Object? totalHours = null,Object? completedHours = null,Object? status = null,Object? notes = freezed,}) {
  return _then(_InternshipRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,academicProfileId: freezed == academicProfileId ? _self.academicProfileId : academicProfileId // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,supervisor: freezed == supervisor ? _self.supervisor : supervisor // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,totalHours: null == totalHours ? _self.totalHours : totalHours // ignore: cast_nullable_to_non_nullable
as int,completedHours: null == completedHours ? _self.completedHours : completedHours // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InternshipStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
