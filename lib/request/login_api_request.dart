import 'package:Daboloo/api/user_service.dart';
import 'package:Daboloo/callbacks/login_callback.dart';
import 'package:Daboloo/model/user.dart';
import 'package:Daboloo/http/http_request.dart';
import 'package:Daboloo/http/http_method.dart';

class LoginApiRequest {

  User _user = new User();

  LoginCallbackMixin loginCallback;

  LoginApiRequest(this.loginCallback);

  void userPasswordLogin(String username, String password) async {
    Map<String, dynamic> body = Map();
    body.addAll({
      "username": username,
      "password": password//Md5Utils.generateMd5(password)
    });

    await HttpRequest.request<String>(
        HttpMethod.POST,
        UserService.login,
        data: body,
        model: _user,
        success: (token) {
         loginCallback?.onUserLoginSuccess(token);
        }, error: (errorModel) {
          loginCallback?.onError(errorModel);
        });
  }

  userRegister(String username, String password) async {
    Map<String, dynamic> body = Map();
    body.addAll({
      "username": username,
      "password": password//Md5Utils.generateMd5(password)
    });

    await HttpRequest.request<String>(
        HttpMethod.POST,
        UserService.register,
        data: body,
        model: _user,
        success: (result) {
          loginCallback?.onUserRegisterSuccess(username, password);
        }, error: (errorModel) {
          loginCallback?.onError(errorModel);
    });
  }
}