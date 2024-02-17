// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      businessName: json['businessName'] as String,
      uid: json['uid'] as String?,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'businessName': instance.businessName,
      'email': instance.email,
      'uid': instance.uid,
      'profileImage': instance.profileImage,
    };
