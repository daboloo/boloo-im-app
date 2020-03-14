import 'package:Daboloo/pages/home/chat_list.dart';
import 'package:Daboloo/pages/home/friend_list.dart';
import 'package:Daboloo/pages/home/profile.dart';
import 'package:flutter/material.dart';

class HomeContainerPage extends StatefulWidget {
  HomeContainerPage({Key key}) : super(key: key);

  @override
  _HomeContainerPageState createState() => _HomeContainerPageState();
}

class _HomeContainerPageState extends State<HomeContainerPage> {

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            unselectedItemColor: Color(0xFFCCCCCC),
            items: [
              createItem("ic_tab_message", "聊天"),
              createItem("ic_tab_home", "好友"),
              createItem("ic_tab_my", "我的")
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }
        ),
        body: IndexedStack(
            index: _currentIndex,
            children: <Widget>[
              ChatListPage(),
              FriendListPage(),
              MyProfile()
            ]
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  BottomNavigationBarItem createItem(String iconName, String tabTitle) {
    return BottomNavigationBarItem(
        icon: Image.asset("assets/images/$iconName.png"),
        activeIcon: Image.asset("assets/images/${iconName}_01.png"),
        title: Text(tabTitle)
    );
  }
}