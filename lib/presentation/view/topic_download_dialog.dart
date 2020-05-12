import 'package:basetalk/presentation/view/colors.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';

class TopicDownloadDialog extends StatefulWidget {
  final TopicViewModel topicViewModel;

  TopicDownloadDialog(this.topicViewModel);

  @override
  State<StatefulWidget> createState() => _TopicDownloadDialogState();
}

class _TopicDownloadDialogState extends State<TopicDownloadDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 300.0,
        width: 600.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                widget.topicViewModel.topic.name,
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Bitte warten.',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            FlatButton(
                onPressed: () {
                  widget.topicViewModel.downloadTopic(() {
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  'Herrunterladen',
                  style: TextStyle(color: primary_green, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
  }
}
