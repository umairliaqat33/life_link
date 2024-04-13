import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
    required String email,
    required String name,
    required String comingTime,
    required String leavingTime,
    required String education,
    required String speciality,
    @Default("") String profileImage,
  }) = _DoctorModel;
  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);
}
