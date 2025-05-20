import 'src/core/utils/helpers/crashlytics_helper.dart';

class AppError {
  AppError({
    this.code,
    this.message,
    this.stack,
  });

  final int? code;
  final dynamic message;
  final StackTrace? stack;

  void report([bool sendToFirebase = false]) {
    CrashlyticsHelper.recordError(message, stack);
  }

  static void reportError(dynamic e, [StackTrace? stack]) {
    CrashlyticsHelper.recordError(e, stack);
  }

  @override
  String toString() {
    return 'AppError { code: $code, message: $message }';
  }
}

class AuthError {
  static final AppError invalidSession = AppError(message: 'Invalid authorization token');
  static final AppError wrongCredentials = AppError(message: 'Τα στοιχεία που πληκτρολόγησες είναι λάθος. Προσπάθησε ξανά.');

  //401 on login/register with Text Constant
  // static final AppError wrongCredentials = AppError(message: LocaleKeys.wrongCredentials.tr());

  static AppError error({int? code, String? message, StackTrace? stack}) {
    return AppError(code: code, message: message, stack: stack);
  }
}

class NetworkError {
  static AppError unknown(int? code, String? message, StackTrace? stack) => AppError(
        code: code,
        message: message,
        stack: stack,
      );

  static AppError requestTimeout() => AppError(message: 'Request timeout');
}
