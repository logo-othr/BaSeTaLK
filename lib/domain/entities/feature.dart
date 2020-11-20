import 'package:basetalk/domain/entities/feature_type.dart';

class PageFeature {
  final String id;
  final FeatureType type;
  final List<String> filename;

  PageFeature(this.id, this.type, this.filename);
}
