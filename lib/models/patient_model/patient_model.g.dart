// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientModelImpl _$$PatientModelImplFromJson(Map<String, dynamic> json) =>
    _$PatientModelImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      uid: json['uid'] as String? ?? "",
      age: json['age'] as int? ?? 0,
      cnic: json['cnic'] as String? ?? "",
      disease: json['disease'] as String? ?? "",
      gender: json['gender'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
    );

Map<String, dynamic> _$$PatientModelImplToJson(_$PatientModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'uid': instance.uid,
      'age': instance.age,
      'cnic': instance.cnic,
      'disease': instance.disease,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
    };
