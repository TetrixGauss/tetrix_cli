import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'app_color.dart';
part 'app_text_styles.dart';

class AppTheme {
  static const double space = 8;
  static const double sizeExtraSmall = space * .5;
  static const double sizeSmall = space;
  static const double sizeMedium = space * 2;
  static const double sizeLarge = space * 3;
  static const double sizeExtraLarge = space * 4;
  static const double sizeXExtraLarge = space * 5;
  static const double sizeXXExtraLarge = space * 6;
  static const double sizeXXXExtraLarge = space * 7;

  static const EdgeInsets paddingExtraSmall = EdgeInsets.all(sizeExtraSmall);
  static const EdgeInsets paddingSmall = EdgeInsets.all(sizeSmall);
  static const EdgeInsets paddingMedium = EdgeInsets.all(sizeMedium);
  static const EdgeInsets paddingLarge = EdgeInsets.all(sizeLarge);

  static const EdgeInsets paddingHorizontalExtraSmall = EdgeInsets.symmetric(horizontal: sizeExtraSmall);
  static const EdgeInsets paddingHorizontalSmall = EdgeInsets.symmetric(horizontal: sizeSmall);
  static const EdgeInsets paddingHorizontalMedium = EdgeInsets.symmetric(horizontal: sizeMedium);
  static const EdgeInsets paddingHorizontalLarge = EdgeInsets.symmetric(horizontal: sizeLarge);

  static const EdgeInsets paddingVerticalExtraSmall = EdgeInsets.symmetric(vertical: sizeExtraSmall);
  static const EdgeInsets paddingVerticalSmall = EdgeInsets.symmetric(vertical: sizeSmall);
  static const EdgeInsets paddingVerticalMedium = EdgeInsets.symmetric(vertical: sizeMedium);
  static const EdgeInsets paddingVerticalLarge = EdgeInsets.symmetric(vertical: sizeLarge);

  static TextStyle getTextFieldInputStyle({bool isPassword = false}) {
    return WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
      if (isPassword) {
        if (states.contains(WidgetState.error) && states.contains(WidgetState.focused)) {
          return AppTextStyle.labelMediumLight.copyWith(color: AppColor.brandPrimary800, decoration: TextDecoration.none);
        } else if (states.contains(WidgetState.error) && !states.contains(WidgetState.focused)) {
          return AppTextStyle.labelMediumLight.copyWith(color: AppColor.neutrals500, decoration: TextDecoration.none);
        } else {
          return AppTextStyle.labelMediumLight.copyWith(color: AppColor.brandPrimary800, decoration: TextDecoration.none);
        }
      } else {
        if (states.contains(WidgetState.error)) {
          return AppTextStyle.labelMediumLight.copyWith(color: AppColor.actionErrorWarning800, decoration: TextDecoration.none);
        } else if (!states.contains(WidgetState.disabled) && !states.contains(WidgetState.error)) {
          return AppTextStyle.labelMediumLight.copyWith(color: AppColor.brandPrimary800, decoration: TextDecoration.none);
        } else {
          return AppTextStyle.labelMediumLight.copyWith(color: AppColor.brandPrimary800, decoration: TextDecoration.none);
        }
      }
    });
  }

  static TextStyle getTextFieldLabelPasswordStyle() {
    return WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.error) && states.contains(WidgetState.focused)) {
        return AppTextStyle.labelExtraSmallLight.copyWith(color: AppColor.brandPrimary800, decoration: TextDecoration.none);
      } else if (states.contains(WidgetState.error) && !states.contains(WidgetState.focused)) {
        return AppTextStyle.labelExtraSmallLight.copyWith(color: AppColor.neutrals500, decoration: TextDecoration.none);
      } else {
        return AppTextStyle.labelExtraSmallLight.copyWith(color: AppColor.brandPrimary800, decoration: TextDecoration.none);
      }
    });
  }

  static ButtonStyle get getFilledTileButtonTheme {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all<Size>(const Size(48, 48)),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return AppColor.brandPrimary100;
        }
        return AppColor.brandPrimary050;
      }),
      overlayColor: const WidgetStatePropertyAll<Color?>(AppColor.brandPrimary100),
      padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(AppTheme.sizeMedium)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppTheme.sizeMedium + AppTheme.sizeExtraSmall),
          ),
        ),
      ),
    );
  }

  static ButtonStyle get getOutlinedTileButtonTheme {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all<Size>(const Size(48, 48)),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColor.brandPrimary050;
          } else {
            return AppColor.neutrals000;
          }
        },
      ),
      overlayColor: const WidgetStatePropertyAll<Color?>(AppColor.brandPrimary050),
      side: WidgetStateProperty.resolveWith<BorderSide>((final Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return const BorderSide(color: AppColor.brandPrimary550, width: 2);
        } else {
          return const BorderSide(color: AppColor.brandPrimary200, width: 2);
        }
      }),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppTheme.sizeMedium + AppTheme.sizeExtraSmall),
          ),
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(AppTheme.sizeMedium)),
    );
  }

  static final WidgetStateProperty<RoundedRectangleBorder> _buttonsRadius = WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );

  static final WidgetStateProperty<EdgeInsets> _defaultButtonsPadding = WidgetStateProperty.all<EdgeInsets>(
    const EdgeInsets.symmetric(
      horizontal: sizeMedium,
      vertical: sizeMedium,
    ),
  );

  static final ButtonStyle defaultButtonStyle = ButtonStyle(
    shape: _buttonsRadius,
    padding: _defaultButtonsPadding,
  );

  static final ButtonStyle largeButtonStyle = defaultButtonStyle.copyWith(
    padding: WidgetStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        horizontal: sizeLarge,
        vertical: sizeLarge,
      ),
    ),
  );

  static final ButtonStyle extraLargeButtonStyle = defaultButtonStyle.copyWith(
    padding: WidgetStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        horizontal: sizeExtraLarge,
        vertical: sizeExtraLarge,
      ),
    ),
  );

  static ColorScheme lightThemeColors = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff262626),
    onPrimary: Color(0xFFEAEAEA),
    secondary: Color(0xffd45500),
    onSecondary: Color(0xffffffff),

    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    surface: Color(0xFFFCF5F1),
    onSurface: Color(0xff262626),
/*
    onPrimaryContainer: Color(0xff08ff00),
    onPrimaryFixed: Color(0xff9d2aff),

    onPrimaryFixedVariant: Color(0xfffffe00),

    onSecondaryContainer: Color(0xff08ff00),
    onSecondaryFixed: Color(0xff9d2aff),
    onSecondaryFixedVariant: Color(0xfffffe00),

    onTertiary: Color(0xff08ff00),
    onTertiaryContainer: Color(0xff9d2aff),
    onTertiaryFixed: Color(0xfffffe00),
    onTertiaryFixedVariant: Color(0xfffffe00),*/

    /*secondaryFixed: Color(0xfffffe00),
    secondaryContainer: Color(0xfffffe00),
    secondaryFixedDim: Color(0xfffffe00),
    primaryFixed: Color(0xfffffe00),
    primaryContainer: Color(0xfffffe00),
    primaryFixedDim: Color(0xfffffe00),
    scrim: Color(0xfffffe00),
    outline: Color(0xfffffe00),
    outlineVariant: Color(0xfffffe00),
    tertiaryContainer: Color(0xfffffe00),
    tertiary: Color(0xfffffe00),
    tertiaryFixed: Color(0xfffffe00),
    tertiaryFixedDim: Color(0xfffffe00),
    surfaceDim: Color(0xfffffe00),
    surfaceTint: Color(0xfffffe00),
    surfaceBright: Color(0xfffffe00),
    surfaceContainer: Color(0xff00ff00),
    surfaceContainerHigh: Color(0xff126de1),*/
/*
    surfaceContainerHighest: Color(0xff337a2e),
    surfaceContainerLowest: Color(0xff00ffe1),
    surfaceContainerLow: Color(0xffff0000),
    onSurfaceVariant: Color(0xfffffe00),

    shadow: Colors.black45,
    errorContainer: Color(0xfffffe00),
    inverseSurface: Color(0xfffffe00),
    inversePrimary: Color(0xfffffe00),
    onErrorContainer: Color(0xfffffe00),
    onInverseSurface: Color(0xfffffe00),*/

    // primary: Color(0xFF202020),
    // onPrimary: Color(0xFF505050),
    // secondary: Color(0xFFBBBBBB),
    // onSecondary: Color(0xFFEAEAEA),
    // error: Color(0xFFF32424),
    // onError: Color(0xFFF32424),
    // surface: Color(0xFF54B435),
    // onSurface: Color(0xFF54B435),
  );

  static ColorScheme darkThemeColors = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFF1F2F3),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFBBBBBB),
    onSecondary: Color(0xFFEAEAEA),
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    surface: Color(0xFF54B435),
    onSurface: Color(0xFF54B435),
  );

  static final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: AppColor.primary);

  static ThemeData get defaultTheme {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.brandPrimary800,
        selectionColor: AppColor.brandPrimary050,
        selectionHandleColor: AppColor.brandPrimary800,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      // scaffoldBackgroundColor: AppColor.neutrals000,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        //AppColor.neutrals000,
        foregroundColor: Colors.transparent,
        //AppColor.neutrals000,
        titleTextStyle: AppTextStyle.headingSmallSemi.copyWith(color: AppColor.brandPrimary800),
        iconTheme: const IconThemeData(color: AppColor.brandPrimary800, size: 24),
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      //primaryColor: primaryColor,
      colorScheme: lightThemeColors,
      // mapping source # https://api.flutter.dev/flutter/material/TextTheme-class.html
      textTheme: const TextTheme(),
      fontFamily: AppTextStyle.geologicaFontFamily,
      iconTheme: const IconThemeData(color: Colors.black54),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: defaultButtonStyle.copyWith(
          minimumSize: WidgetStateProperty.all<Size>(const Size(48, 48)),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColor.neutrals100;
            } else if (states.contains(WidgetState.pressed)) {
              return AppColor.brandPrimary700;
            }
            return AppColor.brandPrimary600;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColor.neutrals500;
            } else {
              return AppColor.neutrals000;
            }
          }),
          overlayColor: const WidgetStatePropertyAll<Color?>(AppColor.brandPrimary700),
          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          iconSize: const WidgetStatePropertyAll<double>(24),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: defaultButtonStyle.copyWith(
          minimumSize: WidgetStateProperty.all<Size>(const Size(48, 48)),
          backgroundColor: WidgetStateProperty.all<Color>(AppColor.neutrals000),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColor.neutrals500;
              } else if (states.contains(WidgetState.pressed)) {
                return AppColor.brandPrimary700;
              }
              return AppColor.brandPrimary600;
            },
          ),
          overlayColor: const WidgetStatePropertyAll<Color?>(AppColor.brandPrimary050),
          side: WidgetStateProperty.resolveWith<BorderSide>((final Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return const BorderSide(color: AppColor.neutrals500, width: 2);
            } else if (states.contains(WidgetState.pressed)) {
              return const BorderSide(color: AppColor.brandPrimary700, width: 2);
            } else {
              return const BorderSide(color: AppColor.brandPrimary600, width: 2);
            }
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
          iconColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColor.neutrals500;
              } else if (states.contains(WidgetState.pressed)) {
                return AppColor.brandPrimary700;
              }
              return AppColor.brandPrimary600;
            },
          ),
          iconSize: const WidgetStatePropertyAll<double>(24),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(shape: _buttonsRadius).copyWith(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: sizeMedium)),
          textStyle: WidgetStateProperty.all<TextStyle>(
            AppTextStyle.linksMediumSemi,
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColor.neutrals500;
              } else if (states.contains(WidgetState.pressed)) {
                return AppColor.brandPrimary700;
              }
              return AppColor.brandPrimary600;
            },
          ),
          iconColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColor.neutrals500;
              } else if (states.contains(WidgetState.pressed)) {
                return AppColor.brandPrimary700;
              }
              return AppColor.brandPrimary600;
            },
          ),
          iconSize: const WidgetStatePropertyAll<double>(24),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          overlayColor: const WidgetStatePropertyAll<Color?>(AppColor.brandPrimary100),
        ),
      ),

      scrollbarTheme: const ScrollbarThemeData(
        thumbVisibility: WidgetStatePropertyAll<bool?>(true),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutrals500;
          } else {
            return states.contains(WidgetState.selected) ? AppColor.neutrals000 : AppColor.neutrals800;
          }
        }),
        trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return states.contains(WidgetState.selected) ? AppColor.neutrals100 : AppColor.neutrals000;
          } else {
            return states.contains(WidgetState.selected) ? AppColor.brandAccent550 : AppColor.neutrals000;
          }
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return states.contains(WidgetState.selected) ? AppColor.neutrals100 : AppColor.neutrals500;
          } else {
            return states.contains(WidgetState.selected) ? AppColor.brandAccent550 : AppColor.neutrals600;
          }
        }),
        //Size Fix, color problem
        trackOutlineWidth: const WidgetStatePropertyAll<double>(2),
      ),

      checkboxTheme: CheckboxThemeData(
        visualDensity: VisualDensity.compact,
        checkColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled) && states.contains(WidgetState.selected)) {
            return AppColor.neutrals500;
          } else if (states.contains(WidgetState.selected)) {
            return AppColor.neutrals000;
          }
          return Colors.transparent;
        }),
        fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled) && states.contains(WidgetState.selected)) {
            return AppColor.neutrals100;
          } else if (states.contains(WidgetState.selected)) {
            return AppColor.brandAccent550;
          } else if (states.contains(WidgetState.pressed)) {
            return AppColor.brandAccent600;
          }
          return Colors.transparent;
        }),
        splashRadius: 10,
        overlayColor: const WidgetStatePropertyAll<Color?>(AppColor.brandAccent050),
        side: WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide(color: (states.contains(WidgetState.disabled)) ? AppColor.neutrals100 : AppColor.brandAccent550);
          } else if (!states.contains(WidgetState.selected)) {
            return BorderSide(color: (states.contains(WidgetState.disabled)) ? AppColor.neutrals400 : AppColor.neutrals600);
          }
          return const BorderSide(color: AppColor.neutrals400);
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutrals400;
          } else if (states.contains(WidgetState.selected)) {
            return AppColor.brandAccent550;
          }
          return AppColor.neutrals600;
        }),
        overlayColor: const WidgetStatePropertyAll<Color?>(AppColor.brandAccent550),
        splashRadius: 8,
      ),

      listTileTheme: ListTileThemeData(
        style: ListTileStyle.list,
        dense: true,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        minTileHeight: 48,
        textColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.neutrals400;
          } else if (states.contains(WidgetState.disabled)) {
            return AppColor.neutrals400.withOpacity(0.4);
          } else {
            return AppColor.brandPrimary800;
          }

          // if (states.contains(WidgetState.focused)) {
          //   return states.contains(WidgetState.error) ? AppColor.actionErrorWarning050 : AppColor.brandPrimary100;
          // } else if (states.contains(WidgetState.error)) {
          //   return states.contains(WidgetState.selected) ? AppColor.brandAccent550 : AppColor.white;
          // }
          // return Colors.transparent;
        }),
      ),

      cupertinoOverrideTheme: MaterialBasedCupertinoThemeData(materialTheme: ThemeData()),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: defaultButtonStyle,
      ),

      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        errorMaxLines: 5,
        contentPadding: const EdgeInsets.fromLTRB(12, 16, 0, 16),
        labelStyle:
            // AppTextStyle.bodyExtraSmallLight.copyWith(color: Colors.orange),
            WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          // print('~~~~~WidgetStateTextStyle~~~~~~~~ $states');
          if (states.contains(WidgetState.error)) {
            return AppTextStyle.labelMediumLight.copyWith(color: AppColor.actionErrorWarning800, decoration: TextDecoration.none);
          } else if (states.contains(WidgetState.disabled)) {
            return AppTextStyle.labelMediumLight.copyWith(color: AppColor.neutrals500, decoration: TextDecoration.none);
          } else if (!states.contains(WidgetState.disabled) && !states.contains(WidgetState.error)) {
            return AppTextStyle.labelMediumLight.copyWith(color: AppColor.neutrals600, decoration: TextDecoration.none);
          } else {
            return AppTextStyle.labelMediumLight.copyWith(color: AppColor.neutrals600, decoration: TextDecoration.none);
          }
        }),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          // print('~~~~~WidgetStateTextStyle~~~~~~~~ $states');
          if (states.contains(WidgetState.error)) {
            return AppTextStyle.bodyExtraSmallLight.copyWith(color: AppColor.actionErrorWarning800);
          } else if (states.contains(WidgetState.disabled)) {
            return AppTextStyle.bodyExtraSmallLight.copyWith(color: AppColor.neutrals500);
          } else if (!states.contains(WidgetState.disabled) && !states.contains(WidgetState.error)) {
            return AppTextStyle.bodyExtraSmallLight.copyWith(color: AppColor.brandPrimary800);
          } else {
            return AppTextStyle.bodyExtraSmallLight.copyWith(color: AppColor.brandPrimary800);
          }
        }),
        alignLabelWithHint: true,
        iconColor: AppColor.black,
        prefixIconColor: AppColor.black,
        suffixIconColor: AppColor.brandPrimary800,
        errorStyle: AppTextStyle.bodyExtraSmallLight.copyWith(color: AppColor.actionErrorWarning600),
        filled: true,
        fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.focused)) {
            return states.contains(WidgetState.error) ? AppColor.actionErrorWarning050 : AppColor.brandPrimary050;
          } else if (states.contains(WidgetState.error)) {
            return states.contains(WidgetState.selected) ? AppColor.brandAccent550 : AppColor.neutrals000;
          }
          return Colors.transparent;
        }),
        hintStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          // print('~~~~~WidgetStateTextStyle~~~~~~~~ $states');
          if (states.contains(WidgetState.error)) {
            return AppTextStyle.labelMediumLight.copyWith(color: AppColor.actionErrorWarning800, decoration: TextDecoration.none);
          } else if (!states.contains(WidgetState.disabled) && !states.contains(WidgetState.error)) {
            return AppTextStyle.labelMediumLight.copyWith(color: AppColor.brandPrimary800, decoration: TextDecoration.none);
          } else {
            return AppTextStyle.labelMediumLight.copyWith(color: AppColor.brandPrimary800, decoration: TextDecoration.none);
          }
        }),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: AppColor.brandPrimary800),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: AppColor.brandPrimary550),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.neutrals500, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.actionErrorWarning600, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.brandAccent050, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      tabBarTheme: const TabBarTheme(
        indicatorColor: AppColor.brandPrimary600,
        dividerColor: Colors.transparent,
        labelColor: AppColor.brandPrimary600,
        unselectedLabelColor: AppColor.neutrals800,
        labelStyle: AppTextStyle.linksMediumSemi,
        unselectedLabelStyle: AppTextStyle.linksMediumSemi,
        tabAlignment: TabAlignment.start,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColor.neutrals000,
        disabledColor: AppColor.neutrals100,
        selectedColor: AppColor.brandAccent550,
        secondarySelectedColor: AppColor.brandAccent550,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.sizeLarge, vertical: AppTheme.sizeMedium),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.brandPrimary200, width: 2),
          borderRadius: BorderRadius.circular(80),
        ),
        iconTheme: const IconThemeData(color: AppColor.brandPrimary600),
        labelStyle: AppTextStyle.linksMediumSemi.copyWith(color: AppColor.brandPrimary600),
        secondaryLabelStyle: AppTextStyle.labelMediumLight.copyWith(color: AppColor.brandPrimary800),
        brightness: Brightness.light,
        elevation: 0,
        pressElevation: 0,
        selectedShadowColor: AppColor.brandAccent550,
        shadowColor: AppColor.neutrals000,
      ),
    );
  }
}
