// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'uid_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UIDModel _$UIDModelFromJson(Map<String, dynamic> json) {
  return _UIDModel.fromJson(json);
}

/// @nodoc
mixin _$UIDModel {
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UIDModelCopyWith<UIDModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UIDModelCopyWith<$Res> {
  factory $UIDModelCopyWith(UIDModel value, $Res Function(UIDModel) then) =
      _$UIDModelCopyWithImpl<$Res, UIDModel>;
  @useResult
  $Res call({String uid});
}

/// @nodoc
class _$UIDModelCopyWithImpl<$Res, $Val extends UIDModel>
    implements $UIDModelCopyWith<$Res> {
  _$UIDModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UIDModelImplCopyWith<$Res>
    implements $UIDModelCopyWith<$Res> {
  factory _$$UIDModelImplCopyWith(
          _$UIDModelImpl value, $Res Function(_$UIDModelImpl) then) =
      __$$UIDModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid});
}

/// @nodoc
class __$$UIDModelImplCopyWithImpl<$Res>
    extends _$UIDModelCopyWithImpl<$Res, _$UIDModelImpl>
    implements _$$UIDModelImplCopyWith<$Res> {
  __$$UIDModelImplCopyWithImpl(
      _$UIDModelImpl _value, $Res Function(_$UIDModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
  }) {
    return _then(_$UIDModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UIDModelImpl implements _UIDModel {
  const _$UIDModelImpl({required this.uid});

  factory _$UIDModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UIDModelImplFromJson(json);

  @override
  final String uid;

  @override
  String toString() {
    return 'UIDModel(uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIDModelImpl &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UIDModelImplCopyWith<_$UIDModelImpl> get copyWith =>
      __$$UIDModelImplCopyWithImpl<_$UIDModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UIDModelImplToJson(
      this,
    );
  }
}

abstract class _UIDModel implements UIDModel {
  const factory _UIDModel({required final String uid}) = _$UIDModelImpl;

  factory _UIDModel.fromJson(Map<String, dynamic> json) =
      _$UIDModelImpl.fromJson;

  @override
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$UIDModelImplCopyWith<_$UIDModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
