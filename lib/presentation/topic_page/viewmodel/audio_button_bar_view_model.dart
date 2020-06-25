import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioButtonBarViewModel extends ChangeNotifier {
  final String audioFilePath;
  AudioPlayer audioPlayer;
  AudioCache audioCache;

  AudioButtonBarViewModel(this.audioFilePath) {
    audioPlayer = AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
  }

  void playAudio() {
    print("Play audio");
    audioCache.play(audioFilePath);
  }

  void stopAudio() {
    print("stop audio");
    audioPlayer.stop();
  }
}
