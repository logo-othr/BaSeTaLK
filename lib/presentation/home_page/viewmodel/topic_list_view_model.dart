import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/usecases/download_topic_data_usecase.dart';
import 'package:basetalk/domain/usecases/getListOfAllTopics.dart';
import 'package:basetalk/domain/usecases/get_topic_thumbnails_usecase.dart';
import 'package:basetalk/domain/usecases/sort_topic_list_to_fav_first.dart';
import 'package:basetalk/domain/usecases/toggle_topic_favorite_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_visited_usecase.dart';
import 'package:basetalk/domain/usecases/topics_to_viewmodels.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/cupertino.dart';

class TopicListViewModel extends ChangeNotifier {
  final GetListOfAllTopicsUseCase _getAllTopics;
  final SortTopicListToFavFirstUseCase _sortTopicListToFavFirst;
  final GetTopicThumbnailsUseCase _getTopicThumbnails;
  final ToggleTopicVisitedUseCase _toggleTopicVisited;
  final ToggleTopicFavoriteUsecase _toggleTopicFavorite;
  final TopicsToViewModelsUseCase _topicsToViewModels;
  final DownloadTopicDataUseCase _downloadTopicData;

  String _filter;

  List<TopicViewModel> topicViewModels = new List();

  bool initialized = false;

  TopicListViewModel(
      this._getAllTopics,
      this._sortTopicListToFavFirst,
      this._getTopicThumbnails,
      this._toggleTopicVisited,
      this._toggleTopicFavorite,
      this._topicsToViewModels,
      this._downloadTopicData);

  Future<List<TopicViewModel>> init() async {
    if (initialized) return filteredList();
    List<Topic> topics = await _getAllTopics(null);
    var params = new TopicsToViewModelsUseCaseParams(
        topics, _toggleTopicFavorite, _toggleTopicVisited, _downloadTopicData);
    topicViewModels = _topicsToViewModels(params);
    topicViewModels = await _sortTopicListToFavFirst(topicViewModels);
    await _getTopicThumbnails(topics);
    notifyListeners();
    initialized = true;
    return filteredList();
  }

  List<TopicViewModel> filteredList() {
    // ToDo: Move functionality in a UseCase class
    if (_filter == null || _filter.isEmpty) return topicViewModels;
    List<String> filters = _filter.split(",");
    List<TopicViewModel> filteredList = new List();
    for (TopicViewModel topicViewModel in topicViewModels) {
      for (String tag in filters) {
        if (topicViewModel.topic.tags.contains(tag))
          filteredList.add(topicViewModel);
        break;
      }
    }
    return filteredList;
  }

  TopicViewModel getTopicViewModelById(int topicId) {
    TopicViewModel result;
    for (TopicViewModel topicViewModel in topicViewModels)
      if (topicViewModel.topic.id == topicId) result = topicViewModel;
    return result;
  }

  void moveTopicToTop(Topic topic) {
    TopicViewModel tempTopicViewModel;
    for (TopicViewModel topicViewModel in topicViewModels)
      if (topicViewModel.topic.id == topic.id)
        tempTopicViewModel = topicViewModel;
    topicViewModels.remove(tempTopicViewModel);
    topicViewModels.insert(0, tempTopicViewModel);
  }


  void sort() async {
    topicViewModels = await _sortTopicListToFavFirst(topicViewModels);
    notifyListeners();
  }

  void setFilter(String value) {
    this._filter = value;
    notifyListeners();
  }
}
