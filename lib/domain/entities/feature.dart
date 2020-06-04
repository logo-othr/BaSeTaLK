import 'package:basetalk/domain/entities/feature_type.dart';

class PageFeature {
  final int id;
  final FeatureType type;
  final String filename;

  PageFeature(this.id, this.type, this.filename);

/* factory PageFeature(PageFeatureDTO pageFeatureDTO) {
    var type = pageFeatureDTO.featureType;
    if(type == FeatureType.AUDIO) return AudioFeature(pageFeatureDTO.id, pageFeatureDTO.featureFileName[0]);
    if(type == FeatureType.AUDIOIMAGE) return AudioImageFeature(pageFeatureDTO.id, pageFeatureDTO.featureFileName[0], pageFeatureDTO.featureFileName[1]);
    if(type == FeatureType.IMAGE) return ImageFeature(pageFeatureDTO.id, pageFeatureDTO.featureFileName[0]);
    if(type == FeatureType.QUIZ) return QuizFeature(pageFeatureDTO.id, pageFeatureDTO.featureFileName[0]);
    throw "unknown feature type";
  }
}*/

}
