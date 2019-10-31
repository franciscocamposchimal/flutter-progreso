import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/pages/login/home_page.dart';
import 'package:test_app/pages/login/splash_page.dart';
import 'package:test_app/pages/second_page.dart';
import 'package:test_app/shared_preferences/shared_preferences.dart';
//import 'package:test_app/utils/utils.dart';

class MainScreen extends StatelessWidget {
  final _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        print('======SNAPSHOT======');
        //printSuccess(snapshot.data.toString());
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Splash screen');
          return SplashPage();
        }
        if (!snapshot.hasData || snapshot.data == null) {
          print('Login screen');
          return HomePage();
        } else {
          _prefs.user = snapshot.data;
          return SecondPage();
        }
      },
    );
  }
}
