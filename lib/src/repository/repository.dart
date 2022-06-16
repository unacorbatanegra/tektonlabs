import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../domain/domains.dart';

abstract class Repository<T> {
  final HiveInterface hiveInterface;

  Repository(this.hiveInterface);
  ApiRepository get repo => GetIt.I.get<ApiRepository>();
  Dio get dio => repo.dio!;
  // HiveRepository hive = HiveRepository<T>(hiveInterface);

  String get apiUrl => dio.options.baseUrl;
}
