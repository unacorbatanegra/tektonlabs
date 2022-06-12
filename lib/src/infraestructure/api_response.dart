import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

// import '../models/models.dart';
typedef FromJson<K> = K Function(Map<String, dynamic> json);

class ApiResponse<T> {
  static final _serializerMap = <Object, FromJson>{};

  static void register<J>(FromJson<J> fromJson) {
    if (_serializerMap.containsKey(J)) return;
    if (kDebugMode) {
      // ignore: avoid_print
      print('$J register an decoder ${fromJson.toString()}');
    }
    _serializerMap[J] = fromJson;
  }

  static ApiResponse<T> from<T>(
    Response response, {
    Function? converter,
  }) {
    var apiResponse = ApiResponse<T>(response);

    final body = response.data;
    converter ??= _serializerMap[T];

    apiResponse.fromJson(
      body,
      converter,
    );

    return apiResponse;
  }

  static ApiResponse<List<T>> fromOdata<T>(
    Response response, {
    Function? converter,
  }) {
    var apiResponse = ApiResponse<List<T>>(response);

    final body = response.data;
    converter ??= _serializerMap[T];
    if (body is Map) {
      if (body.containsKey('@odata.count')) {
        apiResponse.length = body['@odata.count'];
      }
    }
    // apiResponse.fromJson(
    //   body,
    //   converter,
    // );
    if ((response.statusCode ?? 500) >= 400) {
      apiResponse.data = [];
      return apiResponse;
    } else if (response.headers.value('content-type') ==
        'text/html; charset=utf-8') {
      apiResponse.data = [];
      return apiResponse;
    }
    apiResponse.data = body['value']
        .map<T>(
          (e) => converter!(e) as T,
        )
        .toList();
    // print('reached here');
    return apiResponse;
  }

  static ApiResponse<List<T>> fromList<T>(
    Response response,
    List Function(dynamic data) toData, {
    Function? converter,
  }) {
    var apiResponse = ApiResponse<List<T>>(response);
    if (response.data == null) return apiResponse;
    final body = response.data;

    // apiResponse.fromJson(
    //   body,
    //   converter,
    //   isOne: false,
    //   ignoreError: ignoreError,
    // );

    if (apiResponse.isError) return apiResponse;
    converter ??= _serializerMap[T];
    if (converter == null) {
      throw 'No converter found';
    }
    apiResponse.data = toData(body)
        .map<T>(
          (e) => converter!(e) as T,
        )
        .toList();

    return apiResponse;
  }

  late Response response;

  T? data;

  int length = 1;

  bool get hasData => data != null;

  bool get cancelled => response.statusCode == 0;

  // dynamic get jsonBody {
  //   if (response?.data is String) {
  //     return jsonDecode(response?.data as String);
  //   }
  //   return response?.data;
  // }

  // ApiResponse(this.response, this.data);
  ApiResponse(this.response, [this.data]);

  bool get isError {
    if ((response.statusCode ?? 500) >= 400) {
      return true;
    }
    if (response.headers.value('content-type') == 'text/html; charset=utf-8') {
      return true;
    }
    if (response.data is Map<String, dynamic>) {
      if (response.data.containsKey("Code")) {
        if (response.data['Code'] != 0) {
          return true;
        }
      }
    }
    return false;
  }

  bool get isNotError => !isError;

  String? get error => _error ?? response.statusMessage;

  String? _error;
  int? code;

  @override
  String toString() {
    return 'ApiResponse {isError=$isError, '
        'error=$error, '
        'code=${response.statusCode}, '
        'data=${response.data}}';
  }

  void fromJson(
    dynamic json,
    Function? converter, {
    bool isOne = true,
  }) {
    if (response.statusCode == 404) {
      json = null;
      code = response.statusCode;
      _error = 'Not found';
      return;
    }
    try {
      if (json == null) {
        json = null;
        code = 1;
        return;
      }
      if (json is String && json.isEmpty) {
        _error = 'Internal server error';
        code = 1;
        return;
      }

      // if (json is T) {
      //   print('enter hererere');
      //   data = json;
      //   // print('JSON IS STRING');
      //   status = 'OK';
      //   return;
      // }
      code = response.statusCode;
      if (json is Map) {
        if (json.containsKey('Message')) {
          _error = json['Message'];
        }
      } else {
        _error = response.statusMessage;
      }

      if (isOne) {
        data = converter?.call(json) as T?;
      }
    } on Exception {
      json = null;

      return;
    }
  }

  static ApiResponse fromResponse<T>(Response response) {
    var apiResponse = ApiResponse<T>(response);

    return apiResponse;
  }
}
