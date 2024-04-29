// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hospital_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HospitalModel _$HospitalModelFromJson(Map<String, dynamic> json) {
  return _HospitalModel.fromJson(json);
}

/// @nodoc
mixin _$HospitalModel {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  double get hospitalLat => throw _privateConstructorUsedError;
  double get hospitalLon => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  int get totalBeds => throw _privateConstructorUsedError;
  int get availableBeds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HospitalModelCopyWith<HospitalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HospitalModelCopyWith<$Res> {
  factory $HospitalModelCopyWith(
          HospitalModel value, $Res Function(HospitalModel) then) =
      _$HospitalModelCopyWithImpl<$Res, HospitalModel>;
  @useResult
  $Res call(
      {String email,
      String name,
      String address,
      String uid,
      double hospitalLat,
      double hospitalLon,
      String phoneNumber,
      int totalBeds,
      int availableBeds});
}

/// @nodoc
class _$HospitalModelCopyWithImpl<$Res, $Val extends HospitalModel>
    implements $HospitalModelCopyWith<$Res> {
  _$HospitalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? address = null,
    Object? uid = null,
    Object? hospitalLat = null,
    Object? hospitalLon = null,
    Object? phoneNumber = null,
    Object? totalBeds = null,
    Object? availableBeds = null,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      hospitalLat: null == hospitalLat
          ? _value.hospitalLat
          : hospitalLat // ignore: cast_nullable_to_non_nullable
              as double,
      hospitalLon: null == hospitalLon
          ? _value.hospitalLon
          : hospitalLon // ignore: cast_nullable_to_non_nullable
              as double,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      totalBeds: null == totalBeds
          ? _value.totalBeds
          : totalBeds // ignore: cast_nullable_to_non_nullable
              as int,
      availableBeds: null == availableBeds
          ? _value.availableBeds
          : availableBeds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HospitalModelImplCopyWith<$Res>
    implements $HospitalModelCopyWith<$Res> {
  factory _$$HospitalModelImplCopyWith(
          _$HospitalModelImpl value, $Res Function(_$HospitalModelImpl) then) =
      __$$HospitalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String name,
      String address,
      String uid,
      double hospitalLat,
      double hospitalLon,
      String phoneNumber,
      int totalBeds,
      int availableBeds});
}

/// @nodoc
class __$$HospitalModelImplCopyWithImpl<$Res>
    extends _$HospitalModelCopyWithImpl<$Res, _$HospitalModelImpl>
    implements _$$HospitalModelImplCopyWith<$Res> {
  __$$HospitalModelImplCopyWithImpl(
      _$HospitalModelImpl _value, $Res Function(_$HospitalModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? address = null,
    Object? uid = null,
    Object? hospitalLat = null,
    Object? hospitalLon = null,
    Object? phoneNumber = null,
    Object? totalBeds = null,
    Object? availableBeds = null,
  }) {
    return _then(_$HospitalModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      hospitalLat: null == hospitalLat
          ? _value.hospitalLat
          : hospitalLat // ignore: cast_nullable_to_non_nullable
              as double,
      hospitalLon: null == hospitalLon
          ? _value.hospitalLon
          : hospitalLon // ignore: cast_nullable_to_non_nullable
              as double,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      totalBeds: null == totalBeds
          ? _value.totalBeds
          : totalBeds // ignore: cast_nullable_to_non_nullable
              as int,
      availableBeds: null == availableBeds
          ? _value.availableBeds
          : availableBeds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HospitalModelImpl implements _HospitalModel {
  const _$HospitalModelImpl(
      {required this.email,
      required this.name,
      required this.address,
      required this.uid,
      required this.hospitalLat,
      required this.hospitalLon,
      this.phoneNumber = "",
      this.totalBeds = 0,
      this.availableBeds = 0});

  factory _$HospitalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HospitalModelImplFromJson(json);

  @override
  final String email;
  @override
  final String name;
  @override
  final String address;
  @override
  final String uid;
  @override
  final double hospitalLat;
  @override
  final double hospitalLon;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final int totalBeds;
  @override
  @JsonKey()
  final int availableBeds;

  @override
  String toString() {
    return 'HospitalModel(email: $email, name: $name, address: $address, uid: $uid, hospitalLat: $hospitalLat, hospitalLon: $hospitalLon, phoneNumber: $phoneNumber, totalBeds: $totalBeds, availableBeds: $availableBeds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HospitalModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.hospitalLat, hospitalLat) ||
                other.hospitalLat == hospitalLat) &&
            (identical(other.hospitalLon, hospitalLon) ||
                other.hospitalLon == hospitalLon) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.totalBeds, totalBeds) ||
                other.totalBeds == totalBeds) &&
            (identical(other.availableBeds, availableBeds) ||
                other.availableBeds == availableBeds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, name, address, uid,
      hospitalLat, hospitalLon, phoneNumber, totalBeds, availableBeds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HospitalModelImplCopyWith<_$HospitalModelImpl> get copyWith =>
      __$$HospitalModelImplCopyWithImpl<_$HospitalModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HospitalModelImplToJson(
      this,
    );
  }
}

abstract class _HospitalModel implements HospitalModel {
  const factory _HospitalModel(
      {required final String email,
      required final String name,
      required final String address,
      required final String uid,
      required final double hospitalLat,
      required final double hospitalLon,
      final String phoneNumber,
      final int totalBeds,
      final int availableBeds}) = _$HospitalModelImpl;

  factory _HospitalModel.fromJson(Map<String, dynamic> json) =
      _$HospitalModelImpl.fromJson;

  @override
  String get email;
  @override
  String get name;
  @override
  String get address;
  @override
  String get uid;
  @override
  double get hospitalLat;
  @override
  double get hospitalLon;
  @override
  String get phoneNumber;
  @override
  int get totalBeds;
  @override
  int get availableBeds;
  @override
  @JsonKey(ignore: true)
  _$$HospitalModelImplCopyWith<_$HospitalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
