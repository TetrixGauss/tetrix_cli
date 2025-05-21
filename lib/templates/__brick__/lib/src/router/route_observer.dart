import 'package:flutter/material.dart';
import 'package:{{name}}/main.dart';
import 'package:{{name}}/src/router/routes.dart';

class AppRouteObserver extends RouteObserver<ModalRoute<dynamic>> {
  factory AppRouteObserver() {
    return _instance;
  }

  AppRouteObserver._internal();

  static final AppRouteObserver _instance = AppRouteObserver._internal();
  static List<Route<dynamic>?> history = <Route<dynamic>?>[];

  static printHistory() {
    history.forEach((Route<dynamic>? route) {
      print('---- history --------> ---> ${route?.settings.name}'); //$index
    });
  }

  static List<String> screensWithBottomNavigation =
      Routes.homeRoutes + Routes.conferencesRoutes + Routes.supportRoutes + Routes.advicesRoutes + Routes.accountRoutes;

  void handleBottomNavigationStatus(RouteSettings? settings) {
    final String? screenName = settings?.name;
    print('---- handleBottomNavigationStatus --------> $screenName');
    if (screenName != null) {
      // && screenName != "none" && screenName != "" && screenName != "/" && screenName != "null"
      //
      FocusManager.instance.primaryFocus?.unfocus();
      menuKey.currentState?.setHasMenu(screensWithBottomNavigation.contains(screenName));

      if (Routes.homeRoutes.contains(screenName)) {
        menuKey.currentState?.selectIndex(0);
      } else if (Routes.conferencesRoutes.contains(screenName)) {
        menuKey.currentState?.selectIndex(1);
      } else if (Routes.supportRoutes.contains(screenName)) {
        menuKey.currentState?.selectIndex(2);
      } else if (Routes.advicesRoutes.contains(screenName)) {
        menuKey.currentState?.selectIndex(3);
      } else if (Routes.accountRoutes.contains(screenName)) {
        menuKey.currentState?.selectIndex(4);
      } else {
        menuKey.currentState?.selectIndex(null);
      }
      //
      // if (screenName == Routes.subArticlesScreen) {
      //   appScaffoldKey.currentState?.setFloatingActionButton(
      //     FiltersFab(
      //       key: fabKey,
      //       isForCompany: (((settings?.arguments as Map<String, dynamic>?) ?? <String, dynamic>{})[ScreenArgumentKeys.isCompany] ?? false) as bool,
      //     ),
      //   );
      // } else {
      //   appScaffoldKey.currentState?.setFloatingActionButton(null);
      // }
    }
    // else {
    //   menuKey.currentState?.setHasMenu(false);
    // }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name == route.settings.name && previousRoute?.settings.arguments == route.settings.arguments) {
      return;
    } else {
      super.didPush(route, previousRoute);
      history.add(route);
      // print('---- didPush --------> ${route.runtimeType} ---> ${route.settings}');
      // printHistory();
      if (route is MaterialPageRoute) {
        handleBottomNavigationStatus(route.settings);
      }
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    // print("--------------------- didRemove: ${route.settings.name}");
    history.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final int oldRouteIndex = history.indexOf(oldRoute);
    history.replaceRange(oldRouteIndex, oldRouteIndex + 1, <Route<dynamic>?>[newRoute]);
    // print('---- didReplace --------> ${newRoute?.runtimeType}');
    if (newRoute is MaterialPageRoute) {
      handleBottomNavigationStatus(newRoute.settings);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    history.removeLast();

    // log('---- didPop --------> ${route.settings.name}   ------> ${previousRoute?.settings.name} -----> ${previousRoute?.settings}');
    // log('---- didPop2 --------> ${route.settings.name}   ------> ${previousRoute?.settings.name} -----> ${previousRoute?.settings.arguments} -----> ${route.settings.arguments}');
    // printHistory();
    if (previousRoute is MaterialPageRoute) {
      // print("---------- ${previousRoute.subtreeContext?.loaderOverlay.visible}");

      handleBottomNavigationStatus(previousRoute.settings);
    }
  }
}
