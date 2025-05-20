import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model_netv.g.dart';

@JsonSerializable()
class CountryModelNetv extends Equatable {
  const CountryModelNetv({
    required this.id,
    required this.title,
    required this.code,
    required this.iso3,
    required this.phoneCode,
    this.mobilePhoneValidator,
  });

  factory CountryModelNetv.newModel() {
    return const CountryModelNetv(
      id: -1,
      title: '',
      code: 'GR',
      iso3: '',
      phoneCode: '30',
      mobilePhoneValidator: r'^69[0-9]{8}$',
    );
  }

  @override
  factory CountryModelNetv.fromJson(final Map<String, dynamic> json) => _$CountryModelNetvFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelNetvToJson(this);

  static List<CountryModelNetv> fromJsonList(final List<dynamic> json) =>
      List<Map<String, dynamic>>.from(json).map((Map<String, dynamic> item) => CountryModelNetv.fromJson(item)).toList();

  @JsonKey(name: 'Id')
  final int id;
  @JsonKey(name: 'Title')
  final String title;
  @JsonKey(name: 'Code')
  final String code;
  @JsonKey(name: 'Iso3')
  final String iso3;
  @JsonKey(name: 'PhoneCode')
  final String phoneCode;
  @JsonKey(name: 'MobilePhoneValidator')
  final String? mobilePhoneValidator;

  @override
  List<Object?> get props => <Object?>[id, title, code, iso3, phoneCode, mobilePhoneValidator];
}
