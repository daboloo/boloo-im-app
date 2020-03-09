import 'dart:async';
import 'dart:io';

import 'package:Daboloo/config.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestInterceptor extends Interceptor {

  static const String CONTENT_TYPE = "Content-Type";
  static const String USER_AGENT = "User-Agent";
  static const String AUTHORIZATION = "Authorization";

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(kSharedPreferenceUserToken);

    String userAgent;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      userAgent = "SmartOffice: Android;  ${androidInfo.manufacturer}; ${androidInfo.device};"
          " ${androidInfo.version.sdkInt};";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      userAgent = "SmartOffice: IOS; ${iosInfo.model}; ${iosInfo.systemName};"
          " ${iosInfo.systemVersion};";
    } else {
      userAgent = "SmartOffice: ${Platform.operatingSystem}; ${Platform.operatingSystemVersion}";
    }

    options.headers.addAll({
      AUTHORIZATION: token,
      USER_AGENT: userAgent,
    });
  }
}