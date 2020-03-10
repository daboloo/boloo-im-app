import 'package:Daboloo/http/base/error_data.dart';

mixin LoginCallbackMixin {

  void onUserLoginSuccess(String username);

  void onUserRegisterSuccess(String username, String password);

  void onError(ErrorData errorData);
}