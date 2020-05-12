import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';
import 'package:basetalk/domain/usecases/download_topic_data_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_favorite_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_visited_usecase.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';

class TopicsToViewModelsUseCase
    extends BaseUseCase<List<TopicViewModel>, TopicsToViewModelsUseCaseParams> {
  @override
  List<TopicViewModel> call(TopicsToViewModelsUseCaseParams params) {
    List<TopicViewModel> topicViewModels = new List();
    for (Topic topic in params.topics) {
      TopicViewModel topicViewModel = new TopicViewModel(
          topic,
          params.toggleUserFavorite,
          params.toggleUserVisited,
          params.downloadTopicDataUseCase);
      topicViewModels.add(topicViewModel);
    }
    return topicViewModels;
  }
}

class TopicsToViewModelsUseCaseParams {
  List<Topic> topics;
  ToggleTopicFavoriteUsecase toggleUserFavorite;
  ToggleTopicVisitedUseCase toggleUserVisited;
  DownloadTopicDataUseCase downloadTopicDataUseCase;

  TopicsToViewModelsUseCaseParams(this.topics, this.toggleUserFavorite,
      this.toggleUserVisited, this.downloadTopicDataUseCase);
}
