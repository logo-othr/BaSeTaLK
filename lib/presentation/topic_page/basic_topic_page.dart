import 'dart:ui';

import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/blitzlicht_page/blitzlicht_page.dart';
import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/subpage_appbar.dart';
import 'package:basetalk/presentation/topic_page/arrow_navigation.dart';
import 'package:basetalk/presentation/topic_page/information_bar.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BasicTopicPage extends StatefulWidget {
  static const routeName = "/basictopic";

  final Widget child;

  BasicTopicPage({@required this.child});

  @override
  _BasicTopicPageState createState() => _BasicTopicPageState();
}

class _BasicTopicPageState extends State<BasicTopicPage> {
  PageNumber navigateNext(PageNumber pageNumber) {
    if (pageNumber == PageNumber.zero) return PageNumber.one;
    if (pageNumber == PageNumber.one) return PageNumber.two;
    if (pageNumber == PageNumber.two) return PageNumber.three;
    if (pageNumber == PageNumber.three) return PageNumber.rating;
  }

  PageNumber navigateBack(PageNumber pageNumber) {
    if (pageNumber == PageNumber.zero) return PageNumber.blitzlicht;
    if (pageNumber == PageNumber.one) return PageNumber.zero;
    if (pageNumber == PageNumber.two) return PageNumber.one;
    if (pageNumber == PageNumber.three) return PageNumber.two;
  }

  Future<FileImage> loadBackgroundImage() async {
    Media backgroundMedia = await topicViewModel.getBackgroundImage(pageNumber);
    return FileImage(backgroundMedia.file);
  }

// ToDo: precache images

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
          onFinishButtonPressed: () => {print("Finish")},
          title: topicViewModel.topic.name),
      body: ArrowNavigation(
        child: FutureBuilder(
          future: loadBackgroundImage(),
          builder: (BuildContext context, AsyncSnapshot<FileImage> image) {
            ImageProvider background = AssetImage("assets/img/placeholder.png");
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
                  filter: topicPageViewModel.isFeatureVisible
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
        onLeftPressed: () {
          if (navigateBack(topicPageViewModel.pageNumber) ==
              PageNumber.blitzlicht) {
            Navigator.of(context).pushReplacementNamed(BlitzLicht.routeName,
                arguments: topicViewModel.topic.id);
          } else {
            Navigator.of(context).pushReplacementNamed(BasicTopicPage.routeName,
                arguments: TopicPageParams(topicViewModel.topic.id,
                    navigateBack(topicPageViewModel.pageNumber)));
          }
        },
        onRightPressed: () {
          Navigator.of(context).pushReplacementNamed(BasicTopicPage.routeName,
              arguments: TopicPageParams(topicViewModel.topic.id,
                  navigateNext(topicPageViewModel.pageNumber)));
        },
      ),
    );
  }
}
