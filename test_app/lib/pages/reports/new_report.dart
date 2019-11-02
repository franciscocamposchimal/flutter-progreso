import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/models/report_model.dart';

class NewReportDialog extends StatefulWidget {
  @override
  _NewReportDialogState createState() => _NewReportDialogState();
}

class _NewReportDialogState extends State<NewReportDialog> {
  Report report = new Report();
  //bool _guardando = false;
  File foto;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
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
        body: Column(
          children: <Widget>[
            SizedBox(height: 20.00),
            _takeImage(),
            //_getUbication(),
            //_getDescription(),
            //_submit()
          ],
        ));
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
    if (foto != null) {
      report.photoUrl = null;
    }
    setState(() {});
  }
}
