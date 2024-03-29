import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositories/i_media_repository.dart';

class MediaRepository implements IMediaRepository {
  final IMediaRepository _remoteRepository;
  final IMediaRepository _mediaCacheRepository;

  MediaRepository(this._remoteRepository, this._mediaCacheRepository);

  @override
  Future<Media> getMediaFile(String filename) async {
    Media result = await _mediaCacheRepository.getMediaFile(filename);
    if (result == null) result = await _remoteRepository.getMediaFile(filename);
    return result;
  }

  @override
  Future<List<Media>> getMediaFilesByName(List<String> filenames) async {
    List<String> fetchFromRemote = new List<String>();
    List<Media> results = new List<Media>();
    for (String filename in filenames) {
      Media result = await _mediaCacheRepository.getMediaFile(filename);
      if (result == null)
        fetchFromRemote.add(filename);
      else
        results.add(result);
    }
    if (fetchFromRemote != null) {
      List<Media> fetched =
          await _remoteRepository.getMediaFilesByName(fetchFromRemote);
      results.addAll(fetched);
    }
    return results;
  }
}
