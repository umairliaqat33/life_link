import 'package:freezed_annotation/freezed_annotation.dart';

part 'bed_model.freezed.dart';
part 'bed_model.g.dart';

@freezed
class BedModel with _$BedModel {
  const factory BedModel({
    required int bedId,
    required String hospitalId,
    @Default(false) bool isAvailable,
  }) = _BedsModel;
  factory BedModel.fromJson(Map<String, dynamic> json) =>
      _$BedModelFromJson(json);
}
