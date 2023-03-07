import 'dart:io';

import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositories/i_media_repository.dart';
import 'package:basetalk/persistence/helper/sftp_helper.dart';
import 'package:basetalk/persistence/topic_path_provider.dart';

class MediaRemoteSFTPRepository implements IMediaRepository {
  final String _remoteFolderPath = "share/";
  final String _localFolderPath;
  bool busy = false;

  MediaRemoteSFTPRepository(this._localFolderPath);

  @override
  Future<Media> getMediaFile(String filename) async {
    List<String> filenames = new List();
    filenames.add(filename);
    await downloadFromSFTP(filenames, _remoteFolderPath, _localFolderPath);
    File mediaFile =
        serviceLocator.get<TopicPathProvider>().getTopicMediaFile(filename);
    if (!await mediaFile.exists())
      throw ("Error while downloading the file $filename");
    return Media(mediaFile);
  }

  @override
  Future<List<Media>> getMediaFilesByName(List<String> filenames) async {
    List<Media> mediaFiles = new List();
    await downloadFromSFTP(
        filenames, _remoteFolderPath, _localFolderPath);

    TopicPathProvider topicPathProvider =
    serviceLocator.get<TopicPathProvider>();
    for (var filename in filenames) {
      File mediaFile = topicPathProvider.getTopicMediaFile(filename);
      if (!await mediaFile.exists())
        print("Error while downloading the file $filename");
      mediaFiles.add(new Media(mediaFile));
    }
    return mediaFiles;
  }

}
