import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/repositories/i_topic_repository.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';

class GetListOfAllTopicsUseCase implements BaseUseCase<List<Topic>, bool> {
  final ITopicRepository _topicRepository;

  GetListOfAllTopicsUseCase(this._topicRepository);

  @override
  Future<List<Topic>> call(bool requestRefresh) {
    return _topicRepository.getAllTopics(requestRefresh: true);
  }
}
