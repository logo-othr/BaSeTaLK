import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/information_dialog.dart';
import 'package:basetalk/presentation/main_appbar.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/presentation/topic_page/arrow_navigation.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:basetalk/statistic_logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlitzLicht extends StatefulWidget {

  @override
  _BlitzLichtState createState() => _BlitzLichtState();
}

class _BlitzLichtState extends State<BlitzLicht> {
  @override
  Widget build(BuildContext context) {
    TopicViewModel topicViewModel = Provider.of<TopicViewModel>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: MainAppBar(title: topicViewModel.topic.name),
      body: ArrowNavigation(
        child: Column(
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
        ),
        onLeftPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => InformationDialog(
                description:
                    "Möchten Sie das Thema wirklich ohne Bewertung beenden",
                buttonText: "Thema beenden",
                onActionPressed: () {
                  serviceLocator.get<StatisticLogger>().logEvent(
                        eventType: EventType.topicCloseToHome,
                        topicID: topicViewModel.topic.id.toString(),
                        topicName: topicViewModel.topic.name,
                      );
                  Navigator.of(context).pushReplacementNamed(RouteName.HOME);
                }),
          );
        },
        onRightPressed: () {
          Navigator.of(context).pushReplacementNamed(RouteName.TOPIC,
              arguments:
              TopicPageParams(topicViewModel.topic.id, PageNumber.zero));
        },
      ),
    );
  }
}
