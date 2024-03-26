// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverModelImpl _$$DriverModelImplFromJson(Map<String, dynamic> json) =>
    _$DriverModelImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      uid: json['uid'] as String? ?? "",
      licenseNumber: json['licenseNumber'] as String? ?? "",
      employeeId: json['employeeId'] as String? ?? "",
      licenseBack: json['licenseBack'] as String? ?? "",
      licenseFront: json['licenseFront'] as String? ?? "",
    );

Map<String, dynamic> _$$DriverModelImplToJson(_$DriverModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'age': instance.age,
      'uid': instance.uid,
      'licenseNumber': instance.licenseNumber,
      'employeeId': instance.employeeId,
      'licenseBack': instance.licenseBack,
      'licenseFront': instance.licenseFront,
    };
