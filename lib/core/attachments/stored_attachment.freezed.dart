// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stored_attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoredAttachment {

 String get id; String? get remoteId; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted; AttachmentOwnerType get ownerType; String get ownerId; String get fileName; List<int> get bytes; String? get mimeType; AttachmentCategory get category; DateTime? get dueDate; bool get isCompleted;
/// Create a copy of StoredAttachment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoredAttachmentCopyWith<StoredAttachment> get copyWith => _$StoredAttachmentCopyWithImpl<StoredAttachment>(this as StoredAttachment, _$identity);

  /// Serializes this StoredAttachment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoredAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.ownerType, ownerType) || other.ownerType == ownerType)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.category, category) || other.category == category)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,ownerType,ownerId,fileName,const DeepCollectionEquality().hash(bytes),mimeType,category,dueDate,isCompleted);

@override
String toString() {
  return 'StoredAttachment(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, ownerType: $ownerType, ownerId: $ownerId, fileName: $fileName, bytes: $bytes, mimeType: $mimeType, category: $category, dueDate: $dueDate, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $StoredAttachmentCopyWith<$Res>  {
  factory $StoredAttachmentCopyWith(StoredAttachment value, $Res Function(StoredAttachment) _then) = _$StoredAttachmentCopyWithImpl;
@useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, AttachmentOwnerType ownerType, String ownerId, String fileName, List<int> bytes, String? mimeType, AttachmentCategory category, DateTime? dueDate, bool isCompleted
});




}
/// @nodoc
class _$StoredAttachmentCopyWithImpl<$Res>
    implements $StoredAttachmentCopyWith<$Res> {
  _$StoredAttachmentCopyWithImpl(this._self, this._then);

  final StoredAttachment _self;
  final $Res Function(StoredAttachment) _then;

/// Create a copy of StoredAttachment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? ownerType = null,Object? ownerId = null,Object? fileName = null,Object? bytes = null,Object? mimeType = freezed,Object? category = null,Object? dueDate = freezed,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,ownerType: null == ownerType ? _self.ownerType : ownerType // ignore: cast_nullable_to_non_nullable
as AttachmentOwnerType,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as List<int>,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AttachmentCategory,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StoredAttachment].
extension StoredAttachmentPatterns on StoredAttachment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoredAttachment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoredAttachment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoredAttachment value)  $default,){
final _that = this;
switch (_that) {
case _StoredAttachment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoredAttachment value)?  $default,){
final _that = this;
switch (_that) {
case _StoredAttachment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  AttachmentOwnerType ownerType,  String ownerId,  String fileName,  List<int> bytes,  String? mimeType,  AttachmentCategory category,  DateTime? dueDate,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoredAttachment() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.ownerType,_that.ownerId,_that.fileName,_that.bytes,_that.mimeType,_that.category,_that.dueDate,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  AttachmentOwnerType ownerType,  String ownerId,  String fileName,  List<int> bytes,  String? mimeType,  AttachmentCategory category,  DateTime? dueDate,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _StoredAttachment():
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.ownerType,_that.ownerId,_that.fileName,_that.bytes,_that.mimeType,_that.category,_that.dueDate,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? remoteId,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted,  AttachmentOwnerType ownerType,  String ownerId,  String fileName,  List<int> bytes,  String? mimeType,  AttachmentCategory category,  DateTime? dueDate,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _StoredAttachment() when $default != null:
return $default(_that.id,_that.remoteId,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted,_that.ownerType,_that.ownerId,_that.fileName,_that.bytes,_that.mimeType,_that.category,_that.dueDate,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoredAttachment implements StoredAttachment {
  const _StoredAttachment({required this.id, this.remoteId, required this.createdAt, required this.updatedAt, required this.syncStatus, required this.isDeleted, required this.ownerType, required this.ownerId, required this.fileName, required final  List<int> bytes, this.mimeType, required this.category, this.dueDate, this.isCompleted = false}): _bytes = bytes;
  factory _StoredAttachment.fromJson(Map<String, dynamic> json) => _$StoredAttachmentFromJson(json);

@override final  String id;
@override final  String? remoteId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override final  bool isDeleted;
@override final  AttachmentOwnerType ownerType;
@override final  String ownerId;
@override final  String fileName;
 final  List<int> _bytes;
@override List<int> get bytes {
  if (_bytes is EqualUnmodifiableListView) return _bytes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bytes);
}

@override final  String? mimeType;
@override final  AttachmentCategory category;
@override final  DateTime? dueDate;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of StoredAttachment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoredAttachmentCopyWith<_StoredAttachment> get copyWith => __$StoredAttachmentCopyWithImpl<_StoredAttachment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoredAttachmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoredAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.ownerType, ownerType) || other.ownerType == ownerType)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other._bytes, _bytes)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.category, category) || other.category == category)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteId,createdAt,updatedAt,syncStatus,isDeleted,ownerType,ownerId,fileName,const DeepCollectionEquality().hash(_bytes),mimeType,category,dueDate,isCompleted);

@override
String toString() {
  return 'StoredAttachment(id: $id, remoteId: $remoteId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted, ownerType: $ownerType, ownerId: $ownerId, fileName: $fileName, bytes: $bytes, mimeType: $mimeType, category: $category, dueDate: $dueDate, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$StoredAttachmentCopyWith<$Res> implements $StoredAttachmentCopyWith<$Res> {
  factory _$StoredAttachmentCopyWith(_StoredAttachment value, $Res Function(_StoredAttachment) _then) = __$StoredAttachmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String? remoteId, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted, AttachmentOwnerType ownerType, String ownerId, String fileName, List<int> bytes, String? mimeType, AttachmentCategory category, DateTime? dueDate, bool isCompleted
});




}
/// @nodoc
class __$StoredAttachmentCopyWithImpl<$Res>
    implements _$StoredAttachmentCopyWith<$Res> {
  __$StoredAttachmentCopyWithImpl(this._self, this._then);

  final _StoredAttachment _self;
  final $Res Function(_StoredAttachment) _then;

/// Create a copy of StoredAttachment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,Object? ownerType = null,Object? ownerId = null,Object? fileName = null,Object? bytes = null,Object? mimeType = freezed,Object? category = null,Object? dueDate = freezed,Object? isCompleted = null,}) {
  return _then(_StoredAttachment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,ownerType: null == ownerType ? _self.ownerType : ownerType // ignore: cast_nullable_to_non_nullable
as AttachmentOwnerType,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,bytes: null == bytes ? _self._bytes : bytes // ignore: cast_nullable_to_non_nullable
as List<int>,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AttachmentCategory,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
