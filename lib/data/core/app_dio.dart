import 'package:books_app/data/core/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

final class AppDio with DioMixin implements Dio {
  AppDio([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      contentType: Headers.jsonContentType,
      connectTimeout: Duration(seconds: connectTimeout),
      sendTimeout: Duration(seconds: sendTimeout),
      receiveTimeout: Duration(seconds: receiveTimeout),
    );

    this.options = options;

    httpClientAdapter = IOHttpClientAdapter();

    interceptors
      ..add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          requestHeader: false,
        ),
      )
      ..add(InterceptorsWrapper(onRequest: _onRequest));
  }

  final connectTimeout = 20;
  final sendTimeout = 30;
  final receiveTimeout = 10;

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    handler.next(options);
  }
}
