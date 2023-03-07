import 'dart:async';

import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/repositories/i_topic_repository.dart';
import 'package:basetalk/persistence/dto/topic_dto.dart';
import 'package:basetalk/persistence/dto/topic_user_information_dto.dart';
import 'package:basetalk/persistence/mapper/i_mapper.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_topic_dto_repository.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_topic_user_information_dto_repository.dart';
import 'package:meta/meta.dart';

class TopicRepository implements ITopicRepository {
  final ITopicDTORepository _topicDTORepository;
  final ITopicUserInformationDTORepository _topicUserInformationDTORepository;
  final IMapper _topicMapper;

  TopicRepository(
      {@required topicDTORepository,
      @required topicUserInformationDTORepository,
      @required topicMapper})
      : this._topicDTORepository = topicDTORepository,
        this._topicUserInformationDTORepository =
            topicUserInformationDTORepository,
        this._topicMapper = topicMapper;

  @override
  Future<List<Topic>> getAllTopics({bool requestRefresh = false}) async {
    List<Topic> topics = new List();
    List<TopicDTO> topicDTOs = await _topicDTORepository.getAllTopicDTOs(
        requestRefresh: requestRefresh);
    if (topicDTOs == null) return topics;
    for (TopicDTO topicDto in topicDTOs) {
      Topic topic = _topicMapper.map(topicDto);
      TopicUserInformationDTO topicUserInformationDTO =
          await _topicUserInformationDTORepository
              .getTopicUserInformationDTOByTopicId(topic.id);
      topic =
          _combineTopicUserInformationAndTopic(topic, topicUserInformationDTO);
      topics.add(topic);
    }
    return topics;
  }

  @override
  Future<Topic> getTopicById(int topicId) async {
    TopicDTO topicDto = await _topicDTORepository.getTopicDTOById(topicId);
    TopicUserInformationDTO topicUserInformationDTO =
        await _topicUserInformationDTORepository
            .getTopicUserInformationDTOByTopicId(topicId);
    Topic topic = _topicMapper.map(topicDto);
    return _combineTopicUserInformationAndTopic(topic, topicUserInformationDTO);
  }

  @override
  FutureOr<List<Topic>> getTopicsByIds(List<int> topicIds) async {
    List<Topic> topics = new List();
    List<TopicDTO> topicDTOs =
        await _topicDTORepository.getTopicDTOByIds(topicIds);
    for (TopicDTO topicDto in topicDTOs) {
      Topic topic = _topicMapper.map(topicDto);
      TopicUserInformationDTO topicUserInformationDTO =
          await _topicUserInformationDTORepository
              .getTopicUserInformationDTOByTopicId(topic.id);
      topic =
          _combineTopicUserInformationAndTopic(topic, topicUserInformationDTO);
      topics.add(topic);
    }
    return topics;
  }

  @override
  FutureOr<void> saveTopic(Topic topic) {
    TopicUserInformationDTO topicUserInformationDTO =
        new TopicUserInformationDTO(
            topic.id, topic.isFavorite, topic.isDownloaded, topic.isVisited);
    _topicUserInformationDTORepository.setTopicUserInformationDTOByTopicId(
        topicUserInformationDTO, topic.id);
  }

  _combineTopicUserInformationAndTopic(
      Topic topic, TopicUserInformationDTO topicUserInformationDTO) {
    if (topicUserInformationDTO != null) {
      topic.isDownloaded = topicUserInformationDTO.isDownloaded;
      topic.isFavorite = topicUserInformationDTO.isFavorite;
      topic.isVisited = topicUserInformationDTO.isVisited;
    }
    return topic;
  }
}
