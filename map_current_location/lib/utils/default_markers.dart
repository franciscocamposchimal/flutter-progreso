import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

final perfectZoom = 11.8;
//final farAwayzoom = 5.0;
final maxZoom = 20.0;
final minZoom = 3.0;

final widthAndHeight = 80.0;

final meridaLatLng = LatLng(20.975030, -89.624465);

final defaultTileLayerOptions = TileLayerOptions(
  urlTemplate: "https://api.tiles.mapbox.com/v4/"
      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
  additionalOptions: {
    'accessToken':
        'pk.eyJ1IjoiZnJhbmtvY2FtcG9zIiwiYSI6ImNqbGRiMmJlMzA5ZG0zd3BjendmNTF5NmgifQ.tCQ9eJCRKnADR-AN6VQSFQ',
    'id': 'mapbox.streets',
  },
);

final LatLng point1 = LatLng(20.938605, -89.652661);
final LatLng point2 = LatLng(21.023233, -89.634129);
final LatLng point3 = LatLng(20.983489, -89.579185);

final markers = <Marker>[
  Marker(
    width: widthAndHeight,
    height: widthAndHeight,
    point: point1,
    builder: (ctx) => Container(
      child: Icon(
        Icons.location_on,
        color: Colors.green[700],
        size: 36.0,
      ),
    ),
  ),
  Marker(
    width: widthAndHeight,
    height: widthAndHeight,
    point: point2,
    builder: (ctx) => Container(
      child: Icon(
        Icons.location_on,
        color: Colors.deepPurple,
        size: 36.0,
      ),
    ),
  ),
  Marker(
    width: widthAndHeight,
    height: widthAndHeight,
    point: point3,
    builder: (ctx) => Container(
      child: Icon(
        Icons.location_on,
        color: Colors.lightBlue[700],
        size: 36.0,
      ),
    ),
  ),
];

final circleMarkers = <CircleMarker>[
  CircleMarker(
      point: LatLng(20.971921, -89.621165),
      color: Colors.blue.withOpacity(0.7),
      borderStrokeWidth: 2,
      useRadiusInMeter: true,
      radius: 2000 // 2000 meters | 2 km
      ),
];
