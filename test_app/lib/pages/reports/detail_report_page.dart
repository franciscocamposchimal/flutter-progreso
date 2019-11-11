import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:test_app/bloc/provider.dart';

import 'package:test_app/models/report_model.dart';
import 'package:test_app/utils/utils.dart' as utils;

class DetailReport extends StatefulWidget {
  final Report report;
  DetailReport(this.report);

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  MapBoxStaticImage staticImage = MapBoxStaticImage(apiKey: utils.apiKey);
  Geolocator geolocator = Geolocator();
  TextStyle whiteText = TextStyle(color: Colors.white);
  ReportsBloc reportBloc;
  final edition = TextEditingController();
  @override
  void dispose() {
    edition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    reportBloc = Provider.reportsBlocP(context);
    edition.value = edition.value.copyWith(text: widget.report.description);
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xFF736AB7),
        child: Stack(
          children: <Widget>[_getBackground(), _getGradient(), _getContent()],
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
        image: NetworkImage(getStaticImageWithMarker(widget.report)),
      ),
    );
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

  String getStaticImageWithMarker(Report report) {
    final Map<String, dynamic> position = json.decode(report.ubication);
    return staticImage.getStaticUrlWithMarker(
      center: Location(lat: position['lat'], lng: position['lon']),
      marker: MapBoxMarker(
          markerColor: Colors.deepPurple,
          markerLetter: 'p',
          markerSize: MarkerSize.LARGE),
      height: 250,
      width: 300,
      zoomLevel: 12,
      style: MapBoxStyle.Mapbox_Streets,
      render2x: true,
    );
  }

  Widget _getContent() {
    return ListView(
      padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 32.0),
      children: <Widget>[_reporContainer(), _editDescription()],
    );
  }

  Widget _editDescription() {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 100.0, right: 100.0),
      child: RaisedButton.icon(
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        label: Text('Editar', style: whiteText),
        color: Colors.blueAccent,
        onPressed: () {
          reportBloc.changeIsEdit(
              reportBloc.isEdit != null ? !reportBloc.isEdit : true);
        },
      ),
    );
  }

  Widget _reporContainer() {
    return Stack(
      children: <Widget>[_reportCard(), _reportThumb()],
    );
  }

  Widget _reportCard() {
    return Container(
      height: 180.0,
      margin: EdgeInsets.only(top: 72.0),
      decoration: BoxDecoration(
          color: Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            )
          ]),
      child: Container(
        margin: EdgeInsets.fromLTRB(16.0, 42.0, 16.0, 16.0),
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 4.0),
            Text(widget.report.id, style: whiteText),
            Container(height: 15.0),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 2.0,
                width: 18.0,
                color: Color(0xff00c6ff)),
            _textEdit(),
          ],
        ),
      ),
    );
  }

  Widget _textEdit() {
    return StreamBuilder(
        stream: reportBloc.isEditStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return Container(
            child: snapshot.hasData
                ? snapshot.data
                    ? _textFieldEdit()
                    : Text(widget.report.description, style: whiteText)
                : Text(widget.report.description, style: whiteText),
          );
        });
  }

  Widget _textFieldEdit() {
    return StreamBuilder(
      stream: reportBloc.descriptionEditStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        print(snapshot.hasData ? reportBloc.descriptionEdit : "No data");
        return TextField(
          style: whiteText,
          controller: edition,
          decoration: InputDecoration(
              hintText: 'Edita tu reporte',
              hintStyle: whiteText,
              labelText: 'Editando',
              labelStyle: whiteText,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )),
          onChanged: reportBloc.changeDescriptionEdit,
        );
      }
    );
  }

  Widget _reportThumb() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.center,
      child: Hero(
        tag: widget.report.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: FadeInImage(
            height: 92.0,
            width: 92.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(widget.report.photoUrl),
          ),
        ),
      ),
    );
  }
}
