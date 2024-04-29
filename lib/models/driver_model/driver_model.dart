import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_model.freezed.dart';
part 'driver_model.g.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    required String email,
    required String name,
    required String ambulanceId,
    required String ambulanceRegistrationNo,
    required String uid,
    required String hospitalId,
    @Default(true) bool isAvailable,
    @Default("") String licenseNumber,
  }) = _DriverModel;

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);
}
