// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) {
  return _DoctorModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorModel {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get comingTime => throw _privateConstructorUsedError;
  String get leavingTime => throw _privateConstructorUsedError;
  String get education => throw _privateConstructorUsedError;
  String get speciality => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorModelCopyWith<DoctorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorModelCopyWith<$Res> {
  factory $DoctorModelCopyWith(
          DoctorModel value, $Res Function(DoctorModel) then) =
      _$DoctorModelCopyWithImpl<$Res, DoctorModel>;
  @useResult
  $Res call(
      {String email,
      String name,
      String comingTime,
      String leavingTime,
      String education,
      String speciality,
      String profileImage});
}

/// @nodoc
class _$DoctorModelCopyWithImpl<$Res, $Val extends DoctorModel>
    implements $DoctorModelCopyWith<$Res> {
  _$DoctorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? comingTime = null,
    Object? leavingTime = null,
    Object? education = null,
    Object? speciality = null,
    Object? profileImage = null,
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
      comingTime: null == comingTime
          ? _value.comingTime
          : comingTime // ignore: cast_nullable_to_non_nullable
              as String,
      leavingTime: null == leavingTime
          ? _value.leavingTime
          : leavingTime // ignore: cast_nullable_to_non_nullable
              as String,
      education: null == education
          ? _value.education
          : education // ignore: cast_nullable_to_non_nullable
              as String,
      speciality: null == speciality
          ? _value.speciality
          : speciality // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DoctorModelImplCopyWith<$Res>
    implements $DoctorModelCopyWith<$Res> {
  factory _$$DoctorModelImplCopyWith(
          _$DoctorModelImpl value, $Res Function(_$DoctorModelImpl) then) =
      __$$DoctorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String name,
      String comingTime,
      String leavingTime,
      String education,
      String speciality,
      String profileImage});
}

/// @nodoc
class __$$DoctorModelImplCopyWithImpl<$Res>
    extends _$DoctorModelCopyWithImpl<$Res, _$DoctorModelImpl>
    implements _$$DoctorModelImplCopyWith<$Res> {
  __$$DoctorModelImplCopyWithImpl(
      _$DoctorModelImpl _value, $Res Function(_$DoctorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? comingTime = null,
    Object? leavingTime = null,
    Object? education = null,
    Object? speciality = null,
    Object? profileImage = null,
  }) {
    return _then(_$DoctorModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comingTime: null == comingTime
          ? _value.comingTime
          : comingTime // ignore: cast_nullable_to_non_nullable
              as String,
      leavingTime: null == leavingTime
          ? _value.leavingTime
          : leavingTime // ignore: cast_nullable_to_non_nullable
              as String,
      education: null == education
          ? _value.education
          : education // ignore: cast_nullable_to_non_nullable
              as String,
      speciality: null == speciality
          ? _value.speciality
          : speciality // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorModelImpl implements _DoctorModel {
  const _$DoctorModelImpl(
      {required this.email,
      required this.name,
      required this.comingTime,
      required this.leavingTime,
      required this.education,
      required this.speciality,
      this.profileImage = ""});

  factory _$DoctorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorModelImplFromJson(json);

  @override
  final String email;
  @override
  final String name;
  @override
  final String comingTime;
  @override
  final String leavingTime;
  @override
  final String education;
  @override
  final String speciality;
  @override
  @JsonKey()
  final String profileImage;

  @override
  String toString() {
    return 'DoctorModel(email: $email, name: $name, comingTime: $comingTime, leavingTime: $leavingTime, education: $education, speciality: $speciality, profileImage: $profileImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.comingTime, comingTime) ||
                other.comingTime == comingTime) &&
            (identical(other.leavingTime, leavingTime) ||
                other.leavingTime == leavingTime) &&
            (identical(other.education, education) ||
                other.education == education) &&
            (identical(other.speciality, speciality) ||
                other.speciality == speciality) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, name, comingTime,
      leavingTime, education, speciality, profileImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorModelImplCopyWith<_$DoctorModelImpl> get copyWith =>
      __$$DoctorModelImplCopyWithImpl<_$DoctorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorModelImplToJson(
      this,
    );
  }
}

abstract class _DoctorModel implements DoctorModel {
  const factory _DoctorModel(
      {required final String email,
      required final String name,
      required final String comingTime,
      required final String leavingTime,
      required final String education,
      required final String speciality,
      final String profileImage}) = _$DoctorModelImpl;

  factory _DoctorModel.fromJson(Map<String, dynamic> json) =
      _$DoctorModelImpl.fromJson;

  @override
  String get email;
  @override
  String get name;
  @override
  String get comingTime;
  @override
  String get leavingTime;
  @override
  String get education;
  @override
  String get speciality;
  @override
  String get profileImage;
  @override
  @JsonKey(ignore: true)
  _$$DoctorModelImplCopyWith<_$DoctorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
