import 'package:flutter/material.dart';
import 'package:test_app/providers/auth_provider.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text('Welcome!!')),
          SizedBox(height: 40.0),
          RaisedButton.icon(
            label: Text('Next'),
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              //Navigator.of(context).pushNamed('/third', arguments: 'Other values');
              AuthProvider().logOut();
            },
          )
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
}
