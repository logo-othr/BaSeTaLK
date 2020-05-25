import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:basetalk/persistence/helper/sftp_helper.dart';
import 'package:ssh/ssh.dart';

class MediaRemoteSFTPRepository implements IMediaRepository {
  final SSHClient _sshClient;
  final String _remoteFolderPath = "ftp/files/";
  final String _localFolderPath;

  MediaRemoteSFTPRepository(this._sshClient, this._localFolderPath);

  @override
  Future<Media> getMediaFile(String filename) async {
    List<String> filenames = new List();
    filenames.add(filename);
    await downloadFromSFTP(
        _sshClient, filenames, _remoteFolderPath, _localFolderPath);
    // ToDo: check and return media files
  }

  @override
  Future<List<Media>> getMediaFilesByName(List<String> filenames) async {
    List<Media> mediaFiles = new List();
    await downloadFromSFTP(
        _sshClient, filenames, _remoteFolderPath, _localFolderPath);
    for (var filename in filenames) {
      // ToDo: check if file has been downloaded and set the location
      Media m = new Media();
      m.name = filename;
      // m.location = await
      mediaFiles.add(m);
    }
    return mediaFiles;
  }

  @override
  Future<List<Media>> getMediaForTopics(List<String> filenames) async {
    await downloadFromSFTP(
        _sshClient, filenames, _remoteFolderPath, _localFolderPath);
    // ToDo: check and return media files
  }
}
