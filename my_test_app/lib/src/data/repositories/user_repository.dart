import 'package:dio/dio.dart';

import 'src/core/constants/api_consts.dart';
import 'src/core/constants/common_consts.dart';
import 'src/cubits/authentication_cubit/authentication_cubit.dart';
import 'src/cubits/common_data_cubit/common_data_cubit.dart';
import 'src/services/http/base_api_provider.dart';
import 'src/services/network/api_response.dart';

class UserRepository extends BaseApiProvider {
  UserRepository._internal();

  static final UserRepository _singleton = UserRepository._internal();

  static UserRepository get instance => _singleton;

  Map<String, dynamic> queryParameters = <String, dynamic>{
    'LanguageID': CommonDataCubit.instance.state.currentLanguage?.id ?? CommonDataCubit.instance.getSystemLanguage().id,
  };

  static Future<String?> get _getAppToken async {
    if (!(await AuthenticationCubit.instance.checkApplicationTokenValidation())) {
      await AuthenticationCubit.instance.getApplicationToken(onlyToken: true);
    }

    return AuthenticationCubit.instance.state.applicationToken;
  }

  static Future<Options> get options async {
    return Options(headers: <String, dynamic>{"Authorization": "Bearer ${await _getAppToken}"});
  }

  /// getUserToken
  Future<ApiResponse<Map<String, dynamic>>> getUserToken({
    required String userName,
    required String password,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        ApiConsts.tokenUrl,
        options: (await options).copyWith(extra: <String, dynamic>{CommonConsts.needsLocale: false}),
        data: FormData.fromMap(<String, dynamic>{
          "grant_type": "password",
          "username": userName,
          "password": password,
          'LanguageID': CommonDataCubit.instance.state.currentLanguage?.id ?? CommonDataCubit.instance.getSystemLanguage().id,
        }),
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

  Future<ApiResponse<Map<String, dynamic>>> refreshToken(String refreshToken) async {
    print('refreshToken for USER');
    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      });

      final Response<dynamic> response = await Dio().post(
        ApiConsts.tokenUrl,
        options: (await options).copyWith(extra: <String, dynamic>{CommonConsts.appTokenRefresh: false}),

        // Options(
        //   headers: <String, dynamic>{"Content-Type": "application/x-www-form-urlencoded"},
        //   extra: <String, dynamic>{CommonConsts.needsLocale: false},
        // ),
        data: formData,
      );

      print('refreshToken: $response');
      return ApiResponse<Map<String, dynamic>>.factory(response, (dynamic json) => json);
    } on DioException catch (e) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e));
    } catch (e, stack) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e, stack));
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> login({
    required String userName,
    required String password,
    required String code,
    required bool longTimeLogin,
  }) async {
    try {
      final Response<dynamic> response = await dio.put(
        ApiConsts.login,
        data: <String, Object>{
          'Login': userName,
          'Password': password,
          'Code': code,
          'LongTimeLogin': longTimeLogin,
        },
      );
      return ApiResponse<Map<String, dynamic>>.factory(response, (dynamic json) => json);
    } on DioException catch (e) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e));
    } catch (e, stack) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e, stack));
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> logout() async {
    try {
      final Response<dynamic> response = await dio.put(
        ApiConsts.logout,
      );
      return ApiResponse<Map<String, dynamic>>.factory(response, (dynamic json) => json);
    } on DioException catch (e) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e));
    } catch (e, stack) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e, stack));
    }
  }

  // Future<ApiResponse<Map<String, dynamic>>> deleteUser({required String otp, required String otpVerificationCode}) async {
  //   try {
  //     final Response<dynamic> response = await dio.post(
  //       ApiConsts.deleteUserAccountUrl,
  //       queryParameters: <String, dynamic>{
  //         "EmailOTP.OTP": otp,
  //         "EmailOTP.VerificationCode": otpVerificationCode,
  //       },
  //     );
  //     print('response: $response');
  //     print('statusCode: ${response.statusCode}');
  //     return ApiResponse<Map<String, dynamic>>.factory(response, (dynamic json) => json);
  //   } on DioException catch (e) {
  //     return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e));
  //   } catch (e, stack) {
  //     return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e, stack));
  //   }
  // }
}
