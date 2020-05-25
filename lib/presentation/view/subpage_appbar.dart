import 'package:basetalk/presentation/viewmodel/sub_page_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    TopicViewModel topicViewModel = Provider.of<TopicViewModel>(context);
    SubPageViewModel subPageViewModel = Provider.of<SubPageViewModel>(context);
    return AppBar(
      title: Text(topicViewModel.topic.name +
          " " +
          subPageViewModel.pageNumber.toString()),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.check,
            color: Colors.black,
          ),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
          icon: Icon(
            Icons.info,
            color: Colors.black,
          ),
          onPressed: () {
            subPageViewModel.toggleInfoDialogVisible();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
