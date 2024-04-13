// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorModelImpl _$$DoctorModelImplFromJson(Map<String, dynamic> json) =>
    _$DoctorModelImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      comingTime: json['comingTime'] as String,
      leavingTime: json['leavingTime'] as String,
      education: json['education'] as String,
      speciality: json['speciality'] as String,
      profileImage: json['profileImage'] as String? ?? "",
    );

Map<String, dynamic> _$$DoctorModelImplToJson(_$DoctorModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'comingTime': instance.comingTime,
      'leavingTime': instance.leavingTime,
      'education': instance.education,
      'speciality': instance.speciality,
      'profileImage': instance.profileImage,
    };
