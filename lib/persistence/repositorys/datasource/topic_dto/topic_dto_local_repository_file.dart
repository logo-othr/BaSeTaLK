import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:basetalk/domain/exceptions/topic_parse_exception.dart';
import 'package:basetalk/persistence/dto/topic_dto.dart';
import 'package:basetalk/persistence/repositorys/datasource/interfaces/i_topic_dto_cache_repository.dart';
import 'package:basetalk/persistence/topic_path_provider.dart';

class TopicDTOLocalFileRepository implements ITopicDTOCacheRepository {
  TopicPathProvider _topicPathProvider;

  TopicDTOLocalFileRepository(this._topicPathProvider);

  @override
  FutureOr<void> addTopicDTOToCache(TopicDTO topic) {}

  @override
  FutureOr<List<TopicDTO>> getAllTopicDTOs() async {
    File file = File(_topicPathProvider.appCacheRootPath + "topics.json");
    if (!await file.exists()) return null;
    String jsonString = await file.readAsString();

    List<TopicDTO> topicDtos = (jsonDecode(jsonString) as List).map((i) {
      try {
        return TopicDTO.fromJson(i);
      } on TypeError catch (e) {
        throw TopicParseException(e.toString(), i.toString());
      }
    }).toList();
    return topicDtos;
  }

  @override
  FutureOr<TopicDTO> getTopicDTOById(int id) async {
    // ToDo: improve performance
    TopicDTO result;
    List<TopicDTO> topicDTOs = await getAllTopicDTOs();
    for (TopicDTO topicDTO in topicDTOs)
      if (topicDTO.id == id) result = topicDTO;
    return result;
  }

  @override
  FutureOr<List<TopicDTO>> getTopicDTOsByIds(List<int> ids) async {
    List<TopicDTO> results = List();
    List<TopicDTO> topicDTOs = await getAllTopicDTOs();
    for (TopicDTO topicDTO in topicDTOs)
      for (int id in ids) if (topicDTO.id == id) results.add(topicDTO);
    return results;
  }

  @override
  FutureOr<void> saveTopicDTOsToCache(List<TopicDTO> topics) {}
}
