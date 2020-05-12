import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/usecases/download_topic_data_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_favorite_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_visited_usecase.dart';
import 'package:flutter/cupertino.dart';

class TopicViewModel extends ChangeNotifier {
  final ToggleTopicVisitedUseCase _toogleTopicVisited;
  final ToggleTopicFavoriteUsecase _toggleTopicFavorite;
  final DownloadTopicDataUseCase _downloadTopicDataUseCase;

  final Topic topic;

  TopicViewModel(this.topic, this._toggleTopicFavorite,
      this._toogleTopicVisited, this._downloadTopicDataUseCase);

  void toggleFavorite() async {
    await _toggleTopicFavorite(topic);
    notifyListeners();
  }

  void toggleVisited() async {
    await _toogleTopicVisited(topic);
    notifyListeners();
  }

  Future<void> downloadTopic(Function callback) async {
    DownloadTopicDataUseCaseParams params =
        DownloadTopicDataUseCaseParams(this.topic, callback);
    await _downloadTopicDataUseCase(params);
    notifyListeners();
  }
}
