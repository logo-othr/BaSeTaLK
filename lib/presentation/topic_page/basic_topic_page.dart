import 'dart:ui';

import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/feature_type.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/information_dialog.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/presentation/subpage_appbar.dart';
import 'package:basetalk/presentation/topic_page/arrow_navigation.dart';
import 'package:basetalk/presentation/topic_page/information_bar.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:basetalk/statistic_logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BasicTopicPage extends StatefulWidget {
  final Widget child;

  BasicTopicPage({@required this.child});

  @override
  _BasicTopicPageState createState() => _BasicTopicPageState();
}

class _BasicTopicPageState extends State<BasicTopicPage> {
  Future<FileImage> loadBackgroundImage() async {
    Media backgroundMedia = await topicViewModel.getBackgroundImage(pageNumber);
    return FileImage(backgroundMedia.file);
  }


  TopicViewModel topicViewModel;
  TopicPageViewModel topicPageViewModel;
  PageNumber pageNumber;

  @override
  Widget build(BuildContext context) {
    topicViewModel = Provider.of<TopicViewModel>(context);
    topicPageViewModel = Provider.of<TopicPageViewModel>(context);
    pageNumber = topicPageViewModel.pageNumber;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: new SubPageAppbar(
          onInfoButtonPressed: () =>
              {topicPageViewModel.toggleInfoDialogVisible()},
          onFinishButtonPressed: () => {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => InformationDialog(
                    description: "Möchten Sie zur Bewertung des Themas gehen?",
                    buttonText: "Thema bewerten",
                    onActionPressed: () {
                      serviceLocator.get<StatisticLogger>().logEvent(
                            eventType: EventType.topicCloseToRating,
                            pageNumber: pageNumber,
                            topicID: topicViewModel.topic.id.toString(),
                            topicName: topicViewModel.topic.name,
                          );
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, RouteName.RATING,
                          arguments: topicViewModel.topic.id);
                    },
                  ),
                )
              },
          title: topicViewModel.topic.name),
      body: ArrowNavigation(
          child: FutureBuilder(
            future: loadBackgroundImage(),
            builder: (BuildContext context, AsyncSnapshot<FileImage> image) {
              ImageProvider background =
                  AssetImage("assets/img/placeholder.png");
              if (image.hasData) background = image.data;
              return Container(
                  child: Stack(
                fit: StackFit.expand,
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: background,
                    fit: BoxFit.cover,
                  ),
                  BackdropFilter(
                    filter: topicPageViewModel.isFeatureVisible &&
                            topicViewModel
                                    .getPageFeature(
                                        topicPageViewModel.pageNumber)
                                    .type !=
                                FeatureType.AUDIO
                        ? ImageFilter.blur(sigmaX: 7, sigmaY: 7)
                        : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: widget.child,
                  ),
                  topicPageViewModel.isInfoDialogVisible
                      ? InformationBar(
                          title: topicViewModel
                              .getInformationContent(pageNumber)
                              .heading,
                          description: topicViewModel
                              .getInformationContent(pageNumber)
                              .content,
                          onClosePressed: () {
                            topicPageViewModel.toggleInfoDialogVisible();
                          },
                        )
                      : Container(),
                ],
              ));
            },
          ),
          onLeftPressed: () => topicPageViewModel.navigate(
              topicPageViewModel.pageNumber,
              topicViewModel.topic.id,
              Direction.left),
          onRightPressed: () => topicPageViewModel.navigate(
              topicPageViewModel.pageNumber,
              topicViewModel.topic.id,
              Direction.right)),
    );
  }
}
