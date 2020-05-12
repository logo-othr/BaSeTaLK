import 'package:basetalk/domain/entities/media.dart';

/// IMediaRepository handles data persistence for [Media].
abstract class IMediaRepository {
  Future<Media> getMediaFile(String filename);

  Future<List<Media>> getMediaFilesByName(List<String> filenames);
}
