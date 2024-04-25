// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HospitalModelImpl _$$HospitalModelImplFromJson(Map<String, dynamic> json) =>
    _$HospitalModelImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      uid: json['uid'] as String,
      phoneNumber: json['phoneNumber'] as String? ?? "",
    );

Map<String, dynamic> _$$HospitalModelImplToJson(_$HospitalModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'address': instance.address,
      'uid': instance.uid,
      'phoneNumber': instance.phoneNumber,
    };
