import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';

class MediaLocalFileRepository implements IMediaRepository {
  @override
  Future<Media> getMediaFile(String filename) {
    return null;
    // ToDo: Implement
  }

  @override
  Future<List<Media>> getMediaFilesByName(List<String> filenames) {
    return null;
    // ToDo: implement
  }
}
