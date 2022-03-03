import 'dart:async';

import 'package:aman/ui/screens/main_screen.dart';
import 'package:aman/utils/preference_utils.dart';

import 'network/web_service.dart';
import 'ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceUtils.init();

    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WebService.context = context;

    return MaterialApp(
      title: 'Aman Agent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
        accentColor: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(title: 'Login'),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({Key key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PreferenceUtils.getString("apiKey","").isNotEmpty? MainScreen() :LoginForm(),
    );
  }
}