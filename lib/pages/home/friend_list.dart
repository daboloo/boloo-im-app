
import 'package:Daboloo/pages/friend/add_friend.dart';
import 'package:Daboloo/widget/RecyclerView.dart';
import 'package:flutter/material.dart';

class FriendListPage extends StatefulWidget {

  @override
  _FriendListState createState() => _FriendListState();

}

class _FriendListState extends State<FriendListPage> {

  List _friends = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的好友"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.people), onPressed: _findRequest)
        ],

      ),
      body: RecyclerView(
        _friends,
        headerList: [1],
        itemWidgetCreator: getFriendsItemWidget,
        headerCreator: (BuildContext buildContext, int position) {
          return Material(
            child: InkWell(
              onTap: () {
                _findNewFriend();
              },
              child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    border: BorderDirectional(bottom: BorderSide(color: Color(0xffcccccc)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add),
                      Text("添加好友", style: TextStyle(fontSize: 16.0),)
                    ],
                  )
              ),
            ),
          );
        },

      ),
    );
  }

  void _findRequest() {

  }

  void _findNewFriend() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriendPage()));
  }

  Widget getFriendsItemWidget(BuildContext context, int pos) {
    return Text("1");
  }

}