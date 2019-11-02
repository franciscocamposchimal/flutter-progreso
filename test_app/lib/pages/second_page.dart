import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:test_app/bloc/provider.dart';
import 'package:test_app/models/report_model.dart';
import 'package:test_app/providers/auth_provider.dart';
import 'package:test_app/shared_preferences/shared_preferences.dart';
import 'package:test_app/utils/utils.dart' as utils;

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Report report = new Report();
  //bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    //final reportsBloc = Provider.reportsBlocP(context);
    final _prefs = new PreferenciasUsuario();
    utils.printDebug(_prefs.user.photoURL);

    return Scaffold(
      appBar: _appBar(_prefs.user.photoURL),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text('Welcome!!')),
          SizedBox(height: 40.0),
          CircularProgressIndicator()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _formDialog(context),
      ),
    );
  }

  void _formDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              children: <Widget>[
                _takeImage(),
                //_getUbication(),
                //_getDescription(),
                //_submit(),
              ],
            ),
          );
        });
  }

  Widget _takeImage() {
    return Container(
      //decoration: BoxDecoration(border: Border.all()),
      height: 200.0,
      width: 250.0,
      child: Stack(
        children: <Widget>[
          _getPhoto(),
          _imagesIcons(),
        ],
      ),
    );
  }

  Widget _imagesIcons() {
    return Positioned(
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
        source: origen, maxWidth: 200, maxHeight: 200);
    if (foto != null) {
      report.photoUrl = null;
    }
    setState(() {});
  }

  Widget _appBar(String photo) {
    return AppBar(
      elevation: 2.0,
      backgroundColor: Colors.deepPurple,
      leading: _avatar(photo),
      title: Text('Dashboard',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 30.0)),
      centerTitle: true,
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _getOut(),
            ],
          ),
        )
      ],
    );
  }

  Widget _getOut() {
    return FlatButton.icon(
      label: Text('Log out',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14.0)),
      onPressed: () => AuthProvider().logOut(),
      icon: Icon(Icons.power_settings_new, color: Colors.white),
    );
  }

  Widget _avatar(String photo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(75.0)),
      )),
    );
  }
}
