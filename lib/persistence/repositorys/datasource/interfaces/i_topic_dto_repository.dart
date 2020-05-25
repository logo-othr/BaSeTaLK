import 'package:basetalk/persistence/dto/topic_dto.dart';

abstract class ITopicDTORepository {
  Future<List<TopicDTO>> getAllTopicDTOs({requestRefresh = false});

  Future<TopicDTO> getTopicDTOById(int topicId);

  Future<List<TopicDTO>> getTopicDTOByIds(List<int> topicIds);
}
