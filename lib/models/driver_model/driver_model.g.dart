// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverModelImpl _$$DriverModelImplFromJson(Map<String, dynamic> json) =>
    _$DriverModelImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      ambulanceRegistrationNo: json['ambulanceRegistrationNo'] as String,
      uid: json['uid'] as String,
      hospitalId: json['hospitalId'] as String,
      hospitalName: json['hospitalName'] as String,
      licenseNumber: json['licenseNumber'] as String? ?? "",
      profilePicture: json['profilePicture'] as String? ?? "",
      isAvailable: json['isAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$$DriverModelImplToJson(_$DriverModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'ambulanceRegistrationNo': instance.ambulanceRegistrationNo,
      'uid': instance.uid,
      'hospitalId': instance.hospitalId,
      'hospitalName': instance.hospitalName,
      'licenseNumber': instance.licenseNumber,
      'profilePicture': instance.profilePicture,
      'isAvailable': instance.isAvailable,
    };
