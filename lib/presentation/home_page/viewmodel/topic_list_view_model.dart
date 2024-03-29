import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/usecases/download_topic_data_usecase.dart';
import 'package:basetalk/domain/usecases/get_list_of_all_topics_usecase.dart';
import 'package:basetalk/domain/usecases/get_topic_thumbnails_usecase.dart';
import 'package:basetalk/domain/usecases/sort_topic_list_to_fav_first.dart';
import 'package:basetalk/domain/usecases/toggle_topic_favorite_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_visited_usecase.dart';
import 'package:basetalk/domain/usecases/topics_to_viewmodels_usecase.dart';
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

  TextEditingController editingController = TextEditingController();

  String _filter;

  List<TopicViewModel> topicViewModels = new List();

  bool initialized = false;

  bool _showFavIcon = true;

  bool get isShowFavIconSet {
    return _showFavIcon;
  }

  List<String> results = List();

  set isShowFavIconSet(bool value) {
    _showFavIcon = value;
    notifyListeners();
  }

  bool _showVisitedIcon = true;

  bool get isShowVisitedIconSet {
    return _showVisitedIcon;
  }

  set isShowVisitedIconSet(bool value) {
    _showVisitedIcon = value;
    notifyListeners();
  }

  bool _showDownloadIcon = true;

  bool get isShowDownloadIconSet {
    return _showDownloadIcon;
  }

  set isShowDownloadIconSet(bool value) {
    _showDownloadIcon = value;
    notifyListeners();
  }

  TopicListViewModel(
      this._getAllTopics,
      this._sortTopicListToFavFirst,
      this._getTopicThumbnails,
      this._toggleTopicVisited,
      this._toggleTopicFavorite,
      this._topicsToViewModels,
      this._downloadTopicData);

  List<TopicViewModel> filteredTopicList = List();

  Future<List<TopicViewModel>> init({@required bool requestRefresh}) async {
    _filter = "";
    if (initialized) return filteredList();
    List<Topic> topics = await _getAllTopics(requestRefresh);
    var params = new TopicsToViewModelsUseCaseParams(
        topics, _toggleTopicFavorite, _toggleTopicVisited, _downloadTopicData);
    topicViewModels = _topicsToViewModels(params);
    topicViewModels = await _sortTopicListToFavFirst(topicViewModels);
    await _getTopicThumbnails(topics);
    initialized = true;
    filteredTopicList = topicViewModels;

    notifyListeners();
    return filteredList();
  }


  List<TopicViewModel> filteredList() {
    // ToDo: Move functionality in a UseCase class
    if (_filter == null || _filter.isEmpty) {
      filteredTopicList = topicViewModels;
    } else {
      List<String> filters = _filter.split(",");
      List<TopicViewModel> filteredList = new List();
      for (TopicViewModel topicViewModel in topicViewModels) {
        for (String tag in filters) {
          if (topicViewModel.topic.tags.contains(tag))
            filteredList.add(topicViewModel);
          break;
        }
      }
      if (filteredList.isEmpty) filteredList = topicViewModels;
      filteredTopicList = filteredList;
    }
    sort();
    return filteredTopicList;
  }

  TopicViewModel getTopicViewModelById(int topicId) {
    TopicViewModel result;
    for (TopicViewModel topicViewModel in topicViewModels)
      if (topicViewModel.topic.id == topicId) result = topicViewModel;
    return result;
  }

  void sort() {
    filteredTopicList = _sortTopicListToFavFirst(filteredTopicList);
  }

  void update() {
    filteredList();
    notifyListeners();
  }

  void setFilter(String value) {
    this.isSearchResultBoxVisible = false;
    this._filter = value;
    filteredList();
    notifyListeners();
  }

  bool isSearchResultBoxVisible = false;

  void getResults(String value) {
    if (value.isNotEmpty) {
      List<String> tagResults = List();
      for (TopicViewModel topicViewModel in topicViewModels) {
        for (String tag in topicViewModel.topic.tags) {
          if (tag.startsWith(value) && !tagResults.contains(tag))
            tagResults.add(tag);
        }
      }

      this.results = tagResults;
    } else {
      this.results.clear();
    }
    isSearchResultBoxVisible = (results.length > 0);
    notifyListeners();
  }

  void clearSearch() {
    this.results.clear();
    this.isSearchResultBoxVisible = false;
    this.setFilter("");
    notifyListeners();
  }
}
