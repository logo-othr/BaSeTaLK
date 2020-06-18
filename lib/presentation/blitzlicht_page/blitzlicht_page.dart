import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/home_page/home_screen.dart';
import 'package:basetalk/presentation/information_dialog.dart';
import 'package:basetalk/presentation/main_appbar.dart';
import 'package:basetalk/presentation/topic_page/arrow_navigation.dart';
import 'package:basetalk/presentation/topic_page/basic_topic_page.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlitzLicht extends StatefulWidget {
  static const routeName = "/blitzlicht";

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
              onActionPressed: () => Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName),
            ),
          );
        },
        onRightPressed: () {
          Navigator.of(context).pushReplacementNamed(BasicTopicPage.routeName,
              arguments:
                  TopicPageParams(topicViewModel.topic.id, PageNumber.zero));
        },
      ),
    );
  }
}
