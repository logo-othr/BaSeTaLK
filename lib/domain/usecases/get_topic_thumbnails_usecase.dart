import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/domain/repositories/i_media_repository.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';

class GetTopicThumbnailsUseCase extends BaseUseCase<void, List<Topic>> {
  final IMediaRepository _mediaRepository;

  GetTopicThumbnailsUseCase(this._mediaRepository);

  @override
  Future<List<Media>> call(List<Topic> topics) async {
    List<String> filenames = new List();
    for (Topic topic in topics) filenames.add(topic.thumbnail);
    List<Media> media = await _mediaRepository.getMediaFilesByName(filenames);
    return media;
  }
}
