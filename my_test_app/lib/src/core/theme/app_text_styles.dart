part of 'app_theme.dart';

class AppTextStyle {
  /////////////////////////////////////

  static const String defaultFontFamily = 'Roboto';
  static const String geologicaFontFamily = 'Geologica';
  static const String barnebokFontFamily = 'Barnebok';

  //Display
  static const TextStyle displayLargeBold = TextStyle(fontFamily: barnebokFontFamily, fontWeight: FontWeight.bold, fontSize: 28, height: 1.14);
  static const TextStyle displayMediumBold = TextStyle(fontFamily: barnebokFontFamily, fontWeight: FontWeight.bold, fontSize: 24, height: 1.33);
  static const TextStyle displaySmallBold = TextStyle(fontFamily: barnebokFontFamily, fontWeight: FontWeight.bold, fontSize: 20, height: 1.4);

  //Headings
  static const TextStyle headingMediumSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 18, height: 1.45);
  static const TextStyle headingMediumLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 18, height: 1.45);
  static const TextStyle headingSmallSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 16, height: 1.5);
  static const TextStyle headingSmallLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 16, height: 1.5);
  static const TextStyle headingExtraSmallSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 14, height: 1.28);

  //Body
  static const TextStyle bodyMediumSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 16, height: 1.5);
  static const TextStyle bodyMediumLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 16, height: 1.5);
  static const TextStyle bodySmallLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 14, height: 1.28);
  static const TextStyle bodyExtraSmallSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 12, height: 1.33);
  static const TextStyle bodyExtraSmallLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 12, height: 1.33);
  static const TextStyle bodyExtraSmallLightStrikethrough =
      TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.normal, fontSize: 12, height: 1.33, decoration: TextDecoration.lineThrough);

  //Control-Links
  static const TextStyle linksMediumSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 16, height: 1.5);
  static const TextStyle linksMediumLightUnderline =
      TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 16, height: 1.5, decoration: TextDecoration.underline);
  static const TextStyle linksSmallSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 14, height: 1.28);
  static const TextStyle linksSmallSemiUnderline = TextStyle(
    fontFamily: geologicaFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.28,
    decoration: TextDecoration.underline,
    decorationThickness: 5,
  );
  static const TextStyle linksSmallLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 14, height: 1.28);
  static const TextStyle linksSmallLightUnderline = TextStyle(
    fontFamily: geologicaFontFamily,
    fontWeight: FontWeight.w300,
    fontSize: 14,
    height: 1.28,
    decoration: TextDecoration.underline,
    decorationThickness: 2,
  );
  static const TextStyle linksExtraSmallSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 11, height: 1.45);
  static const TextStyle linksExtraSmallLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 11, height: 1.45);

  //Labels
  static const TextStyle labelMediumSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 16, height: 1.5);
  static const TextStyle labelMediumLight =
      TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 16, height: 1.5, decoration: TextDecoration.underline);
  static const TextStyle labelSmallSemi = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w600, fontSize: 14, height: 1.28);
  static const TextStyle labelSmallLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 14, height: 1.28);
  static const TextStyle labelExtraSmallLight = TextStyle(fontFamily: geologicaFontFamily, fontWeight: FontWeight.w300, fontSize: 12, height: 1.33);

  /// Comment these sample styles and replace or errors with the appropriate finalised UI textStyle
  // static const TextStyle regular12 = TextStyle(fontFamily: defaultFontFamily, fontSize: 12, fontWeight: FontWeight.w400, height: 1.4);
  // static const TextStyle regular14 = TextStyle(fontFamily: defaultFontFamily, fontSize: 14, fontWeight: FontWeight.w400, height: 1.4);
  // static const TextStyle regular16 = TextStyle(fontFamily: defaultFontFamily, fontSize: 16, fontWeight: FontWeight.w400, height: 1.4);
  // static const TextStyle regular18 = TextStyle(fontFamily: defaultFontFamily, fontSize: 18, fontWeight: FontWeight.w400, height: 1.4);
  // static const TextStyle regular20 = TextStyle(fontFamily: defaultFontFamily, fontSize: 20, fontWeight: FontWeight.w400, height: 1.4);

  // static const TextStyle medium22 = TextStyle(fontFamily: defaultFontFamily, fontSize: 22, fontWeight: FontWeight.w500, height: 1.4);
  // static const TextStyle medium20 = TextStyle(fontFamily: defaultFontFamily, fontSize: 20, fontWeight: FontWeight.w500, height: 1.4);
  // static const TextStyle medium18 = TextStyle(fontFamily: defaultFontFamily, fontSize: 18, fontWeight: FontWeight.w500, height: 1.4);
  // static const TextStyle medium16 = TextStyle(fontFamily: defaultFontFamily, fontSize: 16, fontWeight: FontWeight.w500, height: 1.4);
  // static const TextStyle medium14 = TextStyle(fontFamily: defaultFontFamily, fontSize: 14, fontWeight: FontWeight.w500, height: 1.4);

  // static const TextStyle bold14 = TextStyle(fontFamily: defaultFontFamily, fontSize: 14, fontWeight: FontWeight.w600, height: 1.6);
  // static const TextStyle bold16 = TextStyle(fontFamily: defaultFontFamily, fontSize: 16, fontWeight: FontWeight.w600, height: 1.6);
  // static const TextStyle bold18 = TextStyle(fontFamily: defaultFontFamily, fontSize: 18, fontWeight: FontWeight.w600, height: 1.6);
  // static const TextStyle bold20 = TextStyle(fontFamily: defaultFontFamily, fontSize: 20, fontWeight: FontWeight.w600, height: 1.6);
  // static const TextStyle bold24 = TextStyle(fontFamily: defaultFontFamily, fontSize: 24, fontWeight: FontWeight.w600, height: 1.6);

  static double getFontSize(double screenWidth) {
    if (screenWidth <= 320) {
      return 8; // font size for screens with width 320 or less
    } else if (screenWidth <= 375) {
      return 10; // font size for screens with width between 321 and 375
    } else if (screenWidth <= 414) {
      return 12; // font size for screens with width between 376 and 414
    } else {
      return 14; // font size for screens with width 415 or more
    }
  }
}
