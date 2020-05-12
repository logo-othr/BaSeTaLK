import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';
import 'package:basetalk/persistance/repositorys/topic_repository.dart';

class ToggleTopicVisitedUseCase extends BaseUseCase<void, Topic> {
  final TopicRepository _topicRepository;

  ToggleTopicVisitedUseCase(this._topicRepository);

  @override
  Future<void> call(Topic topic) async {
    topic.toggleVisited();
    await _topicRepository.saveTopic(topic);
  }
}
