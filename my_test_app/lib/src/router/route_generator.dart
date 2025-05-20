import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/cubits/authentication_cubit/authentication_cubit.dart';
import 'src/presentation/screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(final RouteSettings settings) {
    MaterialPageRoute<dynamic> buildRoute<T>({required final Widget screen}) {
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (_) => screen,
      );
    }

    switch (settings.name) {
      default:
        return buildRoute<BlocProvider<AuthenticationCubit>>(
          screen: const SplashScreen(),
        );
    }
  }
}
