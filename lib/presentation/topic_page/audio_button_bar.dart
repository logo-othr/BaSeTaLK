import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/audio_button_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioButtonBar extends StatefulWidget {
  final double audioButtonSize;

  AudioButtonBar(this.audioButtonSize);

  @override
  _AudioButtonBarState createState() => _AudioButtonBarState();
}

class _AudioButtonBarState extends State<AudioButtonBar>
    with WidgetsBindingObserver {
  AudioButtonBarViewModel audioButtonBarViewModel;

  @override
  Widget build(BuildContext context) {
    audioButtonBarViewModel = Provider.of<AudioButtonBarViewModel>(context);
    return audioButtonBar();
  }

  @override
  void dispose() {
    audioButtonBarViewModel.stopAudio();
    super.dispose();
  }

  @override
  void deactivate() {
    audioButtonBarViewModel.stopAudio();
    super.deactivate();
  }

  Widget audioButtonBar() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        audioButton(
          icon: Provider.of<AudioButtonBarViewModel>(context, listen: false)
                  .isAudioPlayerPlaying
              ? Icon(
                  Icons.pause,
                  size: widget.audioButtonSize,
                )
              : Icon(
                  Icons.play_arrow,
                  size: widget.audioButtonSize,
                ),
          onPressed: () {
            AudioButtonBarViewModel audioButtonBarViewModel =
                Provider.of<AudioButtonBarViewModel>(context, listen: false);
            if (audioButtonBarViewModel.isAudioPlayerPlaying)
              audioButtonBarViewModel.pauseAudio();
            else
              audioButtonBarViewModel.playAudio();

            ;
          },
        ),
        audioButton(
            icon: Icon(
              Icons.stop,
              size: widget.audioButtonSize,
            ),
            onPressed: () =>
                Provider.of<AudioButtonBarViewModel>(context, listen: false)
                    .stopAudio()),
      ],
    );
  }

  Widget audioButton({@required Icon icon, @required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: RawMaterialButton(
        padding: EdgeInsets.all(20),
        fillColor: primary_green,
        shape: CircleBorder(),
        child: icon,
        onPressed: onPressed,
      ),
    );
  }
}
