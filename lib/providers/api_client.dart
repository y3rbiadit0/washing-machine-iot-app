import "package:dio/dio.dart";

import '../logger.dart';

class WashingMachineHttpClient {
  final options = BaseOptions(
    baseUrl: "http://0.0.0.0:8000/v1/",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  Dio get dioClient {
    Dio dio = Dio(options);
    dio.interceptors.add(ApiInterceptors());
    return dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('REQUEST[${options.method}][${options.baseUrl}${options.path}]');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.i(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger
        .i('RESPONSE[${response.statusCode}][${response.requestOptions.path}]');
    super.onResponse(response, handler);
  }
}
