import 'package:basetalk/domain/exceptions/topic_parse_exception.dart';
import 'package:basetalk/persistence/dto/topic_dto.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_topic_dto_cache_repository.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_topic_dto_repository.dart';

class CachedTopicDTORepository implements ITopicDTORepository {
  final ITopicDTORepository remoteRepository;
  final ITopicDTOCacheRepository cacheRepository;

  CachedTopicDTORepository(this.remoteRepository, this.cacheRepository);

  @override
  Future<List<TopicDTO>> getAllTopicDTOs({requestRefresh = false}) async {
    List<TopicDTO> topicDTOs = new List();
    try {
      if (requestRefresh == true) {
        topicDTOs = await remoteRepository.getAllTopicDTOs();
      } else {
        List<TopicDTO> inCacheTopicDtos = List<TopicDTO>();

        inCacheTopicDtos = await cacheRepository.getAllTopicDTOs();

        if (inCacheTopicDtos == null || inCacheTopicDtos.isEmpty) {
          topicDTOs = await remoteRepository.getAllTopicDTOs();
        } else {
          topicDTOs = inCacheTopicDtos;
        }
      }
    } on TopicParseException catch (e) {
      print(e.toString());
    }
    return topicDTOs;
  }

  @override
  Future<TopicDTO> getTopicDTOById(int topicId) async {
    TopicDTO topicDTO = await cacheRepository.getTopicDTOById(topicId);
    if (topicDTO == null) {
      topicDTO = await remoteRepository.getTopicDTOById(topicId);
      if (topicDTO != null) cacheRepository.addTopicDTOToCache(topicDTO);
    }
    return topicDTO;
  }

  @override
  Future<List<TopicDTO>> getTopicDTOByIds(List<int> topicIds) {
    // TODO: implement
    throw UnimplementedError();
  }
}
