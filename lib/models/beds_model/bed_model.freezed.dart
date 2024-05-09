// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BedModel _$BedModelFromJson(Map<String, dynamic> json) {
  return _BedsModel.fromJson(json);
}

/// @nodoc
mixin _$BedModel {
  int get bedId => throw _privateConstructorUsedError;
  String get hospitalId => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BedModelCopyWith<BedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BedModelCopyWith<$Res> {
  factory $BedModelCopyWith(BedModel value, $Res Function(BedModel) then) =
      _$BedModelCopyWithImpl<$Res, BedModel>;
  @useResult
  $Res call({int bedId, String hospitalId, bool isAvailable});
}

/// @nodoc
class _$BedModelCopyWithImpl<$Res, $Val extends BedModel>
    implements $BedModelCopyWith<$Res> {
  _$BedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bedId = null,
    Object? hospitalId = null,
    Object? isAvailable = null,
  }) {
    return _then(_value.copyWith(
      bedId: null == bedId
          ? _value.bedId
          : bedId // ignore: cast_nullable_to_non_nullable
              as int,
      hospitalId: null == hospitalId
          ? _value.hospitalId
          : hospitalId // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BedsModelImplCopyWith<$Res>
    implements $BedModelCopyWith<$Res> {
  factory _$$BedsModelImplCopyWith(
          _$BedsModelImpl value, $Res Function(_$BedsModelImpl) then) =
      __$$BedsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bedId, String hospitalId, bool isAvailable});
}

/// @nodoc
class __$$BedsModelImplCopyWithImpl<$Res>
    extends _$BedModelCopyWithImpl<$Res, _$BedsModelImpl>
    implements _$$BedsModelImplCopyWith<$Res> {
  __$$BedsModelImplCopyWithImpl(
      _$BedsModelImpl _value, $Res Function(_$BedsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bedId = null,
    Object? hospitalId = null,
    Object? isAvailable = null,
  }) {
    return _then(_$BedsModelImpl(
      bedId: null == bedId
          ? _value.bedId
          : bedId // ignore: cast_nullable_to_non_nullable
              as int,
      hospitalId: null == hospitalId
          ? _value.hospitalId
          : hospitalId // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BedsModelImpl implements _BedsModel {
  const _$BedsModelImpl(
      {required this.bedId,
      required this.hospitalId,
      this.isAvailable = false});

  factory _$BedsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BedsModelImplFromJson(json);

  @override
  final int bedId;
  @override
  final String hospitalId;
  @override
  @JsonKey()
  final bool isAvailable;

  @override
  String toString() {
    return 'BedModel(bedId: $bedId, hospitalId: $hospitalId, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BedsModelImpl &&
            (identical(other.bedId, bedId) || other.bedId == bedId) &&
            (identical(other.hospitalId, hospitalId) ||
                other.hospitalId == hospitalId) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bedId, hospitalId, isAvailable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BedsModelImplCopyWith<_$BedsModelImpl> get copyWith =>
      __$$BedsModelImplCopyWithImpl<_$BedsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BedsModelImplToJson(
      this,
    );
  }
}

abstract class _BedsModel implements BedModel {
  const factory _BedsModel(
      {required final int bedId,
      required final String hospitalId,
      final bool isAvailable}) = _$BedsModelImpl;

  factory _BedsModel.fromJson(Map<String, dynamic> json) =
      _$BedsModelImpl.fromJson;

  @override
  int get bedId;
  @override
  String get hospitalId;
  @override
  bool get isAvailable;
  @override
  @JsonKey(ignore: true)
  _$$BedsModelImplCopyWith<_$BedsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
