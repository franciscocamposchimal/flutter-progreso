import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_current_location/utils/default_markers.dart';

class MovingMarkersPage extends StatefulWidget {
  
  @override
  _MovingMarkersPageState createState() {
    return _MovingMarkersPageState();
  }
}

class _MovingMarkersPageState extends State<MovingMarkersPage> {
  Marker _marker;
  Timer _timer;
  int _markerIndex = 0;

  @override
  void initState() {
    super.initState();
    _marker = markers[_markerIndex];
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _marker = markers[_markerIndex];
        _markerIndex = (_markerIndex + 1) % markers.length;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('This is a map that is showing (51.5, -0.9).'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: meridaLatLng,
                  zoom: perfectZoom,
                ),
                layers: [
                  defaultTileLayerOptions,
                  MarkerLayerOptions(markers: <Marker>[_marker])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
