import 'base_model.dart';

class BaseResponseData<T> {
  int code;
  String message;
  bool success;
  T data;

  BaseResponseData({this.code, this.message, this.success, this.data});

  factory BaseResponseData.fromJson(BaseModel baseModel, json) {
    return BaseResponseData(
      code: json["errorCode"],
      message: json["errorMsg"],
      success: json["success"],
      data: (json != null) ? (json["data"] is String) ?
      json["data"] : baseModel?.fromJson(json["data"]) : null
    );
  }
}