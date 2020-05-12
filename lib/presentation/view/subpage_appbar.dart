import 'package:flutter/material.dart';

class SubPageAppbar extends AppBar {
  SubPageAppbar(Widget title)
      : super(
          title: title,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
        );
}
