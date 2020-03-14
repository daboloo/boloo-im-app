import 'package:Daboloo/config.dart';
import 'package:Daboloo/pages/home/home_container.dart';
import 'package:Daboloo/pages/login/login.dart';
import 'package:Daboloo/pages/navigator_manager.dart';
import 'package:Daboloo/utils/shared_preference_utils.dart';
import 'package:flutter/material.dart';

void main() => initializeAppData();

void initializeAppData() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferenceUtils.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daboloo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF5D85E0)
      ),
      home: NewHome(),
      navigatorKey: RouteManager.navigatorKey,
      navigatorObservers: [NavigatorManager.getInstance()],
    );
  }
}

class NewHome extends StatefulWidget {

  @override
  _NewHomeStates createState() => _NewHomeStates();
}

class _NewHomeStates extends State<NewHome> {

  Widget _newHome;

  @override
  void initState() {
    super.initState();

    SharedPreferenceUtils.getString(kSharedPreferenceUserToken).then((token) {
      Widget firstPage;
      if (token != null && token != "") {
        firstPage = HomeContainerPage();
      } else {
        firstPage = LoginPage();
      }
      setState(() {
        _newHome = firstPage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _newHome,
    );
  }

}

