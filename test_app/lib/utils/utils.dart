import 'package:flutter/material.dart';
import 'package:ansicolor/ansicolor.dart';

AnsiPen _penBlueAccent = new AnsiPen()..white(bold: true)..rgb(r: 0.0, g: 1.0, b: 3.0);
AnsiPen _penRed = new AnsiPen()..white(bold: true)..rgb(r: 255.0, g: 0.0, b: 0.0);
AnsiPen _penGreen = new AnsiPen()..white(bold: true)..rgb(r: 0.0, g: 255.0, b: 0.0);

void printDebug(String debug){
  print(_penBlueAccent(debug));
}

void printError(String debug){
  print(_penRed(debug));
}

void printSuccess(String debug){
  print(_penGreen(debug));
}

bool isEmail(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  return (regExp.hasMatch(email)) ? true : false;
}

bool isPass(String pass) {
  //Pattern pattern = '/\s/';
  //RegExp regExp = new RegExp(pattern);
  return ((pass.length > 6) && (!pass.contains(' '))) ? true : false;
}

void mostrarAlerta(BuildContext context, String title, String mensaje, bool dissmisable) {
  showDialog(
      context: context,
      barrierDismissible: dissmisable,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => dissmisable ? Navigator.of(context).pop() : (){},
            )
          ],
        );
      });
}
