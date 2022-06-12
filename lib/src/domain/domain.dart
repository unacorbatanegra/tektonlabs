import 'package:dio/dio.dart';

import 'domains.dart';

export '../../src/utils/utils.dart';
export '../infraestructure/infraestructures.dart';
export '../models/models.dart';
export '../repository/repositories.dart';

abstract class Domain<T> {
  void init();


  void showError(
    ApiResponse? response, {
    String? error,
  }) =>
      DialogHelper.showError(
        error ?? response?.error ?? '',
      );
  void showSucces(
    String message,
  ) =>
      DialogHelper.showSuccess(
        message,
      );
  Options noLog() => Options(
        extra: {
          'noLog': true,
        },
      );

  void register<J>(FromJson<J> fromJson) => ApiResponse.register<J>(fromJson);
}
