import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';

import '../../src/core/constants/api_consts.dart';
import '../../src/core/constants/atcom_companion_core_constants.dart';
import '../../src/core/enums/language.dart';
import '../../src/core/theme/app_theme.dart';
import '../../src/core/utils/helpers/crashlytics_helper.dart';
import '../../src/core/utils/helpers/translations_helper.dart';
import '../../src/cubits/authentication_cubit/authentication_cubit.dart';
import '../../src/cubits/common_data_cubit/common_data_cubit.dart';
import '../../src/presentation/widgets/app_widgets/app_bottom_navigation_bar_menu.dart';
import '../../src/presentation/widgets/app_widgets/app_scaffold.dart';
import '../../src/presentation/widgets/app_widgets/app_screen.dart';
import '../../src/router/route_generator.dart';
import '../../src/router/route_observer.dart';
import '../../src/services/network/http.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final AppRouteObserver observer = AppRouteObserver();
final GlobalKey<AppScaffoldState> appScaffoldKey = GlobalKey<AppScaffoldState>(debugLabel: 'app_scaffold_key');
final GlobalKey<AppScreenState> appScreenKey = GlobalKey<AppScreenState>(debugLabel: 'app_screen_key');
final GlobalKey<AppBottomNavigationBarMenuState> menuKey = GlobalKey<AppBottomNavigationBarMenuState>(debugLabel: 'app_bottom_navigation_menu_key');

Future<void> initConsentV2() async {
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  await FirebaseAnalytics.instance.setConsent(
    analyticsStorageConsentGranted: true,
    adStorageConsentGranted: true,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DevToolsProvider.ensureInitialized();
  final Directory appDocDirectory = await getApplicationDocumentsDirectory();
  final HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: Directory('${appDocDirectory.path}/{{project_name}}'),
  );

  HydratedBloc.storage = storage;

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: "assets/.env");

  EasyLocalization.logger.enableLevels = <LevelMessages>[LevelMessages.info, LevelMessages.warning, LevelMessages.error];
  // await _appTrackingPermission();
  await Firebase.initializeApp();
  await initConsentV2();
  // await DevTools().init(fireStoreConfig!.urls!.values.toList());
  Http.instance.init();
  // await AuthenticationCubit.instance.authenticate();
  await AuthenticationCubit.instance.ensureInitialized();
  AppLifecycleListener(
    onStateChange: (AppLifecycleState state) async {
      print('lifecycle app state: $state');
      if (state == AppLifecycleState.resumed) {
        await AuthenticationCubit.instance.ensureInitialized();
        // await AuthenticationCubit.instance.checkTokenStatus();
        await CommonDataCubit.instance.getLanguages();
      }
    },
  );

  FlutterError.onError = (final FlutterErrorDetails error) {
    CrashlyticsHelper.recordError(error.exception, error.stack);
  };

  final List<Locale> locales = Language.values.map((final Language e) => e.locale).toList();
  runApp(
    // DevToolsProvider(
    //   controller: devToolsController,
    //   child:
    MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<AuthenticationCubit>(create: (_) => AuthenticationCubit.instance),
        BlocProvider<CommonDataCubit>(create: (_) => CommonDataCubit.instance),
      ],
      child: EasyLocalization(
        supportedLocales: locales,
        startLocale: CommonDataCubit.instance.state.currentLanguage?.toLocale() ?? CommonDataCubit.instance.getSystemLanguage().toLocale(),
        path: AppConstants.translationsPath,
        assetLoader: TranslationsLoader(),
        child: const MyApp(),
      ),
    ),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('BaseUrl: ${ApiConsts.baseUrl}');
    return GlobalLoaderOverlay(
      closeOnBackButton: true,
      disableBackButton: false,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      reverseDuration: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 300),
      overlayWidgetBuilder: (final _) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColor.mainGradient,
          ),
          child: Center(child: CircularProgressIndicator()
              // AppLoader(),
              ),
        );
      },
      child: MaterialApp(
        navigatorKey: navigatorKey,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorObservers: <NavigatorObserver>[
          observer,
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        builder: (final BuildContext context, final Widget? child) {
          return AppScaffold(
            key: appScaffoldKey,
            body: child,
          );
        },
      ),
    );
  }
}
