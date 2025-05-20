import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsHelper {
  static void log(final String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  static void recordError(final Object exception, [final StackTrace? stack]) {
    log('Caught error: $exception');
    if (kDebugMode) {
      FlutterError.presentError(FlutterErrorDetails(exception: exception, stack: stack ?? StackTrace.current));
    } else {
      FirebaseCrashlytics.instance.recordError(
        exception,
        stack ?? StackTrace.current,
      );
    }
  }
}
