import 'package:flutter/material.dart';

class BlitzLicht extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Blitzlicht',
          style: TextStyle(fontSize: 100),
        ),
        Icon(
          Icons.lightbulb_outline,
          size: 200,
        ),
        Text(
          'Wie geht es Ihnen heute?',
          style: TextStyle(fontSize: 50),
        ),
      ],
    );
  }
}
