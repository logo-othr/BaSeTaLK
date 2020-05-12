import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';
import 'package:basetalk/persistance/repositorys/topic_repository.dart';

class GetListOfAllTopicsUseCase implements BaseUseCase<List<Topic>, void> {
  final TopicRepository _topicRepository;

  GetListOfAllTopicsUseCase(this._topicRepository);

  @override
  Future<List<Topic>> call(_) {
    return _topicRepository.getAllTopics();
  }
}
