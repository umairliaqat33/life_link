import 'package:freezed_annotation/freezed_annotation.dart';

part 'hospital_model.freezed.dart';
part 'hospital_model.g.dart';

@freezed
class HospitalModel with _$HospitalModel {
  const factory HospitalModel({
    required String email,
    required String name,
    required String address,
    required String uid,
    required double hospitalLat,
    required double hospitalLon,
    required String fcmToken,
    required String phoneNumber,
    required String profilePicture,
    @Default(false) bool isApproved,
  }) = _HospitalModel;

  factory HospitalModel.fromJson(Map<String, dynamic> json) =>
      _$HospitalModelFromJson(json);
}
