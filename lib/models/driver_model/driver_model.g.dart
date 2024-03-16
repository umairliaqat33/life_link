// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverModelImpl _$$DriverModelImplFromJson(Map<String, dynamic> json) =>
    _$DriverModelImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      uid: json['uid'] as String? ?? "",
      employeeId: json['employeeId'] as String? ?? "",
      licenseBack: json['licenseBack'] as String? ?? "",
      licenseFront: json['licenseFront'] as String? ?? "",
    );

Map<String, dynamic> _$$DriverModelImplToJson(_$DriverModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'uid': instance.uid,
      'employeeId': instance.employeeId,
      'licenseBack': instance.licenseBack,
      'licenseFront': instance.licenseFront,
    };
