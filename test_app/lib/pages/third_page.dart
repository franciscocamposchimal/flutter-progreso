import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Third page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('Argumenst: $args')
          ),
          SizedBox(height: 40.0),
          RaisedButton.icon(
            label: Text('Home back'),
            icon: Icon(Icons.arrow_back),
            onPressed: (){},
          )
        ],
      ),
    );
  }
}