import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class GeoListenPage extends StatefulWidget {
  @override
  _GeoListenPageState createState() => _GeoListenPageState();
}

class _GeoListenPageState extends State<GeoListenPage> {
  Geolocator geolocator = Geolocator();

  List<Placemark> userLocation;

  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      _geocoding(position).then((list) {
        userLocation = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : _vals(userLocation),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () async {
                  Position current = await _getLocation();
                  List<Placemark> data = await _geocoding(current);
                  setState(() {
                    userLocation = data;
                  });
                },
                color: Colors.blue,
                child: Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vals(List<Placemark>  placemark) {
    return Column(
      children: <Widget>[
        Text(
            'Lat: ${placemark[0].position.latitude} , Long: ${placemark[0].position.longitude}'),
        Text(
            'Country: ${placemark[0].country} , Locality: ${placemark[0].locality}'),
        Text('Postal code: ${placemark[0].postalCode}'),
        Text('isoCountryCode: ${placemark[0].isoCountryCode}'),
        Text('Col: ${placemark[0].subLocality}'),
        Text('subThoroughfare: ${placemark[0].subThoroughfare}'),
        Text('thoroughfare: ${placemark[0].thoroughfare}'),
      ],
    );
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Future<List<Placemark>> _geocoding(Position userLocation) async {
    return await Geolocator().placemarkFromCoordinates(
        userLocation.latitude, userLocation.longitude);
  }
}
