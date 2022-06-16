// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/utils.dart';

class ApiRepository {
  Dio? dio;

  ApiRepository(this.dio) {
    dio ??= Dio(
      BaseOptions(
        baseUrl: AppConfig.url,
        validateStatus: (status) => (status ?? 500) < 501,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      ),
    );

    final myInterceptor = InterceptorsWrapper(onError: (dioError, handler) {
      if (dioError.error is SocketException) {
        handler.resolve(noInternet(dioError.requestOptions));
      }
    });

    dio?.interceptors.add(PrettyDioLogger());
    dio?.interceptors.add(myInterceptor);
  }

  Response noInternet(RequestOptions options) {
    return Response(
      requestOptions: options,
      data: null,
      statusCode: 500,
      statusMessage: 'No Internet',
    );
  }
}
