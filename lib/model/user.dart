import 'package:Daboloo/http/base/base_model.dart';

class User extends BaseModel {
  String token;

  @override
  User fromJson(Map<String, dynamic> json) {
    this.token = json["data"];
    return this;
  }
}