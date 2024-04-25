import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_model.freezed.dart';
part 'driver_model.g.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    required String email,
    required String name,
    required int age,
    required String uid,
    @Default("") String licenseNumber,
    @Default("") String employeeId,
  }) = _DriverModel;

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);
}
