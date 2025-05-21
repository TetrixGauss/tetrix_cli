import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:{{name}}/src/core/constants/app_constants.dart';
import 'package:{{name}}/src/cubits/common_data_cubit/common_data_cubit.dart';

class TranslationsLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    final Map<String, dynamic>? translation = await CommonDataCubit.instance.getTextConstants(path);
    if (translation?.isEmpty ?? false) {
      return getBackupTranslations(locale);
    }
    return translation;
  }

  Future<Map<String, dynamic>> getBackupTranslations(Locale locale) async {
    return jsonDecode(await rootBundle.loadString('${SoulfoodCoreConstants.translationsPath}/${locale.languageCode}-${locale.countryCode}.json'));
  }
}
