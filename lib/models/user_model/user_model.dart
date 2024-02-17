import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String businessName;
  String email;
  String? uid;
  String? profileImage;

  UserModel({
    required this.email,
    required this.businessName,
    this.uid,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
