import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_model.freezed.dart';
part 'patient_model.g.dart';

@freezed
class PatientModel with _$PatientModel {
  const factory PatientModel({
    required String email,
    required String name,
    @Default("") String uid,
    @Default(0) int age,
    @Default("") String cnic,
    @Default("") String disease,
    @Default("") String gender,
    @Default("") String phoneNumber,
  }) = _PatientModel;

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
}
