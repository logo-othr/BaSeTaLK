import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/impulse_bar_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/statistic_logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImpulseBar extends StatefulWidget {
  final VoidCallback onClose;
  final double audioIconSize;
  final double iconSize;

  ImpulseBar(
      {@required this.onClose,
      @required this.audioIconSize,
      @required this.iconSize});

  @override
  _ImpulseBarState createState() => _ImpulseBarState();
}

class _ImpulseBarState extends State<ImpulseBar> {
  ImpulseBarViewModel impulseBarViewModel;

  @override
  void dispose() {
    impulseBarViewModel.stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    impulseBarViewModel = Provider.of<ImpulseBarViewModel>(context);

    return Container(
      color: primary_green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: widget.iconSize + 30,
            child: Card(
              elevation: 0,
              color: primary_green,
              child: IconButton(
                  icon: Icon(Icons.volume_up),
                  iconSize: 100,
                  onPressed: () {
                    impulseBarViewModel.playImpulse();
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 40.0, 0),
            child: Container(
              width: 510,
              child: Text(
                impulseBarViewModel.impulse.text,
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
                impulseBarViewModel.incrementImpulseIndex();
                impulseBarViewModel.stopAudio();
                serviceLocator.get<StatisticLogger>().logEvent(
                  eventType: EventType.impulseBarNext,
                  pageNumber: Provider
                      .of<TopicPageViewModel>(context, listen: false)
                      .pageNumber,
                  topicID: Provider
                      .of<TopicPageViewModel>(context, listen: false)
                      .topicId
                      .toString(),
                  topicName: Provider
                      .of<TopicPageViewModel>(context, listen: false)
                      .topicName,
                );
              },
              child: Text(
                'Weiter',
                style: TextStyle(fontSize: 27, color: Colors.white),
              ),
            ),
          ),
          Container(
            height: widget.iconSize + 30,
            width: widget.iconSize + 30,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              color: primary_green,
              child: IconButton(
                icon: Icon(Icons.chat),
                iconSize: widget.iconSize,
                onPressed: () {
                  serviceLocator.get<StatisticLogger>().logEvent(
                    eventType: EventType.impulseBarAudio,
                    pageNumber: Provider
                        .of<TopicPageViewModel>(context,
                        listen: false)
                        .pageNumber,
                    topicID: Provider
                        .of<TopicPageViewModel>(context,
                        listen: false)
                        .topicId
                        .toString(),
                    topicName: Provider.of<TopicPageViewModel>(context,
                        listen: false)
                        .topicName,
                  );
                  widget.onClose();
                  impulseBarViewModel.stopAudio();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
