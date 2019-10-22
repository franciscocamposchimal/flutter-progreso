import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_current_location/utils/default_markers.dart';

class MarkerAnchorPage extends StatefulWidget {
  @override
  MarkerAnchorPageState createState() {
    return MarkerAnchorPageState();
  }
}

class MarkerAnchorPageState extends State<MarkerAnchorPage> {
  AnchorPos anchorPos;

  @override
  void initState() {
    super.initState();
    anchorPos = AnchorPos.align(AnchorAlign.center);
  }

  void _setAnchorAlignPos(AnchorAlign alignOpt) {
    setState(() {
      anchorPos = AnchorPos.align(alignOpt);
    });
  }

  void _setAnchorExactlyPos(Anchor anchor) {
    setState(() {
      anchorPos = AnchorPos.exactly(anchor);
    });
  }

  @override
  Widget build(BuildContext context) {
    var customMarkers = <Marker>[
      Marker(
        width: widthAndHeight,
        height: widthAndHeight,
        point: point1,
        builder: (ctx) => Container(
          child: FlutterLogo(),
        ),
        anchorPos: anchorPos,
      ),
      Marker(
        width: widthAndHeight,
        height: widthAndHeight,
        point: point2,
        builder: (ctx) => Container(
          child: FlutterLogo(
            colors: Colors.green,
          ),
        ),
        anchorPos: anchorPos,
      ),
      Marker(
        width: widthAndHeight,
        height: widthAndHeight,
        point: point3,
        builder: (ctx) => Container(
          child: FlutterLogo(colors: Colors.purple),
        ),
        anchorPos: anchorPos,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Marker Anchor Points')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                  'Markers can be anchored to the top, bottom, left or right.'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text('Left'),
                    onPressed: () => _setAnchorAlignPos(AnchorAlign.left),
                  ),
                  MaterialButton(
                    child: Text('Right'),
                    onPressed: () => _setAnchorAlignPos(AnchorAlign.right),
                  ),
                  MaterialButton(
                    child: Text('Top'),
                    onPressed: () => _setAnchorAlignPos(AnchorAlign.top),
                  ),
                  MaterialButton(
                    child: Text('Bottom'),
                    onPressed: () => _setAnchorAlignPos(AnchorAlign.bottom),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text('Center'),
                    onPressed: () => _setAnchorAlignPos(AnchorAlign.center),
                  ),
                  MaterialButton(
                    child: Text('Custom'),
                    onPressed: () => _setAnchorExactlyPos(Anchor(80.0, 80.0)),
                  ),
                ],
              ),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: meridaLatLng,
                  zoom: perfectZoom,
                ),
                layers: [
                  defaultTileLayerOptions,
                  MarkerLayerOptions(markers: customMarkers)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
