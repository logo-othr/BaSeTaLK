import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/repositories/i_topic_repository.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';

class ToggleTopicFavoriteUsecase extends BaseUseCase<void, Topic> {
  final ITopicRepository _topicRepository;

  ToggleTopicFavoriteUsecase(this._topicRepository);

  @override
  Future<void> call(Topic topic) async {
    topic.toggleFavorite();
    await _topicRepository.saveTopic(topic);
    return topic;
  }
}
