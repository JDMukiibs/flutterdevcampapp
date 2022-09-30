import 'package:dio/dio.dart';
import 'package:news_app/app_constants/app_constants.dart';
import 'package:news_app/services/exceptions/exceptions.dart';
import 'package:news_app/services/services.dart';

class DioHttpService implements HttpService {
  late final Dio _dio;

  DioHttpService({
    Dio? dioOverride,
  }) {
    _dio = Dio(baseOptions);
  }

  @override
  String get baseUrl => AppConfigs.baseUrl;

  @override
  Map<String, String> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': AppConfigs.newsApiKey,
      };

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        responseType: ResponseType.json,
      );

  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {

    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } catch (e) {
      throw HttpException(
        title: AppStrings.httpExceptionTitle,
        statusCode: e is DioError ? e.response?.statusCode : 500,
        message: e is DioError ? e.response?.statusMessage : e.toString(),
      );
    }

    throw HttpException();
  }
}
