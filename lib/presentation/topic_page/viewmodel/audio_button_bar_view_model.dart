import 'package:audioplayers/audioplayers.dart';
import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:flutter/cupertino.dart';

class AudioButtonBarViewModel extends ChangeNotifier {
  final String audioName;
  AudioPlayer audioPlayer;
  Media audioMedia;

  AudioButtonBarViewModel(this.audioName) {
    audioPlayer = serviceLocator.get<AudioPlayer>();
  }

  void playAudio() async {
    if (audioMedia == null) {
      IMediaRepository mediaRepository = serviceLocator.get<IMediaRepository>();
      Media media = await mediaRepository.getMediaFile(audioName);
      this.audioMedia = media;
    }
    print("Play audio");
    audioPlayer.play(audioMedia.file.path, isLocal: true);
  }

  void stopAudio() {
    print("stop audio");
    audioPlayer.stop();
  }
}
