import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta/meta.dart';

class ArrowNavigation extends StatelessWidget {
  final Widget child;
  final Function onLeftPressed;
  final Function onRightPressed;

  final svgLeft = SvgPicture.asset(
    'assets/icons/arrow_back_ios-black-24dp.svg',
    height: 100,
    width: 100,
    alignment: Alignment.center,
  );

  final svgRight = SvgPicture.asset(
    'assets/icons/arrow_forward_ios-black-24dp.svg',
    height: 100,
    width: 100,
    alignment: Alignment.center,
  );

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
            onLeftPressed != null
                ? Center(
              child: Card(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                child: IconButton(
                  icon: svgLeft,
                  iconSize: 100,
                  onPressed: onLeftPressed,
                ),
              ),
            )
                : Container(),
            onRightPressed != null
                ? Center(
              child: Card(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                child: IconButton(
                  icon: svgRight,
                  iconSize: 100,
                  onPressed: onRightPressed,
                ),
              ),
            )
                : Container(),
          ],
        ),
      ],
    );
  }
}
