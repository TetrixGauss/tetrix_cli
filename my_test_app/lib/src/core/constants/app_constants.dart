class AppConstants {
  static String translationsPath = 'assets/translations';

  static const Duration timeBeforeTokenExpireToTriggerRefreshToken = Duration(minutes: 15);
  static const Duration refreshTokenInterval = Duration(minutes: 30);

  static const Duration acceptedTimeBeforeExpiration = Duration(minutes: 5);

  static const String tokenTypeParam = 'tokenType';
}
