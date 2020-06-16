import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/blitzlicht_page/blitzlicht_page.dart';
import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/subpage_appbar.dart';
import 'package:basetalk/presentation/topic_page/arrow_navigation.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    if (pageNumber == PageNumber.three) return PageNumber.one;
  }

  PageNumber navigateBack(PageNumber pageNumber) {
    if (pageNumber == PageNumber.zero) return PageNumber.blitzlicht;
    if (pageNumber == PageNumber.one) return PageNumber.zero;
    if (pageNumber == PageNumber.two) return PageNumber.one;
    if (pageNumber == PageNumber.three) return PageNumber.two;
  }

  @override
  Widget build(BuildContext context) {
    TopicViewModel topicViewModel = Provider.of<TopicViewModel>(context);
    TopicPageViewModel subPageViewModel =
        Provider.of<TopicPageViewModel>(context);

    return Scaffold(
      drawer: MainDrawer(),
      appBar: new SubPageAppbar(
          onInfoButtonPressed: () => {print("info")},
          onFinishButtonPressed: () => {print("Finish")},
          title: topicViewModel.topic.name),
      body: ArrowNavigation(
        child: widget.child,
        onLeftPressed: () {
          if (navigateBack(subPageViewModel.pageNumber) ==
              PageNumber.blitzlicht) {
            Navigator.of(context).pushReplacementNamed(BlitzLicht.routeName,
                arguments: topicViewModel.topic.id);
          } else {
            Navigator.of(context).pushReplacementNamed(BasicTopicPage.routeName,
                arguments: TopicPageParams(topicViewModel.topic.id,
                    navigateBack(subPageViewModel.pageNumber)));
          }
        },
        onRightPressed: () {
          Navigator.of(context).pushReplacementNamed(BasicTopicPage.routeName,
              arguments: TopicPageParams(topicViewModel.topic.id,
                  navigateNext(subPageViewModel.pageNumber)));
        },
      ),
    );
  }
}

