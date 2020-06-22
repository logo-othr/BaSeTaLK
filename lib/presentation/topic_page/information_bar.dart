import 'package:flutter/material.dart';

class InformationBar extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onClosePressed;

  InformationBar(
      {@required this.title,
      @required this.description,
      @required this.onClosePressed});

  @override
  _InformationBarState createState() => _InformationBarState();
}

class _InformationBarState extends State<InformationBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: 350,
          width: double.infinity,
          color: Color.fromRGBO(220, 220, 220, 0.95),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(50, 40, 50, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Überschrift",
                      style: TextStyle(fontSize: 70),
                    ),
                    Text(
                      "Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben\nda sind und wie sie aussehen. Manchmal benutzt man Worte wie\nHamburgefonts, Rafgenduks oder Handgloves, um Schriften zu testen.",
                      style: TextStyle(fontSize: 32),
                    )
                  ],
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.close),
                  iconSize: 120,
                  alignment: Alignment.topCenter,
                  onPressed: widget.onClosePressed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
