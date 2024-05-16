// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      notificationId: json['notificationId'] as String,
      fromId: json['fromId'] as String,
      toId: json['toId'] as String,
      message: json['message'] as String,
      title: json['title'] as String,
      notificationTime: json['notificationTime'] as String,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'fromId': instance.fromId,
      'toId': instance.toId,
      'message': instance.message,
      'title': instance.title,
      'notificationTime': instance.notificationTime,
    };
