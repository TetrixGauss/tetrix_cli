import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    required this.userID,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.psycologyLine,
    required this.nutritionLine,
    required this.companyName,
    required this.companyId,
  });

  @override
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  static List<UserModel> fromJsonList(final List<dynamic> json) =>
      List<Map<String, dynamic>>.from(json).map((Map<String, dynamic> item) => UserModel.fromJson(item)).toList();

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @JsonKey(name: 'userID')
  final int userID;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'fullName')
  final String? fullName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'companyID')
  final int? companyId;

  @JsonKey(name: 'CompanyName')
  final String? companyName;

  @JsonKey(name: 'psycologyLine')
  final bool? psycologyLine;

  @JsonKey(name: 'nutritionLine')
  final bool? nutritionLine;

  @override
  List<Object?> get props => <Object?>[
        userID,
        userName,
        fullName,
        email,
        companyId,
        companyName,
        psycologyLine,
        nutritionLine,
      ];
}
