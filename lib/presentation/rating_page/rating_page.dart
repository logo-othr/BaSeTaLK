import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/main_appbar.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/presentation/topic_page/arrow_navigation.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:basetalk/statistic_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  bool rated = false;
  int rating = 0;

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
              Text("Vielen Dank! Bitte bewerten Sie das Thema.",
                  style: TextStyle(fontSize: 35)),
              SizedBox(
                height: 100,
              ),
              RatingBar.builder(
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
                  setState(() {
                    rated = true;
                    this.rating = rating.toInt();
                  });
                },
              ),
              SizedBox(
                height: 100,
              ),
              RaisedButton(
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.green,
                child: Text(
                  "Thema beenden",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                onPressed: rated
                    ? (() {
                  serviceLocator.get<StatisticLogger>().logEvent(
                              eventType: EventType.topicRating,
                              topicID: topicViewModel.topic.id.toString(),
                              topicName: topicViewModel.topic.name,
                              nValue: this.rating,
                            );
                        serviceLocator.get<StatisticLogger>().logEvent(
                              eventType: EventType.topicCloseToHome,
                              topicID: topicViewModel.topic.id.toString(),
                              topicName: topicViewModel.topic.name,
                              nValue: this.rating,
                            );
                        topicViewModel.toggleVisited();

                        Navigator.of(context).pushReplacementNamed(
                          RouteName.HOME,
                        );
                      })
                    : null,
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
