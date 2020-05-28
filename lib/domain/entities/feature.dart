import 'package:basetalk/domain/entities/feature_type.dart';

class PageFeature {
  int id;
  String featureFileName;

  PageFeature(this.id, this.featureFileName);

  FeatureType getFeatureType() {
    // if file type is audio then return audio feature type
  }

  getFeatureFilePath() {
    // path provider, media path + featureFileName
  }
}
