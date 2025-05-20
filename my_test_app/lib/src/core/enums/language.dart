import 'package:flutter/material.dart';

import 'src/core/config/keys/locale_keys.dart';

enum Language {
  el,
  en,
}

extension LanguageExtension on Language {
  String get name {
    switch (this) {
      case Language.el:
        return LocaleKeys.greek.tr();
      case Language.en:
        return LocaleKeys.english.tr();
    }
  }

  String get nameShort {
    switch (this) {
      case Language.el:
        return LocaleKeys.gr.tr();
      case Language.en:
        return LocaleKeys.en.tr();
    }
  }

  Locale get locale {
    switch (this) {
      case Language.el:
        return Locale(languageCode, countryCode);
      case Language.en:
        return Locale(languageCode, countryCode);
    }
  }

  String get languageCode {
    switch (this) {
      case Language.el:
        return 'el';
      case Language.en:
        return 'en';
    }
  }

  String get countryCode {
    switch (this) {
      case Language.el:
        return 'GR';
      case Language.en:
        return 'US';
    }
  }
}

extension LanguageStringExtension on String {
  Language? get languageFromLocaleString {
    if (this == Language.el.languageCode) {
      return Language.el;
    } else if (this == Language.en.languageCode) {
      return Language.en;
    } else {
      return null;
    }
  }
}

extension LocaleExtension on Locale {
  String get getNetvolutionCode {
    switch (languageCode) {
      case "el":
        return '1';
      case "en":
        return '2';
      default:
        return "1";
    }
  }

  bool get isGreek => languageCode == "el";
}
