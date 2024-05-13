// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportModelImpl _$$ReportModelImplFromJson(Map<String, dynamic> json) =>
    _$ReportModelImpl(
      reportId: json['reportId'] as String,
      patientID: json['patientID'] as String,
      hospitalId: json['hospitalId'] as String,
      doctorID: json['doctorID'] as String,
      prevention: json['prevention'] as String,
      dischargeTime: json['dischargeTime'] as String,
      diseaseTreated: json['diseaseTreated'] as String,
      requestId: json['requestId'] as String,
    );

Map<String, dynamic> _$$ReportModelImplToJson(_$ReportModelImpl instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
      'patientID': instance.patientID,
      'hospitalId': instance.hospitalId,
      'doctorID': instance.doctorID,
      'prevention': instance.prevention,
      'dischargeTime': instance.dischargeTime,
      'diseaseTreated': instance.diseaseTreated,
      'requestId': instance.requestId,
    };
