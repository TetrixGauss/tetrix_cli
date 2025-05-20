// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model_netv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModelNetv _$CountryModelNetvFromJson(Map<String, dynamic> json) =>
    CountryModelNetv(
      id: (json['Id'] as num).toInt(),
      title: json['Title'] as String,
      code: json['Code'] as String,
      iso3: json['Iso3'] as String,
      phoneCode: json['PhoneCode'] as String,
      mobilePhoneValidator: json['MobilePhoneValidator'] as String?,
    );

Map<String, dynamic> _$CountryModelNetvToJson(CountryModelNetv instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Code': instance.code,
      'Iso3': instance.iso3,
      'PhoneCode': instance.phoneCode,
      'MobilePhoneValidator': instance.mobilePhoneValidator,
    };
