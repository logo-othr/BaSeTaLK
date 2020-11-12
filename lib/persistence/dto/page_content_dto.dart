import 'package:basetalk/domain/entities/page_number.dart';
import 'package:json_annotation/json_annotation.dart';

import 'information_content_dto.dart';
import 'page_feature_dto.dart';
import 'page_impulse_dto.dart';

part 'page_content_dto.g.dart';

@JsonSerializable()
class PageContentDTO {
  String id;
  int topicId;
  PageNumber pageNumber;
  PageFeatureDTO pageFeature;
  List<PageImpulseDTO> pageImpluses;
  InformationContentDTO informationContent;
  String backgroundImage;

  PageContentDTO(this.id, this.topicId, this.pageNumber, this.pageFeature,
      this.pageImpluses, this.informationContent, this.backgroundImage);

  factory PageContentDTO.fromJson(Map<String, dynamic> json) =>
      _$PageContentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PageContentDTOToJson(this);
}
