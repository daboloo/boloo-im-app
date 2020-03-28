import 'package:Daboloo/api/friend_service.dart';
import 'package:Daboloo/callbacks/add_friend_callback.dart';
import 'package:Daboloo/http/http_method.dart';
import 'package:Daboloo/http/http_request.dart';

class FriendApiRequest {

  AddFriendMixin _addFriendMixin;

  FriendApiRequest(this._addFriendMixin);

  void addFriend(String friendAccount) async {
    Map<String, dynamic> body = Map();
    body.addAll({
      "friendAccount": friendAccount,
    });

    await HttpRequest.request(
      HttpMethod.POST,
      FriendService.add_friend,
      data: body,
      success:(result) {
        _addFriendMixin?.onAddFriendSuccess();
      },
      error: (error) {
        _addFriendMixin?.onError(error.message);
      }
    );
  }
}