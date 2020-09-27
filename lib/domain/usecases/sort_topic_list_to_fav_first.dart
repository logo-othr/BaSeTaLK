import 'package:basetalk/domain/usecases/base_usecase.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';

class SortTopicListToFavFirstUseCase
    extends BaseUseCase<List<TopicViewModel>, List<TopicViewModel>> {
  SortTopicListToFavFirstUseCase();

  @override
  List<TopicViewModel> call(List<TopicViewModel> topicsToSort) {
    List<TopicViewModel> sortedTopics = new List();
    for (int i = 0; i < topicsToSort.length; i++) {
      TopicViewModel topicViewModel = topicsToSort[i];
      if (topicViewModel.topic.isFavorite == true)
        sortedTopics.insert(0, topicViewModel);
      else
        sortedTopics.add(topicViewModel);
    }
    return sortedTopics;
  }
}
