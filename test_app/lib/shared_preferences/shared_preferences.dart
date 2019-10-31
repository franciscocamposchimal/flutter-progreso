import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/models/user_model.dart';
/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    prefs.initPrefs();

*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de la última página
  get user {
    final getUserString = _prefs.getString('user') ?? '';
    final getUser = User.fromJsonMap(json.decode(getUserString));
    return getUser;
  }

  set user( FirebaseUser user ) {
    final userForStore = User.fromJsonMap({
      "uuid": user.uid,
      "email": user.email,
      "photoURL": (user.photoUrl != null) ? user.photoUrl : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxUC64VZctJ0un9UBnbUKtj-blhw02PeDEQIMOqovc215LWYKu&s',
      "displayName": user.displayName,
      "timestamp" : Timestamp.now().toString()
    });
    _prefs.setString('user', json.encode(userForStore));
  }
  

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}