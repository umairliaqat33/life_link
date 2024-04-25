// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) {
  return _PatientModel.fromJson(json);
}

/// @nodoc
mixin _$PatientModel {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get cnic => throw _privateConstructorUsedError;
  String get disease => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatientModelCopyWith<PatientModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientModelCopyWith<$Res> {
  factory $PatientModelCopyWith(
          PatientModel value, $Res Function(PatientModel) then) =
      _$PatientModelCopyWithImpl<$Res, PatientModel>;
  @useResult
  $Res call(
      {String email,
      String name,
      String uid,
      int age,
      String cnic,
      String disease,
      String gender,
      String phoneNumber});
}

/// @nodoc
class _$PatientModelCopyWithImpl<$Res, $Val extends PatientModel>
    implements $PatientModelCopyWith<$Res> {
  _$PatientModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? uid = null,
    Object? age = null,
    Object? cnic = null,
    Object? disease = null,
    Object? gender = null,
    Object? phoneNumber = null,
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
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      cnic: null == cnic
          ? _value.cnic
          : cnic // ignore: cast_nullable_to_non_nullable
              as String,
      disease: null == disease
          ? _value.disease
          : disease // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientModelImplCopyWith<$Res>
    implements $PatientModelCopyWith<$Res> {
  factory _$$PatientModelImplCopyWith(
          _$PatientModelImpl value, $Res Function(_$PatientModelImpl) then) =
      __$$PatientModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String name,
      String uid,
      int age,
      String cnic,
      String disease,
      String gender,
      String phoneNumber});
}

/// @nodoc
class __$$PatientModelImplCopyWithImpl<$Res>
    extends _$PatientModelCopyWithImpl<$Res, _$PatientModelImpl>
    implements _$$PatientModelImplCopyWith<$Res> {
  __$$PatientModelImplCopyWithImpl(
      _$PatientModelImpl _value, $Res Function(_$PatientModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? uid = null,
    Object? age = null,
    Object? cnic = null,
    Object? disease = null,
    Object? gender = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$PatientModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      cnic: null == cnic
          ? _value.cnic
          : cnic // ignore: cast_nullable_to_non_nullable
              as String,
      disease: null == disease
          ? _value.disease
          : disease // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientModelImpl implements _PatientModel {
  const _$PatientModelImpl(
      {required this.email,
      required this.name,
      required this.uid,
      this.age = 0,
      this.cnic = "",
      this.disease = "",
      this.gender = "",
      this.phoneNumber = ""});

  factory _$PatientModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientModelImplFromJson(json);

  @override
  final String email;
  @override
  final String name;
  @override
  final String uid;
  @override
  @JsonKey()
  final int age;
  @override
  @JsonKey()
  final String cnic;
  @override
  @JsonKey()
  final String disease;
  @override
  @JsonKey()
  final String gender;
  @override
  @JsonKey()
  final String phoneNumber;

  @override
  String toString() {
    return 'PatientModel(email: $email, name: $name, uid: $uid, age: $age, cnic: $cnic, disease: $disease, gender: $gender, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.cnic, cnic) || other.cnic == cnic) &&
            (identical(other.disease, disease) || other.disease == disease) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, email, name, uid, age, cnic, disease, gender, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientModelImplCopyWith<_$PatientModelImpl> get copyWith =>
      __$$PatientModelImplCopyWithImpl<_$PatientModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientModelImplToJson(
      this,
    );
  }
}

abstract class _PatientModel implements PatientModel {
  const factory _PatientModel(
      {required final String email,
      required final String name,
      required final String uid,
      final int age,
      final String cnic,
      final String disease,
      final String gender,
      final String phoneNumber}) = _$PatientModelImpl;

  factory _PatientModel.fromJson(Map<String, dynamic> json) =
      _$PatientModelImpl.fromJson;

  @override
  String get email;
  @override
  String get name;
  @override
  String get uid;
  @override
  int get age;
  @override
  String get cnic;
  @override
  String get disease;
  @override
  String get gender;
  @override
  String get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$PatientModelImplCopyWith<_$PatientModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
