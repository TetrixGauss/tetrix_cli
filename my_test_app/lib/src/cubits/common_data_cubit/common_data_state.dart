part of 'common_data_cubit.dart';

class CommonDataState extends Equatable {
  const CommonDataState({
    this.status = CommonDataStatus.init,
    this.currentLanguage,
    this.languages = const <Language>[],
    this.countryCodes = const <CountryModelNetv>[],
    this.currentCountryCode,
    this.showNoCompanyBottomSheet = true,
  });

  final CommonDataStatus status;
  final Language? currentLanguage;
  final List<Language> languages;
  final List<CountryModelNetv> countryCodes;
  final CountryModelNetv? currentCountryCode;
  final bool showNoCompanyBottomSheet;

  CommonDataState copyWith({
    CommonDataStatus? status,
    Nullable<Language?>? currentLanguage,
    List<Language>? languages,
    List<CountryModelNetv>? countryCodes,
    CountryModelNetv? currentCountryCode,
    bool? showNoCompanyBottomSheet,
  }) {
    return CommonDataState(
      status: status ?? this.status,
      currentLanguage: currentLanguage == null ? this.currentLanguage : currentLanguage.value,
      languages: languages ?? this.languages,
      countryCodes: countryCodes ?? this.countryCodes,
      currentCountryCode: currentCountryCode ?? this.currentCountryCode,
      showNoCompanyBottomSheet: showNoCompanyBottomSheet ?? this.showNoCompanyBottomSheet,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        currentLanguage,
        languages,
        countryCodes,
        currentCountryCode,
        showNoCompanyBottomSheet,
      ];
}
