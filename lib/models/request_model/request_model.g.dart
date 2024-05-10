// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestModelImpl _$$RequestModelImplFromJson(Map<String, dynamic> json) =>
    _$RequestModelImpl(
      requestId: json['requestId'] as String,
      requestTime: json['requestTime'] as String,
      patientId: json['patientId'] as String,
      patientLat: (json['patientLat'] as num).toDouble(),
      patientLon: (json['patientLon'] as num).toDouble(),
      bedAssigned: json['bedAssigned'] as String? ?? "",
      ambulanceDriverId: json['ambulanceDriverId'] as String? ?? "",
      hospitalToBeTakeAtId: json['hospitalToBeTakeAtId'] as String? ?? "",
      requestCompletionTime: json['requestCompletionTime'] as String? ?? "",
      customerReview: json['customerReview'] as String? ?? "",
    );

Map<String, dynamic> _$$RequestModelImplToJson(_$RequestModelImpl instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'requestTime': instance.requestTime,
      'patientId': instance.patientId,
      'patientLat': instance.patientLat,
      'patientLon': instance.patientLon,
      'bedAssigned': instance.bedAssigned,
      'ambulanceDriverId': instance.ambulanceDriverId,
      'hospitalToBeTakeAtId': instance.hospitalToBeTakeAtId,
      'requestCompletionTime': instance.requestCompletionTime,
      'customerReview': instance.customerReview,
    };
