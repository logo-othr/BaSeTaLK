import 'package:basetalk/dependency_setup.dart';
import 'package:flutter/services.dart';
import 'package:ssh2/ssh2.dart';

disconnectFTP(SSHClient sshclient) async {
  print("disconnecting ftp");
  print(await sshclient.disconnectSFTP());
  sshclient.disconnect();
}

Future<List<String>> downloadFromSFTP(
    List<String> filelist, String remoteFolderPath, localFolderPath,
    {Callback callback}) async {
  filelist = filelist.toSet().toList();
  filelist.removeWhere((value) => value == null);
  try {
    String result = await serviceLocator<SSHClient>().connect();
    if (result == "session_connected") {
      result = await serviceLocator<SSHClient>().connectSFTP();
      if (result == "sftp_connected") {
        for (String file in filelist) {
          try {
            await sFTPDownloadFile(serviceLocator<SSHClient>(),
                remoteFolderPath + file, localFolderPath,
                callback: callback);
          } on PlatformException catch (e) {
            print('Error: ${e.code}\nError Message: ${e.message}');
          }
          print("Downloaded" +
              remoteFolderPath +
              file +
              " to " +
              localFolderPath);
        }
      }
    }
    disconnectFTP(serviceLocator<SSHClient>());
  } on PlatformException catch (e) {
    print('Error: ${e.code}\nError Message: ${e.message}');
  } on Exception catch (e) {
    print(e.toString());
  }
}

void sFTPDownloadDir(SSHClient client, String remotePath, String localPath,
    {Callback callback}) async {
  var remoteFiles = await client.sftpLs(remotePath);
  List<String> filenames = new List<String>();
  remoteFiles.forEach((element) {
    filenames.add(element["filename"]);
  });
  for (String filename in filenames) {
    print("INFO: downloading " + filename);
    await client.sftpDownload(
      path: remotePath + filename,
      toPath: localPath,
      callback: callback,
    );
  }
}

Future<void> sFTPDownloadFile(SSHClient client, String remoteFilePath, String localPath,
    {Callback callback}) async {
  print("INFO: downloading " + remoteFilePath);
  await client.sftpDownload(
    path: remoteFilePath,
    toPath: localPath,
    callback: callback,
  );
}

Future<List<String>> sFTPGetFilelist(SSHClient client, String remotePath) async {
  var remoteFiles = await client.sftpLs(remotePath);
  List<String> filenames = new List<String>();
  remoteFiles.forEach((element) {
    filenames.add(element["filename"]);
  });
  return filenames;
}
