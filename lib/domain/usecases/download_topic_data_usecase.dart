import 'dart:async';

import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/repositories/i_media_repository.dart';
import 'package:basetalk/domain/repositories/i_topic_repository.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';

class DownloadTopicDataUseCase
    extends BaseUseCase<void, DownloadTopicDataUseCaseParams> {
  final IMediaRepository _mediaRepository;
  final ITopicRepository _topicRepository;

  DownloadTopicDataUseCase(this._mediaRepository, this._topicRepository);

  @override
  Future<void> call(DownloadTopicDataUseCaseParams params) async {
    List<String> filenames = params.topic.getMediaFileNames();
    await _mediaRepository.getMediaFilesByName(filenames);
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
