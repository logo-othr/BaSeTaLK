import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/view/arrow_navigation.dart';
import 'package:basetalk/presentation/view/drawer.dart';
import 'package:basetalk/presentation/view/screens/subpage.dart';
import 'package:basetalk/presentation/view/subpage_appbar.dart';
import 'package:basetalk/presentation/viewmodel/sub_page_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
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
    if (pageNumber == PageNumber.one) return PageNumber.two;
    if (pageNumber == PageNumber.two) return PageNumber.three;
    if (pageNumber == PageNumber.three) return PageNumber.one;
  }

  @override
  Widget build(BuildContext context) {
    TopicViewModel topicViewModel = Provider.of<TopicViewModel>(context);
    SubPageViewModel subPageViewModel = Provider.of<SubPageViewModel>(context);
    int pageNumber = 0;
    if (subPageViewModel.pageNumber == PageNumber.one) pageNumber = 1;
    if (subPageViewModel.pageNumber == PageNumber.two) pageNumber = 2;
    if (subPageViewModel.pageNumber == PageNumber.three) pageNumber = 3;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: new SubPageAppbar(),
      body: ArrowNavigation(
        child: widget.child,
        onLeftPressed: () {
          print("Links");
        },
        onRightPressed: () {
          Navigator.of(context).pushReplacementNamed(BasicTopicPage.routeName,
              arguments: SubPageParams(topicViewModel.topic.id,
                  navigateNext(subPageViewModel.pageNumber)));
        },
      ),
    );
  }
}

void nachLinks() {}
