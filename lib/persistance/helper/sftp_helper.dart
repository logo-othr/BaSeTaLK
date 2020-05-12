import 'package:flutter/services.dart';
import 'package:ssh/ssh.dart';

disconnectFTP(SSHClient sshclient) async {
  print(await sshclient.disconnectSFTP());
  sshclient.disconnect();
}

Future<List<String>> downloadFromSFTP(SSHClient sshClient,
    List<String> filelist, String remoteFolderPath, localFolderPath,
    {Callback callback}) async {
  filelist = filelist.toSet().toList();
  filelist.removeWhere((value) => value == null);
  try {
    String result = await sshClient.connect();
    if (result == "session_connected") {
      result = await sshClient.connectSFTP();
      if (result == "sftp_connected") {
        for (String file in filelist) {
          try {
            await sFTPDownloadFile(
                sshClient, remoteFolderPath + file, localFolderPath,
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
    disconnectFTP(sshClient);
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

Future<void> sFTPDownloadFile(
    SSHClient client, String remoteFilePath, String localPath,
    {Callback callback}) async {
  print("INFO: downloading " + remoteFilePath);
  await client.sftpDownload(
    path: remoteFilePath,
    toPath: localPath,
    callback: callback,
  );
}

Future<List<String>> sFTPGetFilelist(
    SSHClient client, String remotePath) async {
  var remoteFiles = await client.sftpLs(remotePath);
  List<String> filenames = new List<String>();
  remoteFiles.forEach((element) {
    filenames.add(element["filename"]);
  });
  return filenames;
}
