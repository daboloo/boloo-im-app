
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

  static Future<T> getRequest<T>(String url, {Map<String, dynamic> params}) async {
    // 1.单独相关的设置
    Options options = Options();
    options.method = "get";

    List<String> splits = url.split(":");
    String path = url;

    if (splits.length >= 2) {
      path = splits[1];
      options.extra = {
        "gateway": splits[0]
      };
    }

    // 2.设置拦截器
    addInterceptors(dio);
    // 3.发送网络请求
    try {

      Response response = await dio.get<T>(path, queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      throw e;
    }
  }

  static Future<T> postRequest<T>(String url, {Map<String, dynamic> data, Map<String, dynamic> params}) async {
    // 1.单独相关的设置
    Options options = Options();
    options.method = "post";

    List<String> splits = url.split(":");
    String path = url;

    if (splits.length >= 2) {
      path = splits[1];
      options.extra = {
        "gateway": splits[0]
      };
    }

    // 2.设置拦截器
    addInterceptors(dio);
    // 3.发送网络请求
    try {

      Response response = await dio.post<T>(path, data: data, queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      throw e;
    }
  }

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
          success(entity.data);
        } else {
          error(ErrorData(code: entity.code, message: entity.message));
        }
      } else {
        error(ErrorData(code: -1000, message: "未知错误"));
      }
    } on DioError catch(e) {
      error(createErrorEntity(e));
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
          success(entity.data);
        } else {
          error(ErrorData(code: entity.code, message: entity.message));
        }
      } else {
        error(ErrorData(code: 1000, message: "未知错误"));
      }
    } on DioError catch(e) {
      error(createErrorEntity(e));
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
             LogInterceptor(requestBody: true, responseBody: true),
             CacheInterceptor(),
             RequestInterceptor()
          ]);
  }
}