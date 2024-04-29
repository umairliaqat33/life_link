// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverModelImpl _$$DriverModelImplFromJson(Map<String, dynamic> json) =>
    _$DriverModelImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      ambulanceId: json['ambulanceId'] as String,
      ambulanceRegistrationNo: json['ambulanceRegistrationNo'] as String,
      uid: json['uid'] as String,
      hospitalId: json['hospitalId'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
      licenseNumber: json['licenseNumber'] as String? ?? "",
    );

Map<String, dynamic> _$$DriverModelImplToJson(_$DriverModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'ambulanceId': instance.ambulanceId,
      'ambulanceRegistrationNo': instance.ambulanceRegistrationNo,
      'uid': instance.uid,
      'hospitalId': instance.hospitalId,
      'isAvailable': instance.isAvailable,
      'licenseNumber': instance.licenseNumber,
    };
