// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      id: (json['ID'] as num).toInt(),
      name: json['Name'] as String,
      culture: json['Culture'] as String,
      isDefault: json['IsDefault'] as bool,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'Culture': instance.culture,
      'IsDefault': instance.isDefault,
    };
