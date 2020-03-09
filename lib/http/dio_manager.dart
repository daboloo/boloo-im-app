import 'package:dio/dio.dart';

import 'base/base_api_config.dart';

class DioManager {
  static final DioManager _shared = DioManager._internal();
  factory DioManager() => _shared;
  Dio _dio;
  DioManager._internal() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: kBaseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: kConnectTimeout,
        receiveTimeout: 3000,
      );
      _dio = Dio(options);
    }
  }

  Dio get dio {
    return _dio;
  }
}