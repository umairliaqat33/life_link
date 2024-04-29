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
      phoneNumber: json['phoneNumber'] as String? ?? "",
      totalBeds: (json['totalBeds'] as num?)?.toInt() ?? 0,
      availableBeds: (json['availableBeds'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$HospitalModelImplToJson(_$HospitalModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'address': instance.address,
      'uid': instance.uid,
      'hospitalLat': instance.hospitalLat,
      'hospitalLon': instance.hospitalLon,
      'phoneNumber': instance.phoneNumber,
      'totalBeds': instance.totalBeds,
      'availableBeds': instance.availableBeds,
    };
