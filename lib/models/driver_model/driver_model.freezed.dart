// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) {
  return _DriverModel.fromJson(json);
}

/// @nodoc
mixin _$DriverModel {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get ambulanceId => throw _privateConstructorUsedError;
  String get ambulanceRegistrationNo => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get hospitalId => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  String get licenseNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DriverModelCopyWith<DriverModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverModelCopyWith<$Res> {
  factory $DriverModelCopyWith(
          DriverModel value, $Res Function(DriverModel) then) =
      _$DriverModelCopyWithImpl<$Res, DriverModel>;
  @useResult
  $Res call(
      {String email,
      String name,
      String ambulanceId,
      String ambulanceRegistrationNo,
      String uid,
      String hospitalId,
      bool isAvailable,
      String licenseNumber});
}

/// @nodoc
class _$DriverModelCopyWithImpl<$Res, $Val extends DriverModel>
    implements $DriverModelCopyWith<$Res> {
  _$DriverModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? ambulanceId = null,
    Object? ambulanceRegistrationNo = null,
    Object? uid = null,
    Object? hospitalId = null,
    Object? isAvailable = null,
    Object? licenseNumber = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ambulanceId: null == ambulanceId
          ? _value.ambulanceId
          : ambulanceId // ignore: cast_nullable_to_non_nullable
              as String,
      ambulanceRegistrationNo: null == ambulanceRegistrationNo
          ? _value.ambulanceRegistrationNo
          : ambulanceRegistrationNo // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      hospitalId: null == hospitalId
          ? _value.hospitalId
          : hospitalId // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      licenseNumber: null == licenseNumber
          ? _value.licenseNumber
          : licenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverModelImplCopyWith<$Res>
    implements $DriverModelCopyWith<$Res> {
  factory _$$DriverModelImplCopyWith(
          _$DriverModelImpl value, $Res Function(_$DriverModelImpl) then) =
      __$$DriverModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String name,
      String ambulanceId,
      String ambulanceRegistrationNo,
      String uid,
      String hospitalId,
      bool isAvailable,
      String licenseNumber});
}

/// @nodoc
class __$$DriverModelImplCopyWithImpl<$Res>
    extends _$DriverModelCopyWithImpl<$Res, _$DriverModelImpl>
    implements _$$DriverModelImplCopyWith<$Res> {
  __$$DriverModelImplCopyWithImpl(
      _$DriverModelImpl _value, $Res Function(_$DriverModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? ambulanceId = null,
    Object? ambulanceRegistrationNo = null,
    Object? uid = null,
    Object? hospitalId = null,
    Object? isAvailable = null,
    Object? licenseNumber = null,
  }) {
    return _then(_$DriverModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ambulanceId: null == ambulanceId
          ? _value.ambulanceId
          : ambulanceId // ignore: cast_nullable_to_non_nullable
              as String,
      ambulanceRegistrationNo: null == ambulanceRegistrationNo
          ? _value.ambulanceRegistrationNo
          : ambulanceRegistrationNo // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      hospitalId: null == hospitalId
          ? _value.hospitalId
          : hospitalId // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      licenseNumber: null == licenseNumber
          ? _value.licenseNumber
          : licenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverModelImpl implements _DriverModel {
  const _$DriverModelImpl(
      {required this.email,
      required this.name,
      required this.ambulanceId,
      required this.ambulanceRegistrationNo,
      required this.uid,
      required this.hospitalId,
      this.isAvailable = true,
      this.licenseNumber = ""});

  factory _$DriverModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverModelImplFromJson(json);

  @override
  final String email;
  @override
  final String name;
  @override
  final String ambulanceId;
  @override
  final String ambulanceRegistrationNo;
  @override
  final String uid;
  @override
  final String hospitalId;
  @override
  @JsonKey()
  final bool isAvailable;
  @override
  @JsonKey()
  final String licenseNumber;

  @override
  String toString() {
    return 'DriverModel(email: $email, name: $name, ambulanceId: $ambulanceId, ambulanceRegistrationNo: $ambulanceRegistrationNo, uid: $uid, hospitalId: $hospitalId, isAvailable: $isAvailable, licenseNumber: $licenseNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ambulanceId, ambulanceId) ||
                other.ambulanceId == ambulanceId) &&
            (identical(
                    other.ambulanceRegistrationNo, ambulanceRegistrationNo) ||
                other.ambulanceRegistrationNo == ambulanceRegistrationNo) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.hospitalId, hospitalId) ||
                other.hospitalId == hospitalId) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.licenseNumber, licenseNumber) ||
                other.licenseNumber == licenseNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, name, ambulanceId,
      ambulanceRegistrationNo, uid, hospitalId, isAvailable, licenseNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverModelImplCopyWith<_$DriverModelImpl> get copyWith =>
      __$$DriverModelImplCopyWithImpl<_$DriverModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverModelImplToJson(
      this,
    );
  }
}

abstract class _DriverModel implements DriverModel {
  const factory _DriverModel(
      {required final String email,
      required final String name,
      required final String ambulanceId,
      required final String ambulanceRegistrationNo,
      required final String uid,
      required final String hospitalId,
      final bool isAvailable,
      final String licenseNumber}) = _$DriverModelImpl;

  factory _DriverModel.fromJson(Map<String, dynamic> json) =
      _$DriverModelImpl.fromJson;

  @override
  String get email;
  @override
  String get name;
  @override
  String get ambulanceId;
  @override
  String get ambulanceRegistrationNo;
  @override
  String get uid;
  @override
  String get hospitalId;
  @override
  bool get isAvailable;
  @override
  String get licenseNumber;
  @override
  @JsonKey(ignore: true)
  _$$DriverModelImplCopyWith<_$DriverModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
