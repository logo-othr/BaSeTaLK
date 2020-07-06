import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/persistence/topic_path_provider.dart';
import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/home_page/topic_download_dialog.dart';
import 'package:basetalk/presentation/home_page/viewmodel/topic_download_dialog_view_model.dart';
import 'package:basetalk/presentation/home_page/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';


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
    topicViewModel = Provider.of<TopicViewModel>(context);

    final baseTextStyle = const TextStyle(fontFamily: 'Roboto');
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
      child: Container(
          width: 150,
          height: 84,
          padding: EdgeInsets.all(2),
          color: Colors.black12,
          child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            width: 150,
            height: 84,
            image: FileImage(serviceLocator
                .get<TopicPathProvider>()
                .getTopicMediaFile(topicViewModel.topic.thumbnail)),
            fit: BoxFit.cover,
          )),
    );
    Widget createTags() {
      List<Widget> v = [];
      for (String tag in topicViewModel.topic.tags)
        v.add(Text("#$tag "));
      return Row(children: v);
    }

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
            child: createTags(),
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
              onPressed: topicViewModel.topic.isDownloaded
                  ? null
                  : () async {
                showDownloadDialog();
              },
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(RouteName.BLITZLICHT,
            arguments: topicViewModel.topic.id);
      },
      child: Card(
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
          )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void selectTopic(BuildContext context) {}

  _toggleFavorite() {
    topicViewModel.toggleFavorite();
    topicListViewModel.sort();
  }

  _toggleVisited(bool newValue) {
    if (topicViewModel.topic.isVisited != newValue)
      topicViewModel.toggleVisited();
  }

  void showDownloadDialog() {
    ChangeNotifierProvider dialog =
    ChangeNotifierProvider<TopicDownloadDialogViewModel>(
      create: (context) => TopicDownloadDialogViewModel(),
      child: TopicDownloadDialog(topicViewModel),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
