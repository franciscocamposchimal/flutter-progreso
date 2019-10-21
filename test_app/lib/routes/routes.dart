
import 'package:flutter/widgets.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:test_app/pages/second_page.dart';
import 'package:test_app/pages/third_page.dart';

Map<String, WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    '/second': (BuildContext context) => SecondPage(),
    '/third': (BuildContext context) => ThirdPage(),
  };
}