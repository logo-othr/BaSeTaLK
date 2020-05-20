import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/view/subpage_appbar.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../drawer.dart';

class SubPage extends StatefulWidget {
  static const routeName = "/subpage";

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: MainDrawer(),
        appBar: new SubPageAppbar(
            new Text(Provider
                .of<TopicViewModel>(context)
                .topic
                .name)),
        body: Container(),
    );
  }

  @override
  initState() {
    super.initState();
  }
}

class SubPageParams {
  final int topicId;
  final PageNumber pageNumber;

  SubPageParams(this.topicId, this.pageNumber);
}
