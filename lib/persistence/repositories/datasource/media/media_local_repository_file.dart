import 'dart:io';

import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositories/i_media_repository.dart';
import 'package:basetalk/persistence/topic_path_provider.dart';

class MediaLocalFileRepository implements IMediaRepository {
  @override
  Future<Media> getMediaFile(String filename) async {
    File mediaFile =
        serviceLocator.get<TopicPathProvider>().getTopicMediaFile(filename);
    Media media;
    if (await mediaFile.exists()) media = Media(mediaFile);

    return media;
  }

  @override
  Future<List<Media>> getMediaFilesByName(List<String> filenames) async {
    List<Media> media = List();
    for (String filename in filenames) {
      media.add(await getMediaFile(filename));
    }
    return media;
  }

}
