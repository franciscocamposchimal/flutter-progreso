import 'package:flutter/material.dart';

final List<Map<String, dynamic>> menu = [
  {'title': 'geolocator', 'icon': Icons.add_location, 'route': '/second'},
  {
    'title': 'leaflet markers, circles',
    'icon': Icons.edit_location,
    'route': '/fourth'
  },
  {'title': 'leaflet animated', 'icon': Icons.location_off, 'route': '/fifth'},
  {
    'title': 'mapbox navigation',
    'icon': Icons.location_searching,
    'route': '/sixth'
  },
  {
    'title': 'search and examples',
    'icon': Icons.location_disabled,
    'route': '/third'
  },
  {
    'title': 'leaflet controller',
    'icon': Icons.location_on,
    'route': '/seventh'
  },
  {'title': 'leaflet anchor', 'icon': Icons.error, 'route': '/eighth'},
  {'title': 'Move anchor', 'icon': Icons.lock_open, 'route': '/nine'},
];