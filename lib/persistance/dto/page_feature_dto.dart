import 'package:json_annotation/json_annotation.dart';

part 'page_feature_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PageFeatureDTO {
  int id;
  String featureFileName;

  PageFeatureDTO(this.id, this.featureFileName);

  factory PageFeatureDTO.fromJson(Map<String, dynamic> json) =>
      _$PageFeatureDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PageFeatureDTOToJson(this);
}
