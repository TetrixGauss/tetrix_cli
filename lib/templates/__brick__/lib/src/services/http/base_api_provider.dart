import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:{{name}}/network/app_error.dart';
import 'package:{{name}}/router/routes.dart';
import 'package:{{name}}/src/core/enums/status_code.dart';
import 'package:{{name}}/src/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:{{name}}/src/router/route_observer.dart';
import 'package:{{name}}/src/services/network/api_response.dart';
import 'package:{{name}}/src/services/network/http.dart';

class BaseApiProvider {
  final Dio dio = Http.instance.dio;

  String get baseCartApi => Http.instance.baseCartApi;

  static String parseErrorMessage(DioException error) {
    String errorMessage = error.response?.statusMessage ?? 'Unknown error';
    final Response<dynamic>? responseData = error.response;

    try {
      if (responseData?.data is String) {
        return responseData?.data;
      }

      final Map<String, dynamic>? data = responseData?.data;

      if (data != null) {
        final dynamic message = data['message'];
        if (message is String) {
          errorMessage = message;
        }
      }
    } catch (e) {
      return errorMessage;
    }

    return errorMessage;
  }

  AppError errorHandler(dynamic error, [StackTrace? stack]) {
    print('?????????????????? $error');
    if (error is DioException) {
      final DioException dioError = error;
      if ((dioError.type == DioExceptionType.unknown || dioError.type == DioExceptionType.connectionError) &&
          dioError.error != null &&
          dioError.error is SocketException) {
        return NetworkError.unknown(null, 'COMMON.ERROR.NO_INTERNET_CONNECTION'.tr(), null);
      }

      if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.sendTimeout ||
          dioError.type == DioExceptionType.receiveTimeout) {
        return NetworkError.requestTimeout()..report();
      }

      final int? status = dioError.response?.statusCode;
      switch (status) {
        case 403:
          return AuthError.invalidSession;
        case 401:
          try {
            for (final Route? element in AppRouteObserver.history) {
              print('element.settings.name: ${element!.settings.name}');
            }
            if (!Routes.starterRoutes.contains(AppRouteObserver.history.last!.settings.name)) {
              AuthenticationCubit.instance.logout();
            } else {}
          } catch (e) {
            print(e);
          }

          // return AuthError.error(code: status, message: LocaleKeys.wrongCredentials.tr() /*parseErrorMessage(dioError)*/);
          // return AuthError.wrongCredentials;
          return AuthError.wrongCredentials;
      }

      return AppError(code: dioError.response?.statusCode, message: parseErrorMessage(dioError), stack: error.stackTrace)..report();
    } else {
      return AppError(code: 477, message: error.toString(), stack: stack)..report(true);
    }
  }

  AppError? getStatusError(ApiResponse<dynamic> response, [Map<StatusCode, String>? statusTranslation]) {
    final StatusCode? statusCode = response.statusCode?.toStatusCode;
    if (statusCode != null) {
      final String? translation = statusTranslation?[statusCode];
      return AppError(code: response.statusCode, message: translation ?? response.statusCode?.toStatusCode?.message);
    }

    return response.error;
  }
}
