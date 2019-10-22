import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:map_current_location/utils/default_markers.dart';

class AnimatedPage extends StatefulWidget {
  @override
  AnimatedPageState createState() {
    return AnimatedPageState();
  }
}

class AnimatedPageState extends State<AnimatedPage>
    with TickerProviderStateMixin {

  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(title: Text('Animated')),
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
                      _animatedMapMove(point1, 15.0);
                    },
                  ),
                  MaterialButton(
                    child: Text('point2'),
                    onPressed: () {
                      _animatedMapMove(point2, 15.0);
                    },
                  ),
                  MaterialButton(
                    child: Text('point3'),
                    onPressed: () {
                      _animatedMapMove(point3, 15.0);
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
                    minZoom: minZoom
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
