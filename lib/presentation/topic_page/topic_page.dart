import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/feature_type.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/topic_page/audio_button_bar.dart';
import 'package:basetalk/presentation/topic_page/image_feature_view.dart';
import 'package:basetalk/presentation/topic_page/impulse_bar.dart';
import 'package:basetalk/presentation/topic_page/quiz_feature.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/audio_button_bar_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/image_feature_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/impulse_bar_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/quiz_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    initLayoutSizes();
    initProviders(context);

    return Container(
      color: topicPageViewModel.isFeatureVisible &&
              topicViewModel
                      .getPageFeature(topicPageViewModel.pageNumber)
                      .type !=
                  FeatureType.AUDIO
          ? Colors.black.withOpacity(0.3)
          : Colors.black.withOpacity(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: rowDividerHeight),
          topicPageViewModel.isFeatureVisible ? featureRow() : Container(),
          SizedBox(height: rowDividerHeight),
          featureImpulseRow(),
          SizedBox(height: rowDividerHeight)
        ],
      ),
    );
  }

  Widget featureRow() {
    Widget child = Container();
    PageFeature pageFeature =
        topicViewModel.getPageFeature(topicPageViewModel.pageNumber);

    if (pageFeature == null) child = Container();
    switch (pageFeature.type) {
      case FeatureType.AUDIO:
        child = Container();
        break;
      case FeatureType.AUDIOIMAGE:
        child = imageFeature();
        break;
      case FeatureType.IMAGE:
        child = imageFeature();
        break;
      case FeatureType.QUIZ:
        child = quizFeature();
        break;
      default:
        child = Container();
        break;
    }

    return Expanded(
      child: Container(
        child: child,
      ),
    );
  }


  Widget quizFeature() {
    PageNumber pageNumber = topicPageViewModel.pageNumber;
    PageFeature quizPageFeature = topicViewModel.getPageFeature(pageNumber);

    return Container(
        child: ChangeNotifierProvider<QuizViewModel>(
          create: (_) => QuizViewModel(quizPageFeature),
          child: QuizFeature(),
        ));
  }

  Widget imageFeature() {
    // ToDo: Move filename list access to ImageFeatureViewModel or TopicViewModel
    return Provider(
        create: (_) => ImageFeatureViewModel(topicViewModel
            .getPageFeature(topicPageViewModel.pageNumber)
            .filename[0]),
        child: ImageFeatureView());
  }

  showImpulseBar() {
    return ChangeNotifierProvider<ImpulseBarViewModel>.value(
      value: impulseBarViewModel,
      child: ImpulseBar(
        onClose: topicPageViewModel.toggleImpulseBarVisible,
        audioIconSize: iconSize,
        iconSize: iconSize,
      ),
    );
  }

  Widget showImpulseBarButton() {
    return Container(
      child: Container(
        height: iconSize + 30,
        width: iconSize + 30,
        child: Card(
          elevation: 0,
          margin: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          color: primary_green,
          child: IconButton(
              icon: Icon(Icons.chat),
              iconSize: iconSize,
              onPressed: () => topicPageViewModel.toggleImpulseBarVisible()),
        ),
      ),
    );
  }

  Widget featureButton() {
    PageFeature pageFeature =
    topicViewModel.getPageFeature(topicPageViewModel.pageNumber);
    if (pageFeature == null) return Container();

    return Container(
      child: Container(
        height: iconSize + 30,
        width: iconSize + 30,
        child: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0)),
          color: primary_green,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: IconButton(
                icon: Icon(CupertinoIcons.gift),
                iconSize: iconSize,
                onPressed: () => topicPageViewModel.toggleFeatureVisible()),
          ),
        ),
      ),
    );
  }

  Widget buttonRow() {
    Widget child = Container();
    PageFeature pageFeature =
    topicViewModel.getPageFeature(topicPageViewModel.pageNumber);
    if (pageFeature == null) return Container();
    // ToDo: Move filename list access to AudioButtonBarViewModel or TopicViewModel
    if (pageFeature.type == FeatureType.AUDIO ||
        pageFeature.type == FeatureType.AUDIOIMAGE)
      child = ChangeNotifierProvider(
          create: (_) => AudioButtonBarViewModel(pageFeature.filename[1]),
          child: AudioButtonBar(audioButtonSize));
    else
      child = Container();
    return Container(child: Center(child: child));
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
              (topicPageViewModel.isImpulseBarVisible &&
                      !topicPageViewModel.isFeatureVisible)
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
