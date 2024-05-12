// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportModelImpl _$$ReportModelImplFromJson(Map<String, dynamic> json) =>
    _$ReportModelImpl(
      reportId: json['reportId'] as String,
      patientID: json['patientID'] as String,
      patientName: json['patientName'] as String,
      hospitalId: json['hospitalId'] as String,
      hospitalName: json['hospitalName'] as String,
      prevention: json['prevention'] as String,
      reportPdfLink: json['reportPdfLink'] as String,
      profileImage: json['profileImage'] as String,
      dischargeTime: json['dischargeTime'] as String,
    );

Map<String, dynamic> _$$ReportModelImplToJson(_$ReportModelImpl instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
      'patientID': instance.patientID,
      'patientName': instance.patientName,
      'hospitalId': instance.hospitalId,
      'hospitalName': instance.hospitalName,
      'prevention': instance.prevention,
      'reportPdfLink': instance.reportPdfLink,
      'profileImage': instance.profileImage,
      'dischargeTime': instance.dischargeTime,
    };
