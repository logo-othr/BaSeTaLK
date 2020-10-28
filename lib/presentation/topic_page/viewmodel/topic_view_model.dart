import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/impulse.dart';
import 'package:basetalk/domain/entities/information_content.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/entities/page_content.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:basetalk/domain/usecases/download_topic_data_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_favorite_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_visited_usecase.dart';
import 'package:basetalk/statistic_logger.dart';
import 'package:flutter/cupertino.dart';

class TopicViewModel extends ChangeNotifier {
  final ToggleTopicVisitedUseCase _toogleTopicVisited;
  final ToggleTopicFavoriteUsecase _toggleTopicFavorite;
  final DownloadTopicDataUseCase _downloadTopicDataUseCase;

  final Topic topic;

  TopicViewModel(this.topic, this._toggleTopicFavorite,
      this._toogleTopicVisited, this._downloadTopicDataUseCase);

  String getConversationDepthAssetPath() {
    if (topic.conversationDepth != null) {
      if (topic.conversationDepth == 1)
        return 'assets/img/conversation_depth_1.png';
      if (topic.conversationDepth == 2)
        return 'assets/img/conversation_depth_2.png';
      if (topic.conversationDepth == 3)
        return 'assets/img/conversation_depth_3.png';
    }
    return "";
  }

  void toggleFavorite() async {
    await _toggleTopicFavorite(topic);
    serviceLocator.get<StatisticLogger>().logEvent(
        eventType: topic.isFavorite
            ? EventType.topicFavoriteCheck
            : EventType.topicFavoriteUncheck,
        topicID: topic.id.toString(),
        topicName: topic.name);
    notifyListeners();
  }

  void toggleVisited() async {
    await _toogleTopicVisited(topic);
    serviceLocator.get<StatisticLogger>().logEvent(
        eventType: topic.isVisited ? EventType.topicVisitedCheck : EventType
            .topicVisitedUncheck,
        topicID: topic.id.toString(),
        topicName: topic.name);
    notifyListeners();
  }

  Future<void> downloadTopic(Function callback) async {
    DownloadTopicDataUseCaseParams params =
    DownloadTopicDataUseCaseParams(this.topic, callback);
    await _downloadTopicDataUseCase(params);
    notifyListeners();
  }

  PageContent getPageContent(PageNumber pageNumber) {
    return topic.pageContents
        .firstWhere((element) => element.pageNumber == pageNumber);
  }

  PageFeature getPageFeature(PageNumber pageNumber) {
    var pageContent = getPageContent(pageNumber);
    return pageContent.pageFeature;
  }

  InformationContent getInformationContent(PageNumber pageNumber) {
    if (pageNumber == PageNumber.zero) return topic.frontPageInformationContent;
    var pageContent = getPageContent(pageNumber);
    return pageContent.informationContent;
  }

  Impulse getImpulse(PageNumber pageNumber, int index) {
    return topic.getImpulse(pageNumber, index);
  }

  List<Impulse> getImpulses(PageNumber pageNumber) {
    return topic.getImpulses(pageNumber);
  }

  _getBackgroundImageFileName(PageNumber pageNumber) {
    if (pageNumber == PageNumber.zero) return topic.frontPageImageName;
    PageContent pageContent = getPageContent(pageNumber);
    return pageContent.backgroundImage;
  }

  Future<Media> getBackgroundImage(PageNumber pageNumber) async {
    String backgroundImgFileName = _getBackgroundImageFileName(pageNumber);
    IMediaRepository mediaRepository = serviceLocator.get<IMediaRepository>();
    return await mediaRepository.getMediaFile(backgroundImgFileName);
  }

  Future<Media> getThumbnail() async {
    String backgroundImgFileName = topic.thumbnail;
    IMediaRepository mediaRepository = serviceLocator.get<IMediaRepository>();
    return await mediaRepository.getMediaFile(backgroundImgFileName);
  }
}
