import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ArrowNavigation extends StatelessWidget {
  final Widget child;
  final Function onLeftPressed;
  final Function onRightPressed;

  ArrowNavigation(
      {@required this.child,
      @required this.onLeftPressed,
      @required this.onRightPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        child,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Card(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 100,
                  onPressed: onLeftPressed,
                ),
              ),
            ),
            Center(
              child: Card(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 100,
                  onPressed: onRightPressed,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
