import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/main_appbar.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/presentation/topic_page/arrow_navigation.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    TopicViewModel topicViewModel = Provider.of<TopicViewModel>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: MainAppBar(title: topicViewModel.topic.name),
      body: ArrowNavigation(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBar(
                initialRating: 0,
                itemCount: 5,
                itemSize: 150.0,
                // ignore: missing_return
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                      );
                    case 1:
                      return Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      );
                    case 3:
                      return Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                      );
                    case 4:
                      return Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      );
                  }
                },
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              RatingBar(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemSize: 150.0,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              RatingBar(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemSize: 150.0,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              RatingBar(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemSize: 150.0,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.favorite,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              RatingBar(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemSize: 150.0,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
        ),
        onRightPressed: null,
        onLeftPressed: () {
          Navigator.of(context).pushReplacementNamed(RouteName.TOPIC,
              arguments:
                  TopicPageParams(topicViewModel.topic.id, PageNumber.three));
        },
      ),
    );
  }
}
