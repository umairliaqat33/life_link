// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      userType: json['userType'] as String,
      uid: json['uid'] as String? ?? "",
      profileImage: json['profileImage'] as String? ?? "",
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'userType': instance.userType,
      'uid': instance.uid,
      'profileImage': instance.profileImage,
    };
