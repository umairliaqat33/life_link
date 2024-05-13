import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    required String reportId,
    required String patientID,
    required String hospitalId,
    required String doctorID,
    required String prevention,
    required String dischargeTime,
    required String diseaseTreated,
    required String requestId,
  }) = _ReportModel;
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}
