import 'package:audioplayers/audioplayers.dart';
import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/impulse.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositories/i_media_repository.dart';
import 'package:flutter/material.dart';

class ImpulseBarViewModel extends ChangeNotifier {
  final AudioPlayer audioPlayer = serviceLocator.get<AudioPlayer>();
  final List<Impulse> impulses;
  int _pageImpulseIndex = 0;
  Impulse impulse;

  ImpulseBarViewModel(this.impulses) {
    impulse = impulses.first;
  }

  playImpulse() async {
    IMediaRepository mediaRepository = serviceLocator.get<IMediaRepository>();
    Media media = await mediaRepository
        .getMediaFile(impulses[_pageImpulseIndex].audioFileName);
    print("Play audio");
    DeviceFileSource source = DeviceFileSource(media.file.path);
    audioPlayer.play(source);
  }

  void stopAudio() {
    print("stop audio");
    audioPlayer.stop();
  }

  incrementImpulseIndex() {
    if (_pageImpulseIndex >= impulses.length - 1)
      _pageImpulseIndex = 0;
    else
      _pageImpulseIndex++;
    impulse = impulses[_pageImpulseIndex];
    notifyListeners();
  }
}
