import 'dart:io';

import 'package:basetalk/persistence/helper/file_helper.dart';
import 'package:path_provider/path_provider.dart';

class TopicPathProvider {
  static final String topicRootFolderName = "topic-data";
  String appCacheRootPath;
  String topicMediaRootPath;

  cleanCreateTopicMediaRoot() async {
    await deleteDirectory(this.topicMediaRootPath);
    await createDirectory(this.topicMediaRootPath);
  }

  File getTopicMediaFile(String filename) {
    File mediaFile = File('$topicMediaRootPath$filename');
    return mediaFile;
  }

  String getTopicMediaFilePath(String filename) {
    return this.topicMediaRootPath + filename;
  }

  init() async {
    final Directory appDataDirectory = await getApplicationSupportDirectory();
    await _loadTopicMediaRootPath(appDataDirectory);
    appCacheRootPath = (await getTemporaryDirectory()).path + '/';
  }

  _loadTopicMediaRootPath(Directory appDataDirectory) async {
    final Directory _appDocDirFolder =
        Directory('${appDataDirectory.path}/$topicRootFolderName/');
    bool exists = await _appDocDirFolder.exists();
    if (!exists) createDirectory(_appDocDirFolder.path);
    this.topicMediaRootPath = _appDocDirFolder.path;
  }
}
