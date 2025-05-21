import 'package:flutter/material.dart';
import 'package:{{name}}/src/core/theme/app_theme.dart';
import 'package:{{name}}/src/presentation/widgets/app_widgets/app_bottom_navigation_bar.dart';
import 'package:{{name}}/src/presentation/widgets/app_widgets/app_bottom_sheet.dart';
import 'package:{{name}}/src/router/route_observer.dart';

import 'main.dart';

class AppBottomSheetHelper {
  static void showBottomSheet(
    BuildContext context, {
    Widget? body,
    Widget? bottomNavigationBar,
    Widget? header,
    bool withBottomShadow = true,
    Function? onClose,
    bool isExpandable = true,
  }) {
    _showBottomSheet(
      context,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      header: header,
      withBottomShadow: withBottomShadow,
      onClose: onClose,
      isExpandable: isExpandable,
    );
  }

  static void showNoCompanyBottomSheet(
    BuildContext context, {
    Widget? body,
    AppBottomNavigationBar? bottomNavigationBar,
    Function? onClose,
  }) {
    _showBottomSheet(context,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        isDismissible: false,
        barrierColor: AppColor.bottomSheetOverlayNoOpacity,
        enableDrag: false,
        onClose: onClose);
  }

  static void _showBottomSheet(
    BuildContext context, {
    Widget? body,
    Widget? bottomNavigationBar,
    Widget? header,
    bool defaultHeader = true,
    bool isDismissible = true,
    Color? barrierColor,
    bool enableDrag = true,
    bool withBottomShadow = true,
    Function? onClose,
    bool isExpandable = false,
  }) {
    appScaffoldKey.currentState?.setFloatingActionButton(null);
    menuKey.currentState?.setHasMenu(false);
    showModalBottomSheet(
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      useSafeArea: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor ?? AppColor.bottomSheetOverlay,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        if (header != null) {
          return AppBottomSheet.customHeader(
            body: body,
            bottomNavigationBar: bottomNavigationBar,
            header: header,
            isExpandable: isExpandable,
          );
        } else {
          return AppBottomSheet(
            isExpandable: isExpandable,
            body: body,
            bottomNavigationBar: bottomNavigationBar,
            withBottomShadow: withBottomShadow,
          );
        }
      },
    ).then((_) {
      onClose?.call();
      if (context.mounted) {
        final ModalRoute<Object?>? route = ModalRoute.of(context);
        AppRouteObserver().handleBottomNavigationStatus(route?.settings);
      }
      return null;
    });
  }
}
