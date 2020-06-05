import 'package:flutter/material.dart';

import '../drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  String _screenTitle;

  SettingsScreen(this._screenTitle);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: MainDrawer(),
      appBar: new AppBar(
        title: new Text(_screenTitle),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
