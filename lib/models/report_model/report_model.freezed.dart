// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) {
  return _ReportModel.fromJson(json);
}

/// @nodoc
mixin _$ReportModel {
  String get reportId => throw _privateConstructorUsedError;
  String get patientID => throw _privateConstructorUsedError;
  String get hospitalId => throw _privateConstructorUsedError;
  String get doctorID => throw _privateConstructorUsedError;
  String get prevention => throw _privateConstructorUsedError;
  String get dischargeTime => throw _privateConstructorUsedError;
  String get diseaseTreated => throw _privateConstructorUsedError;
  String get requestId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportModelCopyWith<ReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportModelCopyWith<$Res> {
  factory $ReportModelCopyWith(
          ReportModel value, $Res Function(ReportModel) then) =
      _$ReportModelCopyWithImpl<$Res, ReportModel>;
  @useResult
  $Res call(
      {String reportId,
      String patientID,
      String hospitalId,
      String doctorID,
      String prevention,
      String dischargeTime,
      String diseaseTreated,
      String requestId});
}

/// @nodoc
class _$ReportModelCopyWithImpl<$Res, $Val extends ReportModel>
    implements $ReportModelCopyWith<$Res> {
  _$ReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportId = null,
    Object? patientID = null,
    Object? hospitalId = null,
    Object? doctorID = null,
    Object? prevention = null,
    Object? dischargeTime = null,
    Object? diseaseTreated = null,
    Object? requestId = null,
  }) {
    return _then(_value.copyWith(
      reportId: null == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      patientID: null == patientID
          ? _value.patientID
          : patientID // ignore: cast_nullable_to_non_nullable
              as String,
      hospitalId: null == hospitalId
          ? _value.hospitalId
          : hospitalId // ignore: cast_nullable_to_non_nullable
              as String,
      doctorID: null == doctorID
          ? _value.doctorID
          : doctorID // ignore: cast_nullable_to_non_nullable
              as String,
      prevention: null == prevention
          ? _value.prevention
          : prevention // ignore: cast_nullable_to_non_nullable
              as String,
      dischargeTime: null == dischargeTime
          ? _value.dischargeTime
          : dischargeTime // ignore: cast_nullable_to_non_nullable
              as String,
      diseaseTreated: null == diseaseTreated
          ? _value.diseaseTreated
          : diseaseTreated // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportModelImplCopyWith<$Res>
    implements $ReportModelCopyWith<$Res> {
  factory _$$ReportModelImplCopyWith(
          _$ReportModelImpl value, $Res Function(_$ReportModelImpl) then) =
      __$$ReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String reportId,
      String patientID,
      String hospitalId,
      String doctorID,
      String prevention,
      String dischargeTime,
      String diseaseTreated,
      String requestId});
}

/// @nodoc
class __$$ReportModelImplCopyWithImpl<$Res>
    extends _$ReportModelCopyWithImpl<$Res, _$ReportModelImpl>
    implements _$$ReportModelImplCopyWith<$Res> {
  __$$ReportModelImplCopyWithImpl(
      _$ReportModelImpl _value, $Res Function(_$ReportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportId = null,
    Object? patientID = null,
    Object? hospitalId = null,
    Object? doctorID = null,
    Object? prevention = null,
    Object? dischargeTime = null,
    Object? diseaseTreated = null,
    Object? requestId = null,
  }) {
    return _then(_$ReportModelImpl(
      reportId: null == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      patientID: null == patientID
          ? _value.patientID
          : patientID // ignore: cast_nullable_to_non_nullable
              as String,
      hospitalId: null == hospitalId
          ? _value.hospitalId
          : hospitalId // ignore: cast_nullable_to_non_nullable
              as String,
      doctorID: null == doctorID
          ? _value.doctorID
          : doctorID // ignore: cast_nullable_to_non_nullable
              as String,
      prevention: null == prevention
          ? _value.prevention
          : prevention // ignore: cast_nullable_to_non_nullable
              as String,
      dischargeTime: null == dischargeTime
          ? _value.dischargeTime
          : dischargeTime // ignore: cast_nullable_to_non_nullable
              as String,
      diseaseTreated: null == diseaseTreated
          ? _value.diseaseTreated
          : diseaseTreated // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportModelImpl implements _ReportModel {
  const _$ReportModelImpl(
      {required this.reportId,
      required this.patientID,
      required this.hospitalId,
      required this.doctorID,
      required this.prevention,
      required this.dischargeTime,
      required this.diseaseTreated,
      required this.requestId});

  factory _$ReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportModelImplFromJson(json);

  @override
  final String reportId;
  @override
  final String patientID;
  @override
  final String hospitalId;
  @override
  final String doctorID;
  @override
  final String prevention;
  @override
  final String dischargeTime;
  @override
  final String diseaseTreated;
  @override
  final String requestId;

  @override
  String toString() {
    return 'ReportModel(reportId: $reportId, patientID: $patientID, hospitalId: $hospitalId, doctorID: $doctorID, prevention: $prevention, dischargeTime: $dischargeTime, diseaseTreated: $diseaseTreated, requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportModelImpl &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.patientID, patientID) ||
                other.patientID == patientID) &&
            (identical(other.hospitalId, hospitalId) ||
                other.hospitalId == hospitalId) &&
            (identical(other.doctorID, doctorID) ||
                other.doctorID == doctorID) &&
            (identical(other.prevention, prevention) ||
                other.prevention == prevention) &&
            (identical(other.dischargeTime, dischargeTime) ||
                other.dischargeTime == dischargeTime) &&
            (identical(other.diseaseTreated, diseaseTreated) ||
                other.diseaseTreated == diseaseTreated) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, reportId, patientID, hospitalId,
      doctorID, prevention, dischargeTime, diseaseTreated, requestId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      __$$ReportModelImplCopyWithImpl<_$ReportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportModelImplToJson(
      this,
    );
  }
}

abstract class _ReportModel implements ReportModel {
  const factory _ReportModel(
      {required final String reportId,
      required final String patientID,
      required final String hospitalId,
      required final String doctorID,
      required final String prevention,
      required final String dischargeTime,
      required final String diseaseTreated,
      required final String requestId}) = _$ReportModelImpl;

  factory _ReportModel.fromJson(Map<String, dynamic> json) =
      _$ReportModelImpl.fromJson;

  @override
  String get reportId;
  @override
  String get patientID;
  @override
  String get hospitalId;
  @override
  String get doctorID;
  @override
  String get prevention;
  @override
  String get dischargeTime;
  @override
  String get diseaseTreated;
  @override
  String get requestId;
  @override
  @JsonKey(ignore: true)
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
