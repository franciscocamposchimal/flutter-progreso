
import 'package:flutter/material.dart';
import 'package:printer/lib_dos.dart';
//import 'package:printer/lib_uno.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LiibDosPage(),//PrintUnoPage(title: 'Printer Demo'),
    );
  }
}

