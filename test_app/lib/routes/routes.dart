
import 'package:flutter/widgets.dart';
import 'package:test_app/pages/home_page.dart';

Map<String, WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
  };
}