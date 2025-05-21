import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:{{name}}/src/core/enums/status_code.dart';
import 'package:{{name}}/src/services/network/api_response.dart';
import 'package:{{name}}/src/services/network/app_error.dart';
import 'package:{{name}}/src/services/network/http.dart';

class BaseApiService {
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
          // AuthenticationCubit.instance.logout();
          return AuthError.error(code: status, message: parseErrorMessage(dioError));
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
