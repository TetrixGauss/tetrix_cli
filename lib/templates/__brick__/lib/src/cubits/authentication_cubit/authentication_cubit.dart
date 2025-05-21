import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:{{name}}/src/core/constants/app_constants.dart';
import 'package:{{name}}/src/core/enums/common_enums.dart';
import 'package:{{name}}/src/core/enums/enums.dart';
import 'package:{{name}}/src/core/utils/nullable.dart';
import 'package:{{name}}/src/cubits/authentication_cubit/authentication_state.dart';
import 'package:{{name}}/src/cubits/common_data_cubit/common_data_cubit.dart';
import 'package:{{name}}/src/data/repositories/auth_repository.dart';
import 'package:{{name}}/src/data/repositories/user_repository.dart';
import 'package:{{name}}/src/main.dart';
import 'package:{{name}}/src/router/routes.dart';
import 'package:{{name}}/src/services/network/api_response.dart';

class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  AuthenticationCubit._internal() : super(const AuthenticationState());

  static final AuthenticationCubit _singleton = AuthenticationCubit._internal();

  static AuthenticationCubit get instance => _singleton;

  Timer? _applicationTokenTimer;
  Timer? _userTokenTimer;

  Future<void> authenticate() async {
    if (state.applicationToken == null) {
      await getApplicationToken();
    } else {
      await checkTokenStatus();
    }
  }

  Future<void> ensureInitialized() async {
    if (state.userToken == null) {
      if (state.applicationToken == null) {
        await getApplicationToken();
      } else {
        await _refreshApplicationToken();
      }
    } else {
      await _refreshApplicationToken().then((_) async {
        await refreshUserToken();
      });
    }
  }

  Future<void> checkTokenStatus() async {
    await applicationToken;
    // checkApplicationTokenValidation();
    await userToken;
    // checkUserTokenValidation();
  }

  Future<bool> checkUserTokenValidation() async {
    bool valid = false;
    if (state.userToken != null) {
      final Duration? diffUserToken = state.userTokenExpiresAt?.difference(DateTime.now());
      print('diffUserToken: $diffUserToken');
      if (state.userToken != null && diffUserToken != null && diffUserToken < AppConstants.timeBeforeTokenExpireToTriggerRefreshToken) {
        await refreshUserToken();
        valid = true;
      }
    }
    return valid;
  }

  bool _isUserTokenValid() {
    if (state.userToken != null) {
      final Duration? diffUserToken = state.userTokenExpiresAt?.difference(DateTime.now());
      print('diffUserToken: $diffUserToken');
      if (state.userToken != null && diffUserToken != null) {
        if (diffUserToken > SoulfoodCoreConstants.acceptedTimeBeforeExpiration) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  bool _isUserRefreshTokenValid() {
    if (state.userRefreshToken != null) {
      final Duration? diffUserRefreshToken = state.userTokenExpiresAt?.difference(DateTime.now());
      print('diffUserToken: $diffUserRefreshToken');
      if (state.userRefreshToken != null && diffUserRefreshToken != null) {
        if (diffUserRefreshToken > SoulfoodCoreConstants.acceptedTimeBeforeExpiration) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  bool _isApplicationTokenValid() {
    if (state.applicationToken != null) {
      final Duration? diffApplicationToken = state.applicationTokenExpiresAt?.difference(DateTime.now());
      print('diffUserToken: $diffApplicationToken');
      if (state.applicationToken != null && diffApplicationToken != null) {
        if (diffApplicationToken > SoulfoodCoreConstants.acceptedTimeBeforeExpiration) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  bool _isApplicationRefreshTokenValid() {
    if (state.applicationRefreshToken != null) {
      final Duration? diffApplicationRefreshToken = state.applicationRefreshTokenExpiresAt?.difference(DateTime.now());
      print('diffUserToken: $diffApplicationRefreshToken');
      if (state.applicationRefreshToken != null && diffApplicationRefreshToken != null) {
        if (diffApplicationRefreshToken > SoulfoodCoreConstants.acceptedTimeBeforeExpiration) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  Future<String?> get userToken async {
    print("refreshUserToken: ${state.userRefreshToken}");
    print("_isUserTokenValid(): ${_isUserTokenValid()}");
    print("--------------------------------------------");
    if (!_isUserTokenValid()) {
      print("2222222222222222222222222222");
      // if (!_isUserRefreshTokenValid()) {
      //   await logout();
      //   return null;
      // } else {
      return refreshUserToken();
      // await refreshUserToken();
      // }
    } else {
      print("11111111111111111111111111");
      return state.userToken;
    }
    // return state.userToken;
  }

  Future<String?> get applicationToken async {
    if (!_isApplicationTokenValid()) {
      // if (!_isApplicationRefreshTokenValid()) {
      //   await logout();
      //   return null;
      // } else {
      return _refreshApplicationToken();
      // }
    }
    return state.applicationToken;
  }

  Future<bool> checkApplicationTokenValidation() async {
    bool valid = false;
    if (state.applicationToken != null) {
      final Duration? diffApplicationToken = state.applicationTokenExpiresAt?.difference(DateTime.now());
      print('diffApplicationToken: $diffApplicationToken');
      if (state.applicationToken != null &&
          diffApplicationToken != null &&
          diffApplicationToken < SoulfoodCoreConstants.timeBeforeTokenExpireToTriggerRefreshToken) {
        await _refreshApplicationToken();
        valid = true;
      }
    }

    return valid;
  }

  void startApplicationTokenRefresh() {
    if (_applicationTokenTimer != null) {
      _applicationTokenTimer?.cancel();
    }
    _applicationTokenTimer = Timer(SoulfoodCoreConstants.refreshTokenInterval, _refreshApplicationToken);
  }

  void startUserTokenRefresh() {
    if (_userTokenTimer != null) {
      _userTokenTimer?.cancel();
    }
    _userTokenTimer = Timer(SoulfoodCoreConstants.refreshTokenInterval, refreshUserToken);
  }

  Future<String?> _refreshApplicationToken() async {
    String? token;
    _applicationTokenTimer?.cancel();

    final ApiResponse<Map<String, dynamic>> result = await AuthRepository.instance.refreshToken(state.applicationRefreshToken ?? 'empty token?');
    print('refreshToken for APP: Success: ${result.success}');
    if (result.success) {
      final DateTime expiredAt = DateTime.now().add(Duration(seconds: (result.data?['expires_in'] as int?) ?? 1800));
      emit(
        state.copyWith(
          applicationToken: Nullable<String?>(result.data?['access_token']),
          applicationRefreshToken: Nullable<String?>(result.data?['refresh_token']),
          applicationTokenExpiresAt: Nullable<DateTime?>(expiredAt),
        ),
      );
      token = result.data?['access_token'];
    } else {
      print('refreshApplicationToken - ERROR Message: ${result.error?.message}');
    }
    // startApplicationTokenRefresh();
    return token;
  }

  Future<String?> refreshUserToken() async {
    _userTokenTimer?.cancel();
    String? token;
    print("refreshUserToken: ${state.userRefreshToken}");
    print("_isUserTokenValid(): ${_isUserTokenValid()}");
    print("--------------------------------------------");
    final ApiResponse<Map<String, dynamic>> result = await UserRepository.instance.refreshToken(state.userRefreshToken ?? 'empty token?');
    print('refreshToken for USER: Success: ${result.success}');
    print("result: $result");
    if (result.success) {
      final DateTime expiredAt = DateTime.now().add(Duration(seconds: (result.data?['expires_in'] as int?) ?? 1800));
      emit(
        state.copyWith(
          userToken: Nullable<String?>(result.data?['access_token']),
          userRefreshToken: Nullable<String?>(result.data?['refresh_token']),
          userTokenExpiresAt: Nullable<DateTime?>(expiredAt),
        ),
      );
      token = result.data?['access_token'];
    } else {
      print("--------------------------------------------");
      print("_isUserTokenValid(): ${_isUserTokenValid()}");
      print('refreshUserToken - ERROR Message: ${result.error?.message}');
      // showAppSnackBar(overlayState: Overlay.of(navigatorKey.currentContext!), toastStatus: ToastStatus.error, title: 'Session expired');
      // await logout();
      // unawaited(navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.registerLoginSelectionScreen, (Route<dynamic> route) => false));
    }

    // startUserTokenRefresh();
    return token;
  }

  Future<void> getApplicationToken({bool onlyToken = false}) async {
    final ApiResponse<Map<String, dynamic>> result = await AuthRepository.instance.getApplicationToken();

    if (result.success) {
      final DateTime expiredAt = DateTime.now().add(Duration(seconds: (result.data?['expires_in'] as int?) ?? 3600));
      emit(
        state.copyWith(
          authAppStatus: AuthenticationAppStatus.authenticated,
          applicationToken: Nullable<String?>(result.data?['access_token']),
          applicationRefreshToken: Nullable<String?>(result.data?['refresh_token']),
          applicationTokenExpiresAt: Nullable<DateTime?>(expiredAt),
          applicationRefreshTokenExpiresAt: Nullable<DateTime?>(expiredAt),
        ),
      );
      if (!onlyToken) {
        await CommonDataCubit.instance.getLanguages();
        await CommonDataCubit.instance.getCountryCodes();
        await CommonDataCubit.instance.getSplashData();
      }
      // await CommonDataCubit.instance.getTextConstants(SoulfoodCoreConstants.translationsPath);
      startApplicationTokenRefresh();
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> getUserToken({required String userName, required String password}) async {
    final ApiResponse<Map<String, dynamic>> result = await UserRepository.instance.getUserToken(userName: userName, password: password);

    if (result.success) {
      final DateTime expiredAt = DateTime.now().add(Duration(seconds: (result.data?['expires_in'] as int?) ?? 3600));
      emit(
        state.copyWith(
          authUserStatus: AuthenticationUserStatus.authenticated,
          userToken: Nullable<String?>(result.data?['access_token']),
          userRefreshToken: Nullable<String?>(result.data?['refresh_token']),
          userTokenExpiresAt: Nullable<DateTime?>(expiredAt),
        ),
      );
      // startUserTokenRefresh();
    }

    return result;
  }

  void walkthroughDone() {
    emit(state.copyWith(walkthroughStatus: WalkthroughStatus.seen));
  }

  Future<void> logout({bool totalClear = false}) async {
    print('***************************************');
    print('*************** LOGOUT ****************');
    print('***************************************');
    CommonDataCubit.instance.showNoCompanyBottomSheet(value: true);
    if (totalClear) {
      emit(state.totalClear());
    } else {
      emit(state.clear());
    }
    // await clear();
    unawaited(navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.splashScreen, (Route<dynamic> route) => false));
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    try {
      ///
      /// Check if user token is not expired or expiring soon and set status to appropriate condition
      ///
      AuthenticationUserStatus authenticationUserStatus = AuthenticationUserStatus.unauthenticated;
      final String? userToken = json['userToken'] as String?;
      final DateTime? userTokenExpiresAt = json['userTokenExpiresAt'] == null ? null : DateTime.parse(json['userTokenExpiresAt'] as String);
      if (userToken != null && userToken.isNotEmpty && DateTime.now().isBefore(userTokenExpiresAt ?? DateTime.now())) {
        authenticationUserStatus = AuthenticationUserStatus.authenticated;
      }
      print('userToken: $userToken');
      AuthenticationAppStatus authenticationAppStatus = AuthenticationAppStatus.unauthenticated;
      final String? appToken = json['applicationToken'] as String?;
      final DateTime? applicationTokenExpiresAt =
          json['applicationTokenExpiresAt'] == null ? null : DateTime.parse(json['applicationTokenExpiresAt'] as String);
      if (appToken != null && appToken.isNotEmpty && DateTime.now().isBefore(applicationTokenExpiresAt ?? DateTime.now())) {
        authenticationAppStatus = AuthenticationAppStatus.authenticated;
      }
      AuthenticationState state = AuthenticationState(
        authAppStatus: AuthenticationAppStatus.values[json['authAppStatus'] as int],
        authUserStatus: AuthenticationUserStatus.values[json['authUserStatus'] as int],
        // authAppStatus: json['authAppStatus'], //authenticationAppStatus,
        // authUserStatus: json['authUserStatus'], //authenticationUserStatus,
        applicationToken: json['applicationToken'] as String?,
        applicationRefreshToken: json['applicationRefreshToken'] as String?,
        applicationTokenExpiresAt: json['applicationTokenExpiresAt'] == null ? null : DateTime.parse(json['applicationTokenExpiresAt'] as String),
        applicationRefreshTokenExpiresAt:
            json['applicationRefreshTokenExpiresAt'] == null ? null : DateTime.parse(json['applicationRefreshTokenExpiresAt'] as String),
        userToken: json['userToken'] as String?,
        userRefreshToken: json['userRefreshToken'] as String?,
        userTokenExpiresAt: json['userTokenExpiresAt'] == null ? null : DateTime.parse(json['userTokenExpiresAt'] as String),
        userRefreshTokenExpiresAt: json['userRefreshTokenExpiresAt'] == null ? null : DateTime.parse(json['userRefreshTokenExpiresAt'] as String),
        walkthroughStatus: json['walkthroughStatus'] == null ? WalkthroughStatus.notSeen : WalkthroughStatus.values[json['walkthroughStatus'] as int],
      );
      print('AuthenticationCubit: fromJson: $state');
      return state;
    } catch (e) {
      if (kDebugMode) {
        print('AuthenticationCubit: fromJson: Error $e');
      }
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    final Map<String, dynamic> result = <String, dynamic>{
      'authAppStatus': state.authAppStatus.index,
      'authUserStatus': state.authUserStatus.index,
      'applicationToken': state.applicationToken,
      'applicationRefreshToken': state.applicationRefreshToken,
      'applicationTokenExpiresAt': state.applicationTokenExpiresAt?.toIso8601String(),
      'applicationRefreshTokenExpiresAt': state.applicationRefreshTokenExpiresAt?.toIso8601String(),
      'userToken': state.userToken,
      'userRefreshToken': state.userRefreshToken,
      'userTokenExpiresAt': state.userTokenExpiresAt?.toIso8601String(),
      'userRefreshTokenExpiresAt': state.userRefreshTokenExpiresAt?.toIso8601String(),
      'walkthroughStatus': state.walkthroughStatus.index,
    };
    return result;
  }
}
