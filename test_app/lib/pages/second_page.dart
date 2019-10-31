import 'package:flutter/material.dart';
import 'package:test_app/providers/auth_provider.dart';
import 'package:test_app/shared_preferences/shared_preferences.dart';
import 'package:test_app/utils/utils.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    printDebug(_prefs.user.photoURL);
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _avatar(_prefs.user.photoURL),
          SizedBox(height: 40.0),
          Center(child: Text('Welcome!!')),
          SizedBox(height: 40.0),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 2.0,
      backgroundColor: Colors.white,
      title: Text('Dashboard',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 30.0)),
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
              color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 14.0)),
      onPressed: () => AuthProvider().logOut(),
      icon: Icon(Icons.power_settings_new, color: Colors.black54),
    );
  }

  Widget _avatar(String photo) {
    return Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.red,
            image:
                DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(75.0)),
            boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]));
  }
}
