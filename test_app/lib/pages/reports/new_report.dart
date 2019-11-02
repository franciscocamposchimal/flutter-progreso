import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import 'package:test_app/models/report_model.dart';
import 'package:test_app/utils/utils.dart' as utils;

class NewReportDialog extends StatefulWidget {
  @override
  _NewReportDialogState createState() => _NewReportDialogState();
}

class _NewReportDialogState extends State<NewReportDialog> {
  MapBoxStaticImage staticImage = MapBoxStaticImage(apiKey: utils.apiKey);
  Geolocator geolocator = Geolocator();
  Position position = Position();
  Report report = new Report();
  //bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 2.0,
          backgroundColor: Colors.deepPurple,
          title: const Text('Nuevo reporte'),
          actions: [
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Guardar',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white))),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.00),
              _takeImage(),
              _getUbication(),
              SizedBox(height: 20.00),
              _getDescription(),
              //_submit()
            ],
          ),
        ));
  }

  Widget _getDescription() {
    return Center(
      child: Container(
        height: 250.0,
        width: 300.0,
        child: TextField(
            maxLines: 6,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Bache, Calle en reparación...',
              labelText: 'Escríbenos',
            )),
      ),
    );
  }

  Widget _getUbication() {
    return Center(
      child: FutureBuilder(
        future: _getLocation(),
        builder: (context, snapshot) {
          print(snapshot);
          return Container(
            height: 250.0,
            width: 300.0,
            child: Image.network(
              getStaticImageWithMarker(),
              fit: BoxFit.cover,
            ),
          );
        }
      ),
    );
  }

  String getStaticImageWithMarker() {
    return staticImage.getStaticUrlWithMarker(
      center: Location(lat: position.latitude, lng: position.longitude),
      marker: MapBoxMarker(
          markerColor: Colors.deepPurple,
          markerLetter: 'p',
          markerSize: MarkerSize.LARGE),
      height: 250,
      width: 300,
      zoomLevel: 13,
      style: MapBoxStyle.Mapbox_Streets,
      render2x: true,
    );
  }

  Widget _takeImage() {
    return Center(
      child: Container(
        //decoration: BoxDecoration(border: Border.all()),
        height: 250.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            _getPhoto(),
            _imagesIcons(),
          ],
        ),
      ),
    );
  }

  Widget _imagesIcons() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
    );
  }

  Widget _getPhoto() {
    if (report.photoUrl != null) {
      return Align(
        alignment: Alignment.topCenter,
        child: FadeInImage(
          image: NetworkImage(report.photoUrl),
          placeholder: AssetImage('assets/jar-loading.gif'),
          height: 200.0,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: (foto == null)
            ? Image(
                image: AssetImage(foto?.path ?? 'assets/no-image.png'),
                height: 200.0,
                fit: BoxFit.cover,
              )
            : Image.file(
                foto,
                height: 200.0,
                fit: BoxFit.cover,
              ),
      );
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(
        source: origen, maxWidth: 300, maxHeight: 200);
    utils.printDebug(foto.path);
    if (foto != null) {
      report.photoUrl = null;
    }
    setState(() {});
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
}
