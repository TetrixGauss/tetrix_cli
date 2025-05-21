import 'package:dio/dio.dart';
import 'package:{{name}}/src/services/network/app_error.dart';

class ApiResponse<T> {
  ApiResponse({
    required this.success,
    this.statusCode,
    this.error,
    this.data,
  });

  ApiResponse.fromData(T this.data)
      : success = true,
        statusCode = 200,
        error = null;

  ApiResponse.factory(Response<dynamic> response, Function(dynamic json) factory)
      : success = _validateSuccess(response),
        statusCode = response.statusCode,
        data = factory(response.data),
        error = null;

  ApiResponse.withError(this.error)
      : success = false,
        statusCode = error?.code,
        data = null;

  static bool _validateSuccess<T>(Response<T> response) {
    return (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300;
  }

  final int? statusCode;
  final bool success;
  final AppError? error;
  final T? data;

  @override
  String toString() {
    return 'ApiResponse<$T>( statusCode: $statusCode, success: $success, error: $error, data: $data )';
  }
}
