import 'package:basetalk/presentation/view/subpage_appbar.dart';
import 'package:flutter/material.dart';

import '../drawer.dart';

class Subpage extends StatelessWidget {
  static const routeName = "Subpage";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: MainDrawer(),
      appBar: new SubPageAppbar(new Text("Subpage")),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/subpage_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text("Subpage"),
          )),
    );
  }
}
