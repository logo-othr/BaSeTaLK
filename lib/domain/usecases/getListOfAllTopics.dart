import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/repositorys/i_topic_repository.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';

class GetListOfAllTopicsUseCase implements BaseUseCase<List<Topic>, void> {
  final ITopicRepository _topicRepository;

  GetListOfAllTopicsUseCase(this._topicRepository);

  @override
  Future<List<Topic>> call(_) {
    return _topicRepository.getAllTopics();
  }
}
