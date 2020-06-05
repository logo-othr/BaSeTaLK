import 'dart:ui';

import 'package:basetalk/domain/entities/feature_type.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/topic_page/impulse_bar.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/impulse_bar_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicPage extends StatefulWidget {
  static const routeName = "/topicPage";

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  double rowDividerHeight;
  double iconSize;
  double audioButtonSize;

  TopicViewModel topicViewModel;
  TopicPageViewModel topicPageViewModel;
  ImpulseBarViewModel impulseBarViewModel;

  initLayoutSizes() {
    double deviceHeight = MediaQuery.of(context).size.height;
    double heightFactor = deviceHeight / 100;
    iconSize = 17 * heightFactor;
    audioButtonSize = 12 * heightFactor;
    rowDividerHeight = 5 * heightFactor;
  }

  initProviders(BuildContext context) {
    topicViewModel = Provider.of<TopicViewModel>(context);
    topicPageViewModel = Provider.of<TopicPageViewModel>(context);
    var pageNumber = topicPageViewModel.pageNumber;
    var impulses = topicViewModel.getImpulses(pageNumber);
    impulseBarViewModel = ImpulseBarViewModel(impulses);
  }

  Future<FileImage> loadBackgroundImage() async {
    String backgroundImagefileName = topicViewModel
        .getBackgroundImageFileName(topicPageViewModel.pageNumber);
    Media backgroundMedia =
        await topicPageViewModel.getBackgroundImage(backgroundImagefileName);
    return FileImage(backgroundMedia.file);
  }

  @override
  Widget build(BuildContext context) {
    initLayoutSizes();
    initProviders(context);

    return FutureBuilder(
      future: loadBackgroundImage(),
      builder: (BuildContext context, AsyncSnapshot<FileImage> image) {
        if (image.hasData) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image.data,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: rowDividerHeight),
                topicPageViewModel.isFeatureVisible
                    ? featureRow()
                    : Container(),
                SizedBox(height: rowDividerHeight),
                featureImpulseRow(),
                SizedBox(height: rowDividerHeight)
              ],
            ),
          );
        } else
          return Container();
      },
    );
  }

  Widget featureRow() {
    Widget child = Container();
    var type =
        topicViewModel
            .getPageFeature(topicPageViewModel.pageNumber)
            .type;
    if (type == FeatureType.AUDIO || type == FeatureType.AUDIOIMAGE)
      child = audioFeature();
    else if (type == FeatureType.IMAGE)
      child = imageFeature();
    else if (type == FeatureType.QUIZ) child = quizFeature();

    return Expanded(
      child: Container(
        child: child,
      ),
    );
  }

  Widget quizFeature() {
    return Container(
      child: Text("Quiz Feature"),
    );
  }

  Widget audioFeature() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        child: Icon(
          Icons.volume_down,
          size: 200,
        ),
      ),
    );
  }

  Widget imageFeature() {
    return Image(
      image: AssetImage("assets/img/example_no_vc.jpg"),
    );
  }

  showImpulseBar() {
    return ChangeNotifierProvider<ImpulseBarViewModel>.value(
      value: impulseBarViewModel,
      child: ImpulseBar(
        onClose: topicPageViewModel.toggleImpulseBarVisible,
        audioIconSize: iconSize,
      ),
    );
  }

  Widget showImpulseBarButton() {
    return Container(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        color: primary_green,
        child: IconButton(
            icon: Icon(Icons.chat),
            iconSize: iconSize,
            onPressed: () => topicPageViewModel.toggleImpulseBarVisible()),
      ),
    );
  }

  Widget featureButton() {
    return Container(
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        color: primary_green,
        child: IconButton(
            icon: Icon(Icons.card_giftcard),
            iconSize: iconSize,
            onPressed: () => topicPageViewModel.toggleFeatureVisible()),
      ),
    );
  }

  Widget buttonRow() {
    Widget child;
    var type =
        topicViewModel
            .getPageFeature(topicPageViewModel.pageNumber)
            .type;
    if (type == FeatureType.AUDIO || type == FeatureType.AUDIOIMAGE)
      child = audioButtonBar();
    else
      child = Container();
    return Container(child: Center(child: child));
  }

  Widget audioButtonBar() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        audioButton(
            icon: Icon(
              Icons.play_arrow,
              size: audioButtonSize,
            ),
            onPressed: () => print('Play')),
        audioButton(
            icon: Icon(
              Icons.replay,
              size: audioButtonSize,
            ),
            onPressed: () => print('Replay')),
        audioButton(
            icon: Icon(
              Icons.pause,
              size: audioButtonSize,
            ),
            onPressed: () => print('Pause')),
      ],
    );
  }

  Widget audioButton({@required Icon icon, @required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: RawMaterialButton(
        padding: EdgeInsets.all(20),
        fillColor: primary_green,
        shape: CircleBorder(),
        child: icon,
        onPressed: onPressed,
      ),
    );
  }

  Widget featureImpulseRow() {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child:
            topicPageViewModel.isFeatureVisible ? buttonRow() : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              featureButton(),
              topicPageViewModel.isImpulseBarVisible
                  ? showImpulseBar()
                  : showImpulseBarButton()
            ],
          ),
        ],
      ),
    );
  }
}

class TopicPageParams {
  final int topicId;
  final PageNumber pageNumber;

  TopicPageParams(this.topicId, this.pageNumber);
}
