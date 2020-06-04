import 'dart:ui';

import 'package:basetalk/domain/entities/feature_type.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/impulse_bar.dart';
import 'package:basetalk/presentation/view/colors.dart';
import 'package:basetalk/presentation/viewmodel/impulse_bar_view_model.dart';
import 'package:basetalk/presentation/viewmodel/sub_page_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubPage extends StatefulWidget {
  static const routeName = "/subpage";

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  double rowDividerHeight;
  double iconSize;
  double audioButtonSize;

  TopicViewModel topicViewModel;
  SubPageViewModel subPageViewModel;
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
    subPageViewModel = Provider.of<SubPageViewModel>(context);
    var pageNumber = subPageViewModel.pageNumber;
    var impulses = topicViewModel.getImpulses(pageNumber);
    impulseBarViewModel = ImpulseBarViewModel(impulses);
    subPageViewModel.pageFeature = topicViewModel.getPageFeature(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    initLayoutSizes();
    initProviders(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: rowDividerHeight),
          subPageViewModel.isFeatureVisible ? featureRow() : Container(),
          SizedBox(height: rowDividerHeight),
          featureImpulseRow(),
          SizedBox(height: rowDividerHeight)
        ],
      ),
    );
  }

  showImpulseBar() {
    return ChangeNotifierProvider<ImpulseBarViewModel>.value(
      value: impulseBarViewModel,
      child: ImpulseBar(
        onClose: subPageViewModel.toggleImpulseBarVisible,
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
            onPressed: () => subPageViewModel.toggleImpulseBarVisible()),
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
          onPressed: () {
            subPageViewModel.toggleFeatureVisible();
          },
        ),
      ),
    );
  }

  Widget buttonRow() {
    Widget child;
    var type = subPageViewModel.pageFeature.type;
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
            subPageViewModel.isFeatureVisible ? buttonRow() : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              featureButton(),
              subPageViewModel.isImpulseBarVisible
                  ? showImpulseBar()
                  : showImpulseBarButton()
            ],
          ),
        ],
      ),
    );
  }

  Widget featureRow() {
    Widget child = Container();
    var type = subPageViewModel.pageFeature.type;
    if (type == FeatureType.AUDIO || type == FeatureType.AUDIOIMAGE)
      child = Container();
    else if (type == FeatureType.IMAGE)
      child = imageFeature();
    else if (type == FeatureType.QUIZ) child = Container();

    return Expanded(
      child: Container(
        color: Colors.white,
        child: child,
      ),
    );
  }

  Widget imageFeature() {
    return Image(
      image: AssetImage("assets/img/example_no_vc.jpg"),
    );
  }
}

class SubPageParams {
  final int topicId;
  final PageNumber pageNumber;

  SubPageParams(this.topicId, this.pageNumber);
}
