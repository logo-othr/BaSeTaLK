import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/main_appbar.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/presentation/topic_page/arrow_navigation.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        child: SizedBox.expand(
          child: Container(),
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
