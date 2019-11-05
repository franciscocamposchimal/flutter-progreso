import 'package:flutter/material.dart';
import 'package:test_app/models/report_model.dart';

class DetailReport extends StatelessWidget {
  final Report report;
  DetailReport(this.report);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xFF736AB7),
        child: Stack(
          children: <Widget>[_getBackground(), _getGradient()],
        ),
      ),
    );
  }

  Widget _getBackground() {
    return Container(
        constraints: BoxConstraints.expand(height: 300.0),
        child: FadeInImage(
          height: 300.0,
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(report.photoUrl),
        ));
  }

  Widget _getGradient() {
    return Container(
      margin: EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0x00736AB7), Color(0xFF736AB7)],
          stops: [0.0, 0.9],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }
}
