// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BedsModelImpl _$$BedsModelImplFromJson(Map<String, dynamic> json) =>
    _$BedsModelImpl(
      bedId: (json['bedId'] as num).toInt(),
      hospitalId: json['hospitalId'] as String,
      isAvailable: json['isAvailable'] as bool? ?? false,
    );

Map<String, dynamic> _$$BedsModelImplToJson(_$BedsModelImpl instance) =>
    <String, dynamic>{
      'bedId': instance.bedId,
      'hospitalId': instance.hospitalId,
      'isAvailable': instance.isAvailable,
    };
