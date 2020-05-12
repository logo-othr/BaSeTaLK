import 'dart:async';

import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';
import 'package:basetalk/persistance/repositorys/media_repository.dart';
import 'package:basetalk/persistance/repositorys/topic_repository.dart';

class DownloadTopicDataUseCase
    extends BaseUseCase<void, DownloadTopicDataUseCaseParams> {
  final MediaRepository _mediaRepository;
  final TopicRepository _topicRepository;

  DownloadTopicDataUseCase(this._mediaRepository, this._topicRepository);

  @override
  Future<void> call(DownloadTopicDataUseCaseParams params) async {
    List<String> filenames = params.topic.getMediaFileNames();
    await _mediaRepository.getMediaFilesByName(filenames);
    //ToDo: Check if all files are downloaded
    params.topic.isDownloaded = true;
    await _topicRepository.saveTopic(params.topic);
    params.callback();
  }
}

class DownloadTopicDataUseCaseParams {
  Topic topic;
  Function callback;

  DownloadTopicDataUseCaseParams(this.topic, this.callback);
}
