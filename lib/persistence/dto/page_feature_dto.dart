import 'package:basetalk/domain/entities/feature_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_feature_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PageFeatureDTO {
  String id;
  FeatureType featureType;
  List<String> featureFileName;

  PageFeatureDTO(this.id, this.featureType, this.featureFileName);

  factory PageFeatureDTO.fromJson(Map<String, dynamic> json) =>
      _$PageFeatureDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PageFeatureDTOToJson(this);
}
