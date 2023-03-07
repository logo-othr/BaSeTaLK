import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/repositories/i_media_repository.dart';

class ImageFeatureViewModel {
  final String imageFileName;

  ImageFeatureViewModel(this.imageFileName);

  Future<Media> getImage() async {
    IMediaRepository mediaRepository = serviceLocator.get<IMediaRepository>();
    Media image = await mediaRepository.getMediaFile(imageFileName);
    return image;
  }
}
