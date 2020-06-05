import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicFrontPage extends StatefulWidget {
  @override
  _TopicFrontPageState createState() => _TopicFrontPageState();
}

class _TopicFrontPageState extends State<TopicFrontPage> {
  @override
  Widget build(BuildContext context) {
    TopicViewModel topicViewModel = Provider.of<TopicViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'TOPIC FRONT PAGE',
          style: TextStyle(fontSize: 100),
        ),
      ],
    );
  }
}
