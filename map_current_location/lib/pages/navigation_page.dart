import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  String _platformVersion = 'Unknown';
  final _origin =
      Location(name: "DW Medios Lab", latitude: 21.0116126, longitude: -89.6046292);
  final _destination =
      Location(name: "Zona Industrial", latitude: 21.0442782, longitude: -89.6432244);

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterMapboxNavigation.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text('Running on: $_platformVersion\n'),
            SizedBox(
              height: 60,
            ),
            RaisedButton(
              child: Text("Start Navigation"),
              onPressed: () async {
                await FlutterMapboxNavigation.startNavigation(
                    _origin, _destination);
              },
            )
          ],
        ),
      ),
    );
  }
}
