import 'package:basetalk/presentation/drawer.dart';
import 'package:flutter/material.dart';

class LegalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: new AppBar(
          title: new Text("Impressum"),
          centerTitle: true,
        ),
        body: Container());
  }
}
