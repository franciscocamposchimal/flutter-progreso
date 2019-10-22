import 'package:flutter/material.dart';
import 'package:map_current_location/pages/geolocator_page.dart';
import 'package:map_current_location/pages/home_page.dart';
import 'package:map_current_location/pages/leaflet_anchor_page.dart';
import 'package:map_current_location/pages/leaflet_animated_map_page.dart';
import 'package:map_current_location/pages/leaflet_controller_page.dart';
import 'package:map_current_location/pages/leaflet_first_page.dart';
import 'package:map_current_location/pages/leaflet_move_markers_page.dart';
import 'package:map_current_location/pages/navigation_page.dart';
import 'package:map_current_location/pages/search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomePage(),
        '/second': (BuildContext context) => GeoListenPage (),
        '/third': (BuildContext context) => SearchPage (),
        '/fourth': (BuildContext context) => LeaFirst (),
        '/fifth': (BuildContext context) => AnimatedPage (),
        '/sixth': (BuildContext context) => NavigationPage(),
        '/seventh': (BuildContext context) => MapControllerPage(),
        '/eighth': (BuildContext context) => MarkerAnchorPage(),
        '/nine': (BuildContext context) => MovingMarkersPage(),
      },
    );
  }
}