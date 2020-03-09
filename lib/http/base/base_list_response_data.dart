

import 'base_model.dart';

class BaseListResponseData<T> {
  int code;
  String message;
  bool success;
  List<T> data;

  BaseListResponseData({this.code, this.message, this.success, this.data});

  factory BaseListResponseData.fromJson(BaseModel baseModel, json) {
    List<T> data = new List<T>();
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((item) {
        data.add(baseModel.fromJson(item));
      });
    }

    return BaseListResponseData(
      code: json["code"],
      message: json["msg"],
      success: json["success"],
      data: data,
    );
  }
}