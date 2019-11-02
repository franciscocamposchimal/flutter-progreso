import 'package:flutter/material.dart';
import 'package:test_app/pages/reports/new_report.dart';
import 'package:test_app/providers/auth_provider.dart';
import 'package:test_app/shared_preferences/shared_preferences.dart';
import 'package:test_app/utils/utils.dart' as utils;

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

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
        onPressed: () => _openAddEntryDialog(),
      ),
    );
  }
  void _openAddEntryDialog() {
  Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new NewReportDialog();
      },
    fullscreenDialog: true
  ));
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