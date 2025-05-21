import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:{{name}}/src/core/constants/common_consts.dart';
import 'package:{{name}}/src/core/utils/dev/print_color.dart';
import 'package:{{name}}/src/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:{{name}}/src/cubits/common_data_cubit/common_data_cubit.dart';

class Http {
  Http._internal();

  static final Http _singleton = Http._internal();

  static Http get instance => _singleton;

  late Dio dio;
  late String domain;

  late String baseCartApi;

  final BaseOptions _options = BaseOptions(
    connectTimeout: const Duration(milliseconds: 30000),
    receiveTimeout: const Duration(milliseconds: 30000),
  );

  void init() {
    dio = Dio(_options);
    dio.interceptors.add(_authInterceptor());
    dio.interceptors.add(logger);
  }

  final InterceptorsWrapper logger = InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      print("AuthenticationCubit.instance.state.applicationToken");
      print(AuthenticationCubit.instance.state.applicationToken);
      print("AuthenticationCubit.instance.state.userToken");
      log(AuthenticationCubit.instance.state.userToken ?? "");

      print("options: ====== ${options.headers}");
      if (kDebugMode) {
        print(
          '${PrintColor.blue.paint('---- REQUEST --->')} ${PrintColor.blue.paint(options.method)} ${options.uri} --- Content type: ${options.contentType}',
        );
      }
      return handler.next(options);
    },
    onResponse: (Response<dynamic> response, ResponseInterceptorHandler handler) {
      if (kDebugMode) {
        print(
          '${PrintColor.green.paint('<--- RESPONSE ---')} ${PrintColor.green.paint(response.requestOptions.method)} ${response.statusCode} ${response.requestOptions.uri}',
        );
      }
      return handler.next(response);
    },
    onError: (DioException e, ErrorInterceptorHandler handler) {
      if (kDebugMode) {
        print(
          '${PrintColor.red.paint('<--- RESPONSE ---')} ${PrintColor.red.paint(e.requestOptions.method)} ${e.response?.statusCode} ${e.requestOptions.uri} --- ${e.message}',
        );
      }
      return handler.next(e);
    },
  );

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        if (!options.headers.containsKey('Authorization')) {
          final String token = (await AuthenticationCubit.instance.userToken) ?? "";

          if (token.isEmpty) {
            return handler.next(options);
          } else {
            // if (options.extra[CommonConsts.needsAccount] as bool? ?? true) {
            //   await AccountCubit.instance.getUserAccount();
            // }
          }
          options.headers.putIfAbsent("Authorization", () => 'Bearer $token');
        } else {
          if (!(options.extra[CommonConsts.appTokenRefresh] as bool? ?? false)) {
            print("***************************** Authorization header already exists *****************************");
            print("***************************** applicationTokenExpiresAt *****************************");
            print("***************************** ${AuthenticationCubit.instance.state.applicationTokenExpiresAt} *****************************");
            print("***********************************************************************************************");
            await AuthenticationCubit.instance.applicationToken;
          }
        }
        if (options.extra[CommonConsts.needsLocale] as bool? ?? true) {
          options.queryParameters
              .putIfAbsent('LanguageID', () => CommonDataCubit.instance.state.currentLanguage?.id ?? CommonDataCubit.instance.getSystemLanguage().id);
        }
        return handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        int retryCount = 0;
        const int maxRetries = 3;
        while (retryCount < maxRetries && e.type == DioExceptionType.connectionTimeout) {
          retryCount++;
          try {
            if (kDebugMode) {
              print('Connection timeout, retrying... $retryCount');
            }
            final Response<dynamic> res = await dio.request(e.requestOptions.path);
            return handler.resolve(res);
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        }
        return handler.next(e);
      },
    );
  }
}
