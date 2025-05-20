import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/core/constants/api_consts.dart';
import 'src/core/constants/common_consts.dart';
import 'src/services/http/base_api_provider.dart';
import 'src/services/network/api_response.dart';

class AuthRepository extends BaseApiProvider {
  AuthRepository._internal();

  static final AuthRepository _singleton = AuthRepository._internal();

  static AuthRepository get instance => _singleton;

  static Options get options {
    return Options(headers: <String, dynamic>{"Authorization": ""});
  }

  /// get application token
  Future<ApiResponse<Map<String, dynamic>>> getApplicationToken() async {
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'grant_type': 'client_credentials',
      'client_id': dotenv.env["CLIENT_ID"],
      'client_secret': dotenv.env["CLIENT_SECRET"],
    });

    try {
      final Response<dynamic> response = await Dio().post(
        ApiConsts.tokenUrl,
        options: options,
        data: formData,
      );
      print('response: $response');
      print('statusCode: ${response.statusCode}');

      return ApiResponse<Map<String, dynamic>>.factory(response, (dynamic json) => json);
    } on DioException catch (e) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e));
    } catch (e, stack) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e, stack));
    }
  }

  /// Refresh token
  Future<ApiResponse<Map<String, dynamic>>> refreshToken(String refreshToken) async {
    print('refreshToken for APP');
    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      });

      final Response<dynamic> response = await Dio().post(
        ApiConsts.tokenUrl,
        options: options.copyWith(extra: <String, dynamic>{CommonConsts.appTokenRefresh: true}),
        data: formData,
      );
      return ApiResponse<Map<String, dynamic>>.factory(response, (dynamic json) => json);
    } on DioException catch (e) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e));
    } catch (e, stack) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e, stack));
    }
  }
}
