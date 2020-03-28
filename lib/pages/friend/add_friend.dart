
import 'package:Daboloo/callbacks/add_friend_callback.dart';
import 'package:Daboloo/request/friend_api_request.dart';
import 'package:flutter/material.dart';

class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendStates createState() => _AddFriendStates();
}

class _AddFriendStates extends State<AddFriendPage> with AddFriendMixin {
  FriendApiRequest _friendApiRequest;
  
  
  @override
  void initState() {
    super.initState();
    _friendApiRequest = FriendApiRequest(this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("添加好友")),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: TextField(
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '搜索',
            prefixIcon: Icon(Icons.search),
          ),
          keyboardType: TextInputType.text,
          onSubmitted: (value) {
            _searchFriend(value);
          },
        ),
      )
    );
  }

  void _searchFriend(String value) {
    _friendApiRequest.addFriend(value);
  }

  ///////////////////////////////  接口回调  ///////////////////////////////////////////

  @override
  void onAddFriendSuccess() {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("好友申请成功")));
  }

  @override
  void onError(String errorMsg) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text(errorMsg)));
  }

}