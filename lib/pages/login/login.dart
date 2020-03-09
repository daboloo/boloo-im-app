import 'package:Daboloo/callbacks/login_callback.dart';
import 'package:Daboloo/config.dart';
import 'package:Daboloo/pages/home/home.dart';
import 'package:Daboloo/request/login_api_request.dart';
import 'package:Daboloo/utils/shared_preference_utils.dart';
import 'package:Daboloo/http/base/error_data.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginCallbackMixin {

  TextEditingController _controllerUserName = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  
  LoginApiRequest _httpRequest;

  @override
  void initState() {
    super.initState();
    _httpRequest = LoginApiRequest(this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 16,
              left: 16,
              bottom: 32,
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            child: TextField(
              controller: _controllerUserName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
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
              controller: _controllerPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
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
                      _httpRequest.userPasswordLogin(_controllerUserName.text,
                          _controllerPassword.text);
                    },
                    child: Text(
                      'Login',
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
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Hello, Daboloo!')),
              (Route<dynamic> rout) => false);
    }
  }

  @override
  void onUserRegisterSuccess(String username) {
    //切换到登录界面
    SharedPreferenceUtils.saveString(kSharedPreferenceUserName, username);
  }

  @override
  void onError(ErrorData errorData) {
    print(errorData.message);
  }
}