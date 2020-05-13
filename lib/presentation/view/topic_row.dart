import 'dart:developer' as logger;

import 'package:basetalk/persistance/topic_path_provider.dart';
import 'package:basetalk/presentation/view/colors.dart';
import 'package:basetalk/presentation/view/topic_download_dialog.dart';
import 'package:basetalk/presentation/viewmodel/topic_download_dialog_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopicRowState();
}

class _TopicRowState extends State<TopicRow> {
  TopicListViewModel topicListViewModel;
  TopicPathProvider topicPathProvider;
  TopicViewModel topicViewModel;

  @override
  Widget build(BuildContext context) {
    topicListViewModel = Provider.of<TopicListViewModel>(context);
    topicPathProvider = Provider.of<TopicPathProvider>(context);
    topicViewModel = Provider.of<TopicViewModel>(context);

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 20.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w600);

    final leftSection = new Container(
      padding: new EdgeInsets.only(right: 15.0),
      margin: new EdgeInsets.all(16.0),
      child: Image(
        width: 200,
        height: 100,
        image: FileImage(
          topicPathProvider.getTopicMediaFile(topicViewModel.topic.thumbnail),
        ),
      ),
    );

    final middleSection = new Container(
      width: 400,
      padding: new EdgeInsets.only(left: 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text(
            topicViewModel.topic.name,
            style: headerTextStyle,
          ),
          new Text(
            topicViewModel.topic.description,
            style: subHeaderTextStyle,
          ),
          new Container(
            padding: new EdgeInsets.only(top: 8.0),
            child: new Row(
              children: <Widget>[
                new Text("Test"),
                new Text("Test"),
                new Text("Test"),
              ],
            ),
          )
        ],
      ),
    );

    final rightSection = new Container(
      padding: new EdgeInsets.only(right: 40.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Container(
              padding: new EdgeInsets.only(right: 40.0, top: 10),
              child: Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  value: topicViewModel.topic.isVisited,
                  onChanged: _toggleVisited,
                  activeColor: primary_green,
                ),
              ),
            ),
          ),
          Container(
            padding: new EdgeInsets.only(right: 40.0),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color:
                    topicViewModel.topic.isFavorite ? Colors.red : Colors.black,
                size: 40,
              ),
              // onPressed: _toggleFavorite(),
              onPressed: _toggleFavorite,
            ),
          ),
          Container(
            padding: new EdgeInsets.only(right: 40.0),
            child: IconButton(
              icon: Icon(
                Icons.get_app,
                color: topicViewModel.topic.isDownloaded
                    ? Colors.black12
                    : Colors.black,
                size: 40,
              ),
              onPressed: () async {
                showDownloadDialog();
              },
            ),
          ),
        ],
      ),
    );

    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .9)),
          child: Row(
            children: <Widget>[
              leftSection,
              middleSection,
              Spacer(),
              rightSection
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  void selectTopic(BuildContext context) {}

  _toggleFavorite() {
    logger.log("toggleFavorite");
    topicViewModel.toggleFavorite();
  }

  _toggleVisited(bool newValue) {
    if (topicViewModel.topic.isVisited != newValue)
      topicViewModel.toggleVisited();
  }

  void showDownloadDialog() {
    //  Dialog errorDialog =
    // topicViewModel.downloadTopic(errorDialog.close)

    ChangeNotifierProvider dialog = ChangeNotifierProvider<
        TopicDownloadDialogViewModel>(
      create: (context) => TopicDownloadDialogViewModel(),
      child: TopicDownloadDialog(topicViewModel),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
