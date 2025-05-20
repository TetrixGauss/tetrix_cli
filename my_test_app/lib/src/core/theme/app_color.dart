part of 'app_theme.dart';

class AppColor {
  //Wireframe Level Colors
  static const Color primary = Color(0xFFFFCC00);
  static const Color secondary = Color(0xFF2175B8);
  static const Color error = Color(0xffF5222D);
  static const Color black = Color(0xff000000);
  static const Color black90 = Color(0xff1A1A1A);
  static const Color black75 = Color(0xff404040);
  static const Color black50 = Color(0xff808080);
  static const Color black30 = Color(0xffB3B3B3);
  static const Color black20 = Color(0xffCCCCCC);
  static const Color disabled = Color(0xffb3b3b3);

  static const Color lightGrey = Color(0xffD4D4D4);
  static const Color introductionGrey = Color(0xFFD9D9D9);
  static const Color backgroundGrey2 = Color(0xffF6F6F6);
  static const Color backgroundGrey3 = Color(0xffFAFAFA);
  static const Color midGrey = Color(0xff666666);
  static const Color midGrey2 = Color(0xff959595);
  static const Color midGrey3 = Color(0xffc4c4c4);
  static const Color darkGrey = Color(0xff525252);
  static const Color hyperLinkBlue = Color(0xff2F80ED);
  static const Color darkGrey2 = Color(0xff525252);

  static const Color negativeRed = Color(0xffEB5757);
  static const Color positiveGreen = Color(0xff56C568);

  static const Color inactiveElement = Color(0xffDBDBDB);
  static const Color filledButtonBackground = Color(0xff525252);

  static const Color primaryTextColor = Color(0xff2F1A76);
  static const Color secondaryTextColor = Color(0xff7A3B01);

  //Brand Primary Color
  static const Color brandPrimary050 = Color(0xffEFEBFD);
  static const Color brandPrimary100 = Color(0xffdfd6fb);
  static const Color brandPrimary200 = Color(0xffcabbf9);
  static const Color brandPrimary400 = Color(0xff9478f3);
  static const Color brandPrimary550 = Color(0xff5F34ED);
  static const Color brandPrimary600 = Color(0xff4F2BC5);
  static const Color brandPrimary700 = Color(0xff3F239E);
  static const Color brandPrimary800 = Color(0xff301A77);

  //Brand Accent Color
  static const Color brandAccent050 = Color(0xffFEF1E6);
  static const Color brandAccent400 = Color(0xfff8a456);
  static const Color brandAccent500 = Color(0xfff78e2c);
  static const Color brandAccent550 = Color(0xfff57702);
  static const Color brandAccent600 = Color(0xffcc6302);
  static const Color brandAccent800 = Color(0xff7b3c01);
  static const Color brandAccent900 = Color(0xff522801);

  //Brand Secondary Color
  static const Color brandSecondary050 = Color(0xffE6F9F2);
  static const Color brandSecondary100 = Color(0xffccf2e5);
  static const Color brandSecondary400 = Color(0xff55d4a8);
  static const Color brandSecondary550 = Color(0xff00bf7c);
  static const Color brandSecondary600 = Color(0xff009f67);
  static const Color brandSecondary900 = Color(0xff004029);

  //Neutrals
  static const Color neutrals000 = Color(0xffffffff);
  static const Color neutrals050 = Color(0xffF4F3F6);
  static const Color neutrals100 = Color(0xffE9E7ED);
  static const Color neutrals400 = Color(0xffA6A0B9);
  static const Color neutrals500 = Color(0xff8F88A7);
  static const Color neutrals600 = Color(0xff797095);
  static const Color neutrals800 = Color(0xff4D4172);

  //Messages
  static const Color actionErrorWarning050 = Color(0xffFEECEC);
  static const Color actionErrorWarning600 = Color(0xffCC3538);
  static const Color actionErrorWarning800 = Color(0xff7B2022);

  static const Color actionSuccess050 = Color(0xffE6F4EE);
  static const Color actionSuccess800 = Color(0xff014A2B);

  //Gradients

  static Color bottomSheetOverlay = const Color(0xff301A77).withOpacity(0.6);
  static Color bottomSheetOverlayNoOpacity = const Color(0xff301A77);

  //brand
  static const LinearGradient gradientBrandAccentLight = LinearGradient(
    colors: <Color>[brandAccent050, brandAccent400],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient gradientBrandPrimaryToAccent = LinearGradient(
    colors: <Color>[const Color(0xffFED5B2), const Color(0xffEBE6FD), const Color(0xffDFD6FB).withOpacity(0.8)],
    stops: <double>[0, 0.6, 1],
  );

  //illustrations
  static const LinearGradient gradientIllustrationPrimary = LinearGradient(
    colors: <Color>[brandPrimary200, brandPrimary400],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradientIllustrationAccent = LinearGradient(
    colors: <Color>[brandAccent400, brandAccent500],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradientIllustrationSecondary = LinearGradient(
    colors: <Color>[brandSecondary100, brandSecondary400],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  //backgrounds
  static const LinearGradient gradientPageBackgroundMain = LinearGradient(
    colors: <Color>[neutrals000, brandAccent050, brandPrimary050],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: <double>[0, 0.6, 1],
  );

  static const LinearGradient gradientPageBackgroundMainHorizontal = LinearGradient(
    colors: <Color>[neutrals000, brandAccent050, brandPrimary050],
    stops: <double>[0, 0.6, 1],
  );

  static const LinearGradient gradientPageBackgroundWalkthrough = LinearGradient(
    colors: <Color>[brandAccent050, brandPrimary050],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: <double>[0.3, 1],
  );

  static const LinearGradient gradientPageBackgroundPrimary = LinearGradient(
    colors: <Color>[neutrals000, brandPrimary050],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradientPageBackgroundAccent = LinearGradient(
    colors: <Color>[neutrals000, brandAccent050],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradientPageBackgroundSecondary = LinearGradient(
    colors: <Color>[neutrals000, brandSecondary050],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  //Overlays
  static const LinearGradient gradientOverlayBottomSheet = LinearGradient(
    colors: <Color>[brandAccent800, brandPrimary800],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: <double>[0.4, 1],
  );

  //Sticky Elements
  static LinearGradient gradientStickyElementsWhite96 = LinearGradient(
    colors: <Color>[neutrals000, neutrals000.withOpacity(0.96)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient gradientStickyElementsWhiteTopNavBar = LinearGradient(
    colors: <Color>[neutrals000, neutrals000.withOpacity(0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient gradientStickyElementsWhiteCTA = LinearGradient(
    colors: <Color>[
      neutrals000.withOpacity(0.4),
      neutrals000,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  //Sticky elements?

  //Gradient
  static LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const <double>[0, 0.4],
    colors: <Color>[
      AppColor.brandAccent800.withOpacity(0.5),
      AppColor.brandPrimary800.withOpacity(0.5),
    ],
  );
}
