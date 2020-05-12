import 'dart:async';

import 'package:basetalk/persistance/dto/topic_dto.dart';

abstract class ITopicDTOCacheRepository {
  FutureOr<void> addTopicDTOToCache(TopicDTO topic);

  FutureOr<List<TopicDTO>> getAllTopicDTOs();

  FutureOr<TopicDTO> getTopicDTOById(int id);

  FutureOr<List<TopicDTO>> getTopicDTOsByIds(List<int> ids);

  FutureOr<void> saveTopicDTOsToCache(List<TopicDTO> topics);
}
