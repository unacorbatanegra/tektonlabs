import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../domain/domains.dart';

abstract class Repository {
  ApiRepository get repo => GetIt.I.get<ApiRepository>();
  Dio get dio => repo.dio;

  String get apiUrl => dio.options.baseUrl;
}
