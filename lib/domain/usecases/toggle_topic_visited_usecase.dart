import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/repositories/i_topic_repository.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';

class ToggleTopicVisitedUseCase extends BaseUseCase<void, Topic> {
  final ITopicRepository _topicRepository;

  ToggleTopicVisitedUseCase(this._topicRepository);

  @override
  Future<void> call(Topic topic) async {
    topic.toggleVisited();
    await _topicRepository.saveTopic(topic);
  }
}
