import 'package:audioplayers/audioplayers.dart';
import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:flutter/cupertino.dart';

class AudioButtonBarViewModel extends ChangeNotifier {
  final String audioName;
  AudioPlayer audioPlayer;
  Media audioMedia;
  bool isAudioPlayerPlaying = false;

  AudioButtonBarViewModel(this.audioName) {
    audioPlayer = serviceLocator.get<AudioPlayer>();
    audioPlayer.onPlayerStateChanged.listen(
        (PlayerState s) => {_changePlayingState(s == PlayerState.playing)});
  }

  void _changePlayingState(isPlaying) {
    this.isAudioPlayerPlaying = isPlaying;
    notifyListeners();
  }

  void pauseAudio() async {
    audioPlayer.pause();
  }

  void playAudio() async {
    if (audioMedia == null) {
      IMediaRepository mediaRepository = serviceLocator.get<IMediaRepository>();
      Media media = await mediaRepository.getMediaFile(audioName);
      this.audioMedia = media;
    }
    print("Play audio");
    DeviceFileSource source = DeviceFileSource(audioMedia.file.path);
    audioPlayer.play(source);
  }

  void stopAudio() {
    print("stop audio");
    audioPlayer.stop();
  }
}
