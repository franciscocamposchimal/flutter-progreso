import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_current_location/utils/default_markers.dart';

class LeaFirst extends StatefulWidget {
  @override
  _LeaFirstState createState() => _LeaFirstState();
}

class _LeaFirstState extends State<LeaFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaflet')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('This is a map that is showing (20.975030, -89.624465).'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: meridaLatLng,
                  zoom: perfectZoom,
                ),
                layers: [
                  defaultTileLayerOptions,
                  MarkerLayerOptions(markers: markers),
                  CircleLayerOptions(circles: circleMarkers)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
