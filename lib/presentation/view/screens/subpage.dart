import 'dart:ui';

import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/view/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double heightFactor = deviceHeight / 100;
    iconSize = 17 * heightFactor;
    audioButtonSize = 12 * heightFactor;
    rowDividerHeight = 5 * heightFactor;
    topicViewModel = Provider.of<TopicViewModel>(context);
    subPageViewModel = Provider.of<SubPageViewModel>(context);
    subPageViewModel.pageImpulseCount =
        topicViewModel.getImpulseCount(subPageViewModel.pageNumber);

    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Spacer(),
          SizedBox(
            height: rowDividerHeight,
          ),
          subPageViewModel.isFeatureVisible
              ? featureRow(
                  topicViewModel.getPageFeature(subPageViewModel.pageNumber))
              : Container(),
          // Spacer(),
          SizedBox(
            height: rowDividerHeight,
          ),
          featureImpulseRow(),
          SizedBox(
            height: rowDividerHeight,
          )
        ],
      ),
    );
  }

  showImpulseBar() {
    return Container(
      color: primary_green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Card(
            elevation: 0,
            color: primary_green,
            child: IconButton(
              icon: Icon(Icons.close),
              iconSize: 100,
              onPressed: () {
                subPageViewModel.toggleImpulseBarVisible();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 40.0, 0),
            child: Container(
              width: 510,
              child: Text(
                topicViewModel
                    .getImpulse(subPageViewModel.pageNumber,
                    subPageViewModel.getImpulseIndex())
                    .text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
          ),
          ButtonTheme(
            height: 50,
            child: RaisedButton(
              color: Colors.black,
              onPressed: () {
                subPageViewModel.incrementImpulseIndex();
              },
              child: Text(
                'Weiter',
                style: TextStyle(fontSize: 27, color: Colors.white),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              color: primary_green,
              child: IconButton(
                icon: Icon(Icons.chat),
                iconSize: iconSize,
                onPressed: () {
                  // Audio-Output
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showImpulseBarButton() {
    return Container(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: primary_green,
        child: IconButton(
          icon: Icon(Icons.chat),
          iconSize: iconSize,
          onPressed: () {
            subPageViewModel.toggleImpulseBarVisible();
          },
        ),
      ),
    );
  }

  Widget featureButton() {
    return Container(
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
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
    return Container(
      color: Colors.white,
      child: Center(child: audioButtonBar()),
    );
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
          Center(child: subPageViewModel.isFeatureVisible
              ? buttonRow()
              : Container(),),
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

  Widget featureRow(PageFeature pageFeature) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: imageFeature(),
        // ToDo: Create child depending on pageFeature
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
