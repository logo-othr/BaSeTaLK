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
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          color: Color.fromRGBO(220, 220, 220, 0.95),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.fromLTRB(50, 40, 50, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 30),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 30),
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
