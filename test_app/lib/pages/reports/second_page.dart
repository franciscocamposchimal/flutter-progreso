import 'package:flutter/material.dart';
import 'package:test_app/bloc/provider.dart';
import 'package:test_app/models/report_model.dart';
import 'package:test_app/pages/reports/detail_report_page.dart';
import 'package:test_app/pages/reports/new_report.dart';
import 'package:test_app/providers/auth_provider.dart';
import 'package:test_app/shared_preferences/shared_preferences.dart';
//import 'package:test_app/utils/utils.dart' as utils;

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final reportsBloc = Provider.reportsBlocP(context);
    reportsBloc.loadReports();
    final _prefs = new PreferenciasUsuario();

    return Scaffold(
      appBar: _appBar(_prefs.user.photoURL),
      body: _listReports(reportsBloc),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAddEntryDialog(),
      ),
    );
  }

  Widget _listReports(ReportsBloc bloc) {
    return StreamBuilder(
      stream: bloc.reportsStream,
      builder: (BuildContext cntx, AsyncSnapshot<List<Report>> snapshot) {
        return snapshot.hasData
            ? _list(snapshot.data, bloc)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _list(List<Report> list, ReportsBloc bloc) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (ctx, idx) {
        final item = list[idx];
        return Dismissible(
          key: Key(item.id),
          onDismissed: (direction) async {
            await bloc.deleteReport(item.id, item.photoUrl);
            setState(() {
              list.removeAt(idx);
            });
          },
          background: Container(color: Colors.redAccent),
          child: Card(
            child: ListTile(
              leading: Hero(
                tag: item.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(item.photoUrl),
                  ),
                ),
              ),
              title: item.description != null
                  ? Text(item.description)
                  : Text('No description'),
              subtitle: item.ubication != null
                  ? Text(item.ubication)
                  : Text('No description'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailReport(item)),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _openAddEntryDialog() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new NewReportDialog();
        },
        fullscreenDialog: true));
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
