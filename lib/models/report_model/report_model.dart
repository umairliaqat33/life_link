import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    required String reportId,
    required String patientID,
    required String patientName,
    required String hospitalId,
    required String hospitalName,
    required String prevention,
    required String reportPdfLink,
    required String profileImage,
    required String dischargeTime,
  }) = _ReportModel;
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}
