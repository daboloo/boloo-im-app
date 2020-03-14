
import 'package:dio/dio.dart';

import 'base/base_list_response_data.dart';
import 'base/base_model.dart';
import 'base/base_response_data.dart';
import 'base/error_data.dart';
import 'dio_manager.dart';
import 'http_method.dart';
import 'interceptors/cache_interceptor.dart';
import 'interceptors/request_interceptor.dart';

class HttpRequest {
  static Dio dio = DioManager().dio;

  /// 请求，返回参数为 T
  /// method：请求方法，HttpMethod.POST等
  /// path：请求地址
  /// params：请求参数
  /// model:
  /// success：请求成功回调
  /// error：请求失败回调
  static Future request<T>(HttpMethod method, String url,
      {Map<String, dynamic> data, Map<String, dynamic> params, BaseModel model,
        Function(T) success, Function(ErrorData) error}) async {
    // 1.单独相关的设置
    Options options = Options();
    options.method = HttpMethodValues[method];

    // 2.设置拦截器
    addInterceptors(dio);

    // 3.发送网络请求
    try {
      Response response = await dio.request(url, data: data, queryParameters: params, options: options);
      if (response != null) {
        BaseResponseData entity = BaseResponseData<T>.fromJson(model, response.data);
        if (entity.success) {
          if (success != null) {
            success(entity.data);
          }
        } else {
          if (error != null) {
            error(ErrorData(code: entity.code, message: entity.message));
          }
        }
      } else {
        if (error != null) {
          error(ErrorData(code: -1000, message: "未知错误"));
        }
      }
    } on DioError catch(e) {
      if (error != null) {
        error(createErrorEntity(e));
      }
    }
  }

  /// 请求，返回参数为 List<T>
  /// method：请求方法，HttpMethod.POST等
  /// path：请求地址
  /// data: post请求的data
  /// params：请求参数
  /// success：请求成功回调
  /// error：请求失败回调
  static Future requestList<T>(HttpMethod method, String url,
      {Map<String, dynamic> data, Map<String, dynamic> params, BaseModel model,
        Function(List<T>) success, Function(ErrorData) error}) async {
    // 1.单独相关的设置
    Options options = Options();
    options.method = HttpMethodValues[method];

    // 2.设置拦截器
    addInterceptors(dio);

    // 3.发送网络请求
    try {
      Response response = await dio.request(url, data: data, queryParameters: params, options: options);
      if (response != null) {
        BaseListResponseData entity = BaseListResponseData<T>.fromJson(model, response.data);
        if (entity.success) {
          if (success != null) {
            success(entity.data);
          }
        } else {
          if (error != null) {
            error(ErrorData(code: entity.code, message: entity.message));
          }
        }
      } else {
        if (error != null) {
          error(ErrorData(code: -1000, message: "未知错误"));
        }
      }
    } on DioError catch(e) {
      if (error != null) {
        error(createErrorEntity(e));
      }
    }
  }

  /// 错误信息
  static ErrorData createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:{
        return ErrorData(code: 1001, message: "请求取消");
      }
      break;
      case DioErrorType.CONNECT_TIMEOUT:{
        return ErrorData(code: 1002, message: "连接超时");
      }
      break;
      case DioErrorType.SEND_TIMEOUT:{
        return ErrorData(code: 1003, message: "请求超时");
      }
      break;
      case DioErrorType.RECEIVE_TIMEOUT:{
        return ErrorData(code: 1004, message: "响应超时");
      }
      break;
      case DioErrorType.RESPONSE:{
        try {
          int errCode = error.response.statusCode;
          String errMsg = error.response.statusMessage;
          return ErrorData(code: errCode, message: errMsg);
        } on Exception catch(_) {
          return ErrorData(code: 1000, message: "未知错误");
        }
      }
      break;
      default: {
        return ErrorData(code: 1005, message: error.message);
      }
    }
  }

  static Dio addInterceptors(Dio dio) {
    return dio
            ..interceptors
            .addAll([
              RequestInterceptor(),
              LogInterceptor(requestBody: true, responseBody: true),
              CacheInterceptor()
          ]);
  }
}