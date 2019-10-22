import 'package:flutter/material.dart';
import 'package:map_current_location/utils/menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> titles = menu;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (ctx, idx) {
          return Card(
            child: ListTile(
              leading: Icon(titles[idx]['icon']),
              title: Text(titles[idx]['title']),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.pushNamed(context, titles[idx]['route']);
              },
            ),
          );
        },
      ),
    );
  }
}
