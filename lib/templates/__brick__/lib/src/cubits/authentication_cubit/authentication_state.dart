import 'package:equatable/equatable.dart';
import 'package:atcom_companion_app/src/core/enums/common_enums.dart';
import 'package:atcom_companion_app/src/core/enums/enums.dart';
import 'package:atcom_companion_app/src/core/utils/nullable.dart';
import 'package:atcom_companion_app/src/services/network/app_error.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.authAppStatus = AuthenticationAppStatus.unauthenticated,
    this.authUserStatus = AuthenticationUserStatus.unauthenticated,
    this.error,
    this.applicationToken,
    this.applicationRefreshToken,
    this.applicationTokenExpiresAt,
    this.applicationRefreshTokenExpiresAt,
    this.userToken,
    this.userRefreshToken,
    this.userTokenExpiresAt,
    this.userRefreshTokenExpiresAt,
    this.loadingStatus,
    this.userEmail,
    this.walkthroughStatus = WalkthroughStatus.notSeen,
  });

  final AuthenticationAppStatus authAppStatus;
  final AuthenticationUserStatus authUserStatus;
  final AppError? error;
  final String? applicationToken;
  final String? applicationRefreshToken;
  final DateTime? applicationTokenExpiresAt;
  final DateTime? applicationRefreshTokenExpiresAt;
  final String? userToken;
  final String? userRefreshToken;
  final DateTime? userTokenExpiresAt;
  final DateTime? userRefreshTokenExpiresAt;
  final LoadingStatus? loadingStatus;
  final String? userEmail;
  final WalkthroughStatus walkthroughStatus;

  AuthenticationState copyWith({
    AuthenticationAppStatus? authAppStatus,
    AuthenticationUserStatus? authUserStatus,
    AppError? error,
    Nullable<String?>? applicationToken,
    Nullable<String?>? applicationRefreshToken,
    Nullable<DateTime?>? applicationTokenExpiresAt,
    Nullable<DateTime?>? applicationRefreshTokenExpiresAt,
    Nullable<String?>? userToken,
    Nullable<String?>? userRefreshToken,
    Nullable<DateTime?>? userTokenExpiresAt,
    Nullable<DateTime?>? userRefreshTokenExpiresAt,
    LoadingStatus? loadingStatus,
    Nullable<String?>? userEmail,
    WalkthroughStatus? walkthroughStatus,
  }) {
    return AuthenticationState(
      authAppStatus: authAppStatus ?? this.authAppStatus,
      authUserStatus: authUserStatus ?? this.authUserStatus,
      error: error,
      applicationToken: applicationToken == null ? this.applicationToken : applicationToken.value,
      applicationRefreshToken: applicationRefreshToken == null ? this.applicationRefreshToken : applicationRefreshToken.value,
      applicationTokenExpiresAt: applicationTokenExpiresAt == null ? this.applicationTokenExpiresAt : applicationTokenExpiresAt.value,
      applicationRefreshTokenExpiresAt:
          applicationRefreshTokenExpiresAt == null ? this.applicationRefreshTokenExpiresAt : applicationRefreshTokenExpiresAt.value,
      userToken: userToken == null ? this.userToken : userToken.value,
      userRefreshToken: userRefreshToken == null ? this.userRefreshToken : userRefreshToken.value,
      userTokenExpiresAt: userTokenExpiresAt == null ? this.userTokenExpiresAt : userTokenExpiresAt.value,
      userRefreshTokenExpiresAt: userRefreshTokenExpiresAt == null ? this.userRefreshTokenExpiresAt : userRefreshTokenExpiresAt.value,
      loadingStatus: loadingStatus ?? LoadingStatus.initial,
      userEmail: userEmail == null ? this.userEmail : userEmail.value,
      walkthroughStatus: walkthroughStatus ?? this.walkthroughStatus,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        authAppStatus,
        authUserStatus,
        error,
        applicationToken,
        applicationRefreshToken,
        applicationTokenExpiresAt,
        applicationRefreshTokenExpiresAt,
        userToken,
        userRefreshToken,
        userTokenExpiresAt,
        userRefreshTokenExpiresAt,
        loadingStatus,
        userEmail,
        walkthroughStatus,
      ];

  AuthenticationState clear() {
    return AuthenticationState(
      authAppStatus: AuthenticationAppStatus.unauthenticated,
      // applicationRefreshToken: null,
      // applicationRefreshTokenExpiresAt: applicationRefreshTokenExpiresAt,
      // applicationToken: null,
      applicationTokenExpiresAt: applicationTokenExpiresAt,
      walkthroughStatus: walkthroughStatus,
    );
  }

  AuthenticationState totalClear() {
    return AuthenticationState(
      authAppStatus: AuthenticationAppStatus.unauthenticated,
      applicationRefreshToken: null,
      applicationRefreshTokenExpiresAt: applicationRefreshTokenExpiresAt,
      applicationToken: null,
      applicationTokenExpiresAt: applicationTokenExpiresAt,
      walkthroughStatus: walkthroughStatus,
    );
  }
}
