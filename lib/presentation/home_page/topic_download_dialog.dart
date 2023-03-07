import 'package:basetalk/presentation/home_page/viewmodel/topic_download_dialog_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TopicDownloadDialog extends StatefulWidget {
  final TopicViewModel topicViewModel;

  TopicDownloadDialog(this.topicViewModel);

  @override
  State<StatefulWidget> createState() => _TopicDownloadDialogState();
}

class _TopicDownloadDialogState extends State<TopicDownloadDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopicDownloadDialogViewModel>(
      builder: (context, viewmodel, child) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            height: 360.0,
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
                    viewmodel.isLoadingState
                        ? "Thema wird heruntergeladen. Bitte warten.."
                        : 'Möchten Sie dieses Thema herunterladen?',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Container(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: viewmodel.isLoadingState
                          ? new CircularProgressIndicator()
                          : Container(),
                    )
                ),
                Padding(padding: EdgeInsets.only(top: 50.0)),
                ElevatedButton(
                  onPressed: viewmodel.isLoadingState
                      ? null
                      : () {
                          viewmodel.toggleLoadingState();
                          widget.topicViewModel.downloadTopic(() {
                            viewmodel.toggleLoadingState();
                            Navigator.of(context).pop();
                          });
                        },
                  child: Text(
                    'Herunterladen',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
