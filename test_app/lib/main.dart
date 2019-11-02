import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:test_app/shared_preferences/shared_preferences.dart';
import 'package:test_app/bloc/provider.dart';
import 'package:test_app/pages/MainScreen.dart';
import 'package:test_app/utils/utils.dart' as utils;

import 'package:test_app/routes/routes.dart';
import 'package:test_app/theme/appTheme.dart';

//void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    utils.printDebug('state = $state');
    if(state == AppLifecycleState.inactive){
      print("LOGOUT");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          fontFamily: "Montserrat",
        ),
        //initialRoute: '/',
        home: MainScreen(),
        routes: getRoutes(),
      ),
    );
  }
}
