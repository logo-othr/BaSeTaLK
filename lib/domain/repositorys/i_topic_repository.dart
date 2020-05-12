import 'dart:async';

import 'package:basetalk/domain/entities/topic.dart';

/// [ITopicRepository] handles data persistence for [Topic].
/// Defines a clean interface for TopicRepositories. By using FutureOr,
/// the interface can be implemented by a repository that does not perform
/// asynchronous operations. An example would be a repository that represents a
/// local memory cache.

abstract class ITopicRepository {
  FutureOr<List<Topic>> getAllTopics();

  FutureOr<Topic> getTopicById(int topicId);

  FutureOr<List<Topic>> getTopicsByIds(List<int> topicIds);

  FutureOr<void> saveTopic(Topic topic);
}
