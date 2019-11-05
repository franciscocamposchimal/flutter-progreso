import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/bloc/provider.dart';

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
  ReportsBloc reportBloc;
  //bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    reportBloc = Provider.reportsBlocP(context);
    return new Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.deepPurple,
          title: Text('Nuevo reporte'),
          actions: [
            FlatButton(
                onPressed: () async {
                  //Navigator.of(context).pop();
                  await _submitReport(reportBloc);
                  Navigator.of(context).pop();
                },
                child: _loadingIndicator(reportBloc)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.00),
              _takeImage(),
              _getUbication(),
              SizedBox(height: 20.00),
              _getDescription(reportBloc),
              //_submit()
            ],
          ),
        ));
  }

  Widget _loadingIndicator(ReportsBloc bloc) {
    return StreamBuilder(
      stream: bloc.isLoadingStream,
      builder: (BuildContext cntx, AsyncSnapshot<bool> snapshot) {
        return snapshot.hasData
            ? snapshot.data
                ? CircularProgressIndicator()
                : Text('Guardar', style: _textStyle())
            : Text('Guardar', style: _textStyle());
      },
    );
  }

  TextStyle _textStyle() {
    return Theme.of(context).textTheme.subhead.copyWith(color: Colors.white);
  }

  Widget _getDescription(ReportsBloc bloc) {
    return Center(
      child: Container(
        height: 250.0,
        width: 300.0,
        child: StreamBuilder(
            stream: bloc.descriptionStream,
            builder: (BuildContext context, snapshot) {
              return TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bache, Calle en reparación...',
                  labelText: 'Escríbenos',
                ),
                onChanged: bloc.changeDescription,
              );
            }),
      ),
    );
  }

  Widget _getUbication() {
    return Center(
      child: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            return Container(
              height: 250.0,
              width: 300.0,
              child: snapshot.hasData
                  ? Image.network(
                      getStaticImageWithMarker(snapshot.data),
                      fit: BoxFit.cover,
                    )
                  : Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }

  String getStaticImageWithMarker(Position pos) {
    return staticImage.getStaticUrlWithMarker(
      center: Location(lat: pos.latitude, lng: pos.longitude),
      marker: MapBoxMarker(
          markerColor: Colors.deepPurple,
          markerLetter: 'p',
          markerSize: MarkerSize.LARGE),
      height: 250,
      width: 300,
      zoomLevel: 16,
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

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    File loadImage = await ImagePicker.pickImage(source: origen);
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(loadImage.path);
    print("IMAGE");
    //utils.printError('${properties.height ~/ 10}');
    foto = await FlutterNativeImage.compressImage(loadImage.path,
        quality: 50,
        percentage: 50,
        targetHeight: properties.height ~/ 10,
        targetWidth: properties.width ~/ 10);

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
    report.ubication =
        '{"lat":${currentLocation.latitude},"lon":${currentLocation.longitude} }';
    return currentLocation;
  }

  Future<void> _submitReport(ReportsBloc bloc) async {
    print("Save");
    print(foto?.path);
    print(report.ubication);
    await bloc.addReport(foto, report);
  }
}
