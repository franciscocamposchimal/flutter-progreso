import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/pages/login/home_page.dart';
import 'package:test_app/pages/login/splash_page.dart';
import 'package:test_app/pages/second_page.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        print('======SNAPSHOT======');
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Splash screen');
          return SplashPage();
        }
        if (!snapshot.hasData || snapshot.data == null) {
          print('Login screen');
          return HomePage();
        }else{
          return SecondPage();
        }
      },
    );
  }
}
