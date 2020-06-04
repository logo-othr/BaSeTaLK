import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/impulse.dart';
import 'package:basetalk/domain/entities/page_content.dart';
import 'package:basetalk/domain/entities/page_number.dart';
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

  PageContent getPageContent(PageNumber pageNumber) {
    var result;
    for (PageContent pageContent in topic.pageContents)
      if (pageContent.pageNumber == pageNumber) result = pageContent;
    return result;
  }

  PageFeature getPageFeature(PageNumber pageNumber) {
    var pageContent = getPageContent(pageNumber);
    return pageContent.pageFeature;
  }

  Impulse getImpulse(PageNumber pageNumber, int index) {
    return topic.getImpulse(pageNumber, index);
  }

  List<Impulse> getImpulses(PageNumber pageNumber) {
    return topic.getImpulses(pageNumber);
  }
}
