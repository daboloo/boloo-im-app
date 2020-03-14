
import 'package:Daboloo/api/chat_service.dart';
import 'package:Daboloo/callbacks/chat_callback.dart';
import 'package:Daboloo/http/http_method.dart';
import 'package:Daboloo/http/http_request.dart';
import 'package:Daboloo/model/friend.dart';
import 'package:Daboloo/model/friends.dart';

class ChatApiRequest {

  FriendList _friendList = FriendList();

  ChatCallbackMixin _chatCallbackMixin;

  ChatApiRequest(this._chatCallbackMixin);

  void getFriendList() async {
    await HttpRequest.request<FriendList>(
      HttpMethod.POST,
      ChatService.friend_list,
      model: _friendList,
      success: (friends) {
        _chatCallbackMixin?.onGetUserFriendListSuccess(friends);
      },
      error: (errorModel) {
        _chatCallbackMixin?.onError(errorModel);
      }
    );
  }
}