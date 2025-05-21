import 'package:dio/dio.dart';
import 'package:{{name}}/src/core/constants/api_consts.dart';
import 'package:{{name}}/src/core/constants/common_consts.dart';
import 'package:{{name}}/src/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:{{name}}/src/cubits/common_data_cubit/common_data_cubit.dart';
import 'package:{{name}}/src/data/models/country_model_netv/country_model_netv.dart';
import 'package:{{name}}/src/data/models/language.dart';
import 'package:{{name}}/src/services/http/base_api_provider.dart';
import 'package:{{name}}/src/services/network/api_response.dart';

class CommonDataRepository extends BaseApiProvider {
  CommonDataRepository._internal();

  static final CommonDataRepository _singleton = CommonDataRepository._internal();

  static CommonDataRepository get instance => _singleton;

  static Future<String> get _getAppToken async {
    await AuthenticationCubit.instance.checkApplicationTokenValidation();
    return AuthenticationCubit.instance.state.applicationToken ?? "";
  }

  static Future<Options> get options async {
    return Options(headers: <String, dynamic>{"Authorization": "Bearer ${await _getAppToken}"});
  }

  Future<ApiResponse<List<Language>>> getLanguages() async {
    try {
      final Response<dynamic> response = await dio.get(
        ApiConsts.languagesUrl,
        options: (await options).copyWith(extra: <String, dynamic>{CommonConsts.needsLocale: false}),
      );
      return ApiResponse<List<Language>>.factory(response, (dynamic json) => Language.fromJsonList(json));
    } on DioException catch (e) {
      return ApiResponse<List<Language>>.withError(errorHandler(e));
    } catch (e, stack) {
      return ApiResponse<List<Language>>.withError(errorHandler(e, stack));
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> getTextConstants() async {
    try {
      final Response<dynamic> response = await dio.get(
        ApiConsts.textConstantsUrl.replaceAll('{{language}}',
            CommonDataCubit.instance.state.currentLanguage?.id.toString() ?? CommonDataCubit.instance.getSystemLanguage().id.toString()),
        options: (await options).copyWith(extra: <String, dynamic>{CommonConsts.needsLocale: false}),
      );
      return ApiResponse<Map<String, dynamic>>.factory(response, (dynamic json) => json);
    } on DioException catch (e) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e));
    } catch (e, stack) {
      return ApiResponse<Map<String, dynamic>>.withError(errorHandler(e, stack));
    }
  }

  Future<ApiResponse<List<CountryModelNetv>>> getCountryCodes() async {
    // final Map<String, dynamic> extras = <String, dynamic>{CommonConsts.needsLocale: false};
    // options.extra = extras;
    // Options options = Options(headers: <String, dynamic>{"Authorization": "Bearer $_getAppToken"}, extra: <String, dynamic>{CommonConsts.needsLocale: false});
    try {
      final Response<dynamic> response = await dio.get(
        ApiConsts.globalizationUrl,
        options: await options,
      );
      return ApiResponse<List<CountryModelNetv>>.factory(response, (dynamic json) => CountryModelNetv.fromJsonList(json));
    } on DioException catch (e) {
      return ApiResponse<List<CountryModelNetv>>.withError(errorHandler(e));
    } catch (e, stack) {
      return ApiResponse<List<CountryModelNetv>>.withError(errorHandler(e, stack));
    }
  }
}
