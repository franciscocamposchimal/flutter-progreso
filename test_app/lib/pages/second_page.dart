import 'package:flutter/material.dart';
import 'package:test_app/providers/auth_provider.dart';

class SecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('Welcome!!')
          ),
          SizedBox(height: 40.0),
          RaisedButton.icon(
            label: Text('Next'),
            icon: Icon(Icons.arrow_forward),
            onPressed: (){
              //Navigator.of(context).pushNamed('/third', arguments: 'Other values');
              AuthProvider().logOut();
            },
          )
        ],
      ),
    );
  }
}