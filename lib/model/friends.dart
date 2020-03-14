import 'package:Daboloo/http/base/base_model.dart';

class FriendList extends BaseModel {

  List<dynamic> friends;

  @override
  FriendList fromJson(Map<String, dynamic> json) {
    this.friends = json["friends"];
    return this;
  }

}