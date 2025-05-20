import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'src/core/enums/common_enums.dart';
import 'src/core/enums/language.dart' as language;
import 'src/core/utils/nullable.dart';
import 'src/data/models/country_model_netv/country_model_netv.dart';
import 'src/data/models/language.dart';
import 'src/data/models/translation_model.dart';
import 'src/data/repositories/common_data_repository.dart';
import 'src/services/network/api_response.dart';

part 'common_data_state.dart';

class CommonDataCubit extends HydratedCubit<CommonDataState> {
  CommonDataCubit._internal() : super(const CommonDataState());

  static final CommonDataCubit _singleton = CommonDataCubit._internal();

  static CommonDataCubit get instance => _singleton;

  Future<void> getSplashData() async {
    // final ApiResponse<List<SplashData>> response = await CommonDataRepository.instance.getSplashData();
    // if (response.success) {
    //   emit(state.copyWith(splashData: response.data));
    // }
  }

  Future<void> getLanguages() async {
    final ApiResponse<List<Language>> response = await CommonDataRepository.instance.getLanguages();
    if (response.success) {
      emit(state.copyWith(languages: response.data));
    }
  }

  void changeLanguage(Language language) {
    emit(state.copyWith(currentLanguage: Nullable<Language>(language)));
  }

  Future<Map<String, dynamic>?> getTextConstants(String translationsPath) async {
    final List<TranslationModel> translations = <TranslationModel>[];

    for (int i = 0; i < state.languages.length; i++) {
      final Language language = state.languages[i];
      final String filePath = '$translationsPath/${language.languageCode}-${language.countryCode}.json';
      final String response = await rootBundle.loadString(filePath);
      translations.add(TranslationModel(id: language.id, map: json.decode(response)));
    }

    final ApiResponse<Map<String, dynamic>> result = await CommonDataRepository.instance.getTextConstants();
    if (result.success) {
      return result.data;
    }
    return null;
  }

  Future<void> getCountryCodes() async {
    final ApiResponse<List<CountryModelNetv>> response = await CommonDataRepository.instance.getCountryCodes();
    if (response.success) {
      emit(
        state.copyWith(
          countryCodes: response.data,
          currentCountryCode: response.data?.firstWhere(
            (CountryModelNetv e) => e.code == language.Language.el.countryCode,
            orElse: () => CountryModelNetv.newModel(),
          ),
        ),
      );
    }
  }

  void showNoCompanyBottomSheet({required bool value}) {
    emit(state.copyWith(showNoCompanyBottomSheet: value));
  }

  Language getSystemLanguage() {
    final Locale systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    int id = 1;
    String name = 'ΕΛ';
    if (systemLocale.languageCode == 'en') {
      id = 2;
      name = 'EN';
    }
    return Language(
      id: id,
      name: name,
      culture: "${systemLocale.languageCode}-${systemLocale.countryCode}",
      isDefault: true,
    );
  }

  @override
  CommonDataState? fromJson(Map<String, dynamic> json) {
    try {
      return CommonDataState(
        languages: (json['languages'] as List<dynamic>).map((dynamic e) => Language.fromJson(e as Map<String, dynamic>)).toList(),
        currentLanguage: json['current_language'] == null ? null : Language.fromJson(json['current_language'] as Map<String, dynamic>),
        countryCodes: (json['country_codes'] as List<dynamic>).map((dynamic e) => CountryModelNetv.fromJson(e as Map<String, dynamic>)).toList(),
        currentCountryCode:
            json['current_country_code'] == null ? null : CountryModelNetv.fromJson(json['current_country_code'] as Map<String, dynamic>),
        showNoCompanyBottomSheet: json['show_no_company_bottom_sheet'] as bool,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CommonDataState state) {
    final Map<String, dynamic> result = <String, dynamic>{
      'languages': state.languages.map((Language e) => e.toJson()).toList(),
      'current_language': state.currentLanguage?.toJson(),
      'country_codes': state.countryCodes.map((CountryModelNetv e) => e.toJson()).toList(),
      'current_country_code': state.currentCountryCode?.toJson(),
      'show_no_company_bottom_sheet': state.showNoCompanyBottomSheet,
    };
    return result;
  }
}
