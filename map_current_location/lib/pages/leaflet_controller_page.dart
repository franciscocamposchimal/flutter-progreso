import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_current_location/utils/default_markers.dart';

class MapControllerPage extends StatefulWidget {
  @override
  MapControllerPageState createState() {
    return MapControllerPageState();
  }
}

class MapControllerPageState extends State<MapControllerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MapController mapController;
  double rotation = 0.0;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('MapController')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text('point1'),
                    onPressed: () {
                      mapController.move(point1, 18.0);
                    },
                  ),
                  MaterialButton(
                    child: Text('point2'),
                    onPressed: () {
                      mapController.move(point2, 18.0);
                    },
                  ),
                  MaterialButton(
                    child: Text('point3'),
                    onPressed: () {
                      mapController.move(point3, 18.0);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text('Fit Bounds'),
                    onPressed: () {
                      var bounds = LatLngBounds();
                      bounds.extend(point1);
                      bounds.extend(point2);
                      bounds.extend(point3);
                      mapController.fitBounds(
                        bounds,
                        options: FitBoundsOptions(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        ),
                      );
                    },
                  ),
                  MaterialButton(
                    child: Text('Get Bounds'),
                    onPressed: () {
                      final bounds = mapController.bounds;

                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                          'Map bounds: \n'
                          'E: ${bounds.east} \n'
                          'N: ${bounds.north} \n'
                          'W: ${bounds.west} \n'
                          'S: ${bounds.south}',
                        ),
                      ));
                    },
                  ),
                  Text('Rotation:'),
                  Expanded(
                    child: Slider(
                      value: rotation,
                      min: 0.0,
                      max: 360,
                      onChanged: (degree) {
                        setState(() {
                          rotation = degree;
                        });
                        mapController.rotate(degree);
                      },
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: meridaLatLng,
                  zoom: perfectZoom,
                  maxZoom: maxZoom,
                  minZoom: minZoom,
                ),
                layers: [
                  defaultTileLayerOptions,
                  MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
