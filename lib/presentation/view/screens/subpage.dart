import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/view/subpage_appbar.dart';
import 'package:basetalk/presentation/viewmodel/sub_page_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/topic_list_view_model.dart';
import '../drawer.dart';

class SubPage extends StatefulWidget {
  static const routeName = "/subpage";

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    TopicListViewModel topicListViewModel =
    Provider.of<TopicListViewModel>(context);
    final SubPageParams params = ModalRoute
        .of(context)
        .settings
        .arguments;
    TopicViewModel pageTopicViewModel =
    topicListViewModel.getTopicViewModelById(params.topicId);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TopicViewModel>.value(value: pageTopicViewModel),
        ChangeNotifierProvider<SubPageViewModel>(
            create: (_) => SubPageViewModel())
      ],
      child: new Scaffold(
        drawer: MainDrawer(),
        appBar: new SubPageAppbar(
            new Text(Provider
                .of<TopicViewModel>(context)
                .topic
                .name)),
        body: Container(),
      ),
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
