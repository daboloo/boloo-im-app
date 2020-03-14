import 'package:Daboloo/callbacks/chat_callback.dart';
import 'package:Daboloo/http/base/error_data.dart';
import 'package:Daboloo/model/friends.dart';
import 'package:Daboloo/request/chat_api_request.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatListPage> with ChatCallbackMixin{

  ChatApiRequest _chatApiRequest;

  @override
  void initState() {
    super.initState();
    _chatApiRequest = ChatApiRequest(this);
    _chatApiRequest.getFriendList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daboloo")),
      body: ListView(

      ),
    );
  }

  @override
  void onGetUserFriendListSuccess(FriendList friends) {

  }

  @override
  void onError(ErrorData errorData) {
  }
}