import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

String apiKey = 'pk.eyJ1IjoiZnJhbmtvY2FtcG9zIiwiYSI6ImNqbGRiMmJlMzA5ZG0zd3BjendmNTF5NmgifQ.tCQ9eJCRKnADR-AN6VQSFQ';

class _SearchPageState extends State<SearchPage> {
  MapBoxStaticImage staticImage = MapBoxStaticImage(apiKey: apiKey);

  Future<List<MapBoxPlace>> getPlaces() async {
    ReverseGeoCoding reverseGeoCoding = ReverseGeoCoding(
      apiKey: apiKey,
      limit: 5,
    );
    return await reverseGeoCoding
        .getAddress(Location(lat: 21.0116126, lng: -89.6046292));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MapBox Api Example'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Search'),
        icon: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchedPage(),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Static Image with Marker',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Image.network(
              getStaticImageWithMarker(),
              fit: BoxFit.cover,
            ),
          ),
          InkWell(
            onTap: () async {
              var places = await getPlaces();
              print(places.length);
            },
            child: Text(
              'Static Image with polyline',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Image.network(
              getStaticImageWithPolyline(),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Static Image without Marker',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Image.network(
              getStaticImageWithoutMarker(),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  String getStaticImageWithPolyline() => staticImage.getStaticUrlWithPolyline(
        point1: Location(lat: 37.77343, lng: -122.46589),
        point2: Location(lat: 37.75965, lng: -122.42816),
        marker1: MapBoxMarker(
            markerColor: Colors.black,
            markerLetter: 'p',
            markerSize: MarkerSize.LARGE),
        msrker2: MapBoxMarker(
            markerColor: Colors.redAccent,
            markerLetter: 'q',
            markerSize: MarkerSize.SMALL),
        height: 300,
        width: 600,
        zoomLevel: 16,
        style: MapBoxStyle.Mapbox_Dark,
        path: MapBoxPath(
          pathColor: Colors.red,
          pathOpacity: 0.5,
          pathWidth: 5,
          pathPolyline:
              "%7DrpeFxbnjVsFwdAvr@cHgFor@jEmAlFmEMwM_FuItCkOi@wc@bg@wBSgM",
        ),
        render2x: true,
      );
  String getStaticImageWithMarker() => staticImage.getStaticUrlWithMarker(
        center: Location(lat: 37.77343, lng: -122.46589),
        marker: MapBoxMarker(
            markerColor: Colors.black,
            markerLetter: 'p',
            markerSize: MarkerSize.LARGE),
        height: 300,
        width: 600,
        zoomLevel: 16,
        style: MapBoxStyle.Mapbox_Streets,
        render2x: true,
      );
  String getStaticImageWithoutMarker() => staticImage.getStaticUrlWithoutMarker(
        center: Location(lat: 37.75965, lng: -122.42816),
        height: 300,
        width: 600,
        zoomLevel: 16,
        style: MapBoxStyle.Mapbox_Outdoors,
        render2x: true,
      );
}

class SearchedPage extends StatelessWidget {
  const SearchedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        bottom: false,
        child: MapBoxPlaceSearchWidget(
          popOnSelect: true,
          apiKey: "pk.eyJ1IjoiZnJhbmtvY2FtcG9zIiwiYSI6ImNqbGRiMmJlMzA5ZG0zd3BjendmNTF5NmgifQ.tCQ9eJCRKnADR-AN6VQSFQ",
          limit: 10,
          onSelected: (place) {
            print(place);
          },
          context: context,
        ),
      ),
    );
  }
}