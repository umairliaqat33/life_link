import 'package:freezed_annotation/freezed_annotation.dart';

part 'uid_model.freezed.dart';
part 'uid_model.g.dart';

@freezed
class UIDModel with _$UIDModel {
  const factory UIDModel({
    required String uid,
  }) = _UIDModel;
  factory UIDModel.fromJson(Map<String, dynamic> json) =>
      _$UIDModelFromJson(json);
}
