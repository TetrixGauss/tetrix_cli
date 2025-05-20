import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language extends Equatable {
  Language({
    required this.id,
    required this.name,
    required this.culture,
    required this.isDefault,
  })  : languageCode = culture.split('-')[0],
        countryCode = culture.split('-')[1];

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

  static List<Language> fromJsonList(final List<dynamic> json) =>
      List<Map<String, dynamic>>.from(json).map((Map<String, dynamic> item) => Language.fromJson(item)).toList();

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  Locale toLocale() => Locale(languageCode, countryCode);

  @JsonKey(name: 'ID')
  final int id;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Culture')
  final String culture;
  @JsonKey(name: 'IsDefault')
  final bool isDefault;

  final String languageCode;
  final String countryCode;

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        culture,
        isDefault,
        languageCode,
        countryCode,
      ];
}
