import 'dart:io';

import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:basetalk/persistence/topic_path_provider.dart';

class MediaLocalFileRepository implements IMediaRepository {
  @override
  Future<Media> getMediaFile(String filename) async {
    File mediaFile =
        serviceLocator.get<TopicPathProvider>().getTopicMediaFile(filename);
    if (!await mediaFile.exists())
      throw ("Error while downloading the file $filename");
    return Media(mediaFile);
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
