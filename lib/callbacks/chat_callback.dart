import 'package:Daboloo/http/base/error_data.dart';
import 'package:Daboloo/model/friends.dart';

mixin ChatCallbackMixin {

  void onGetUserFriendListSuccess(FriendList friends);

  void onError(ErrorData errorData);
}