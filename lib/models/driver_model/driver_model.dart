import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_model.freezed.dart';
part 'driver_model.g.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    required String email,
    required String name,
    required String ambulanceRegistrationNo,
    required String uid,
    required String hospitalId,
    required String hospitalName,
    required String fcmToken,
    @Default("") String driverPassword,
    @Default("") String licenseNumber,
    @Default("") String profilePicture,
    @Default(true) bool isAvailable,
    @Default(false) bool isApproved,
  }) = _DriverModel;

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);
}
