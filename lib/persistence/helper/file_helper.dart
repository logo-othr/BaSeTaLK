import 'dart:io';

import 'package:path_provider/path_provider.dart';

createDirectory(String path) async {
  final Directory directory = Directory(path);

  if (await directory.exists()) {
    return directory.path;
  } else {
    final Directory _appDocDirNewFolder =
        await directory.create(recursive: true);
    return _appDocDirNewFolder.path;
  }
}

Future<String> createFolderInAppSupportDir(String folderName) async {
  final Directory _appDocDir = await getApplicationSupportDirectory();
  final Directory _appDocDirFolder =
      Directory('${_appDocDir.path}/$folderName/');

  if (await _appDocDirFolder.exists()) {
    return _appDocDirFolder.path;
  } else {
    final Directory _appDocDirNewFolder =
        await _appDocDirFolder.create(recursive: true);
    return _appDocDirNewFolder.path;
  }
}

deleteDirectory(String path) async {
  final Directory directory = Directory('$path/');

  if (await directory.exists()) {
    directory.deleteSync(recursive: true);
  }
}

void deleteFolderInAppSupportDir(String folderName) async {
  final Directory _appDocDir = await getApplicationSupportDirectory();
  final Directory _appDocDirFolder =
      Directory('${_appDocDir.path}/$folderName/');

  if (await _appDocDirFolder.exists()) {
    _appDocDirFolder.deleteSync(recursive: true);
  }
}

Future<bool> doesFileExistInAppSupportDir(String fileName) async {
  final Directory appDocDir = await getApplicationSupportDirectory();
  final File file = File('${appDocDir.path}/$fileName/');
  return await file.exists();
}

Future<bool> doesFolderExistInAppSupportDir(String folderName) async {
  final Directory _appDocDir = await getApplicationSupportDirectory();
  final Directory _appDocDirFolder =
      Directory('${_appDocDir.path}/$folderName/');

  return await _appDocDirFolder.exists();
}

Future<String> getFolderPathInAppSupportDir(String folderName) async {
  final Directory _appDocDir = await getApplicationSupportDirectory();
  final Directory _appDocDirFolder =
      Directory('${_appDocDir.path}/$folderName/');
  return _appDocDirFolder.path;
}
