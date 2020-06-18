import 'package:flutter/cupertino.dart';

class RatingPage extends StatefulWidget {
  static const routeName = "/ratingpage";

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Bewertung"),
    );
  }
}
