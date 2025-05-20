// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userID: (json['userID'] as num).toInt(),
      userName: json['userName'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      psycologyLine: json['psycologyLine'] as bool?,
      nutritionLine: json['nutritionLine'] as bool?,
      companyName: json['CompanyName'] as String?,
      companyId: (json['companyID'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userID': instance.userID,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'email': instance.email,
      'companyID': instance.companyId,
      'CompanyName': instance.companyName,
      'psycologyLine': instance.psycologyLine,
      'nutritionLine': instance.nutritionLine,
    };
