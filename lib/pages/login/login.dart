import 'package:Daboloo/callbacks/login_callback.dart';
import 'package:Daboloo/config.dart';
import 'package:Daboloo/pages/home/home_container.dart';
import 'package:Daboloo/request/login_api_request.dart';
import 'package:Daboloo/utils/shared_preference_utils.dart';
import 'package:Daboloo/http/base/error_data.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginCallbackMixin, SingleTickerProviderStateMixin {

  TabController _tabController;

  TextEditingController _controllerLoginUserName = TextEditingController();
  TextEditingController _controllerLoginPassword = TextEditingController();

  TextEditingController _controllerRegisterUserName = TextEditingController();
  TextEditingController _controllerRegisterPassword = TextEditingController();
  
  LoginApiRequest _httpRequest;

  List tabs = ["登录", "注册"];

  @override
  void initState() {
    super.initState();
    _httpRequest = LoginApiRequest(this);
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daboloo"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Material(
            color: Color(0xFF5D85E0),
            child: TabBar(
              indicator: BoxDecoration(color: Colors.lightBlue),
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList()
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          getLoginContainer(),
          getRegisterContainer()
        ],
      ),
    );
  }

  Widget getLoginContainer() {
    return Container(
      padding: EdgeInsets.only(top: 50),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            child: TextField(
              controller: _controllerLoginUserName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '用户名',
                prefixIcon: Icon(Icons.verified_user),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            child: TextField(
              controller: _controllerLoginPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '密码',
                prefixIcon: Icon(Icons.security),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 268,
                  child: RaisedButton(
                    onPressed: () {
                      _httpRequest.userPasswordLogin(_controllerLoginUserName.text,
                          _controllerLoginPassword.text);
                    },
                    child: Text(
                      '登录',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getRegisterContainer() {
    return Container(
      padding: EdgeInsets.only(top: 50),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            child: TextField(
              controller: _controllerRegisterUserName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '用户名',
                prefixIcon: Icon(Icons.verified_user),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            child: TextField(
              controller: _controllerRegisterPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '密码',
                prefixIcon: Icon(Icons.security),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 268,
                  child: RaisedButton(
                    onPressed: () {
                      _httpRequest.userRegister(_controllerRegisterUserName.text,
                          _controllerRegisterPassword.text);
                    },
                    child: Text(
                      '注册',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///////////////////////////////  接口回调  ///////////////////////////////////////////

  @override
  void onUserLoginSuccess(String token) {
    if (token != null) {
      SharedPreferenceUtils.saveString(kSharedPreferenceUserToken, token);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeContainerPage()),
              (Route<dynamic> rout) => false);
    }
  }

  @override
  void onUserRegisterSuccess(String username, String password) {
    //切换到登录界面
    SharedPreferenceUtils.saveString(kSharedPreferenceUserName, username);
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _controllerLoginUserName.text = username;
      _controllerLoginPassword.text = password;
      _tabController.animateTo(0);
    });
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("注册成功")));
  }

  @override
  void onError(ErrorData errorData) {
    print(errorData.message);
  }
}