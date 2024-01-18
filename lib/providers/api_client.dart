import "package:dio/dio.dart";

import '../logger.dart';

class WashingMachineHttpClient {
  // static const String androidLocalhost = "10.0.2.2";
  // static const String defaultLocalhost = "0.0.0.0";

  static const String serverAddress = "192.168.1.21:49152";

  final options = BaseOptions(
    baseUrl: "http://$serverAddress/v1/",
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
