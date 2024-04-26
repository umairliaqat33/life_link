import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

@freezed
class RequestModel with _$RequestModel {
  const factory RequestModel({
    required String requestId,
    required String requestTime,
    required String patientId,
    required double patientLat,
    required double patientLon,
    @Default("") String ambulanceDriverId,
    @Default("") String hospitalToBeTakeAtId,
    @Default("") String assignedBedNumber,
    @Default("") String assignedDoctorId,
  }) = _RequestModel;

  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);
}
