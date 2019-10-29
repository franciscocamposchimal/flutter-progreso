
import 'package:flutter/widgets.dart';
import 'package:test_app/pages/login/home_page.dart';
import 'package:test_app/pages/login/reset_password.dart';
import 'package:test_app/pages/login/sign_up_page.dart';
import 'package:test_app/pages/login/splash_page.dart';
import 'package:test_app/pages/second_page.dart';
import 'package:test_app/pages/third_page.dart';

Map<String, WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/home': (BuildContext context) => HomePage(),
    '/second': (BuildContext context) => SecondPage(),
    '/third': (BuildContext context) => ThirdPage(),
    '/splash': (BuildContext context) => SplashPage(),
    '/signup': (BuildContext context) => SignupPage(),
    '/resetPassword': (BuildContext context) => ResetPasswordPage(),
  };
}