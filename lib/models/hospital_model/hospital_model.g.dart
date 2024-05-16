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
      hospitalLat: (json['hospitalLat'] as num).toDouble(),
      hospitalLon: (json['hospitalLon'] as num).toDouble(),
      fcmToken: json['fcmToken'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profilePicture: json['profilePicture'] as String,
      isApproved: json['isApproved'] as bool? ?? false,
    );

Map<String, dynamic> _$$HospitalModelImplToJson(_$HospitalModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'address': instance.address,
      'uid': instance.uid,
      'hospitalLat': instance.hospitalLat,
      'hospitalLon': instance.hospitalLon,
      'fcmToken': instance.fcmToken,
      'phoneNumber': instance.phoneNumber,
      'profilePicture': instance.profilePicture,
      'isApproved': instance.isApproved,
    };
