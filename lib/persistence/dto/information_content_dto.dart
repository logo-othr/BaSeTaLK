import 'package:json_annotation/json_annotation.dart';

part 'information_content_dto.g.dart';

@JsonSerializable()
class InformationContentDTO {
  String heading;
  String content;

  InformationContentDTO(this.heading, this.content);

  factory InformationContentDTO.fromJson(Map<String, dynamic> json) =>
      _$InformationContentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$InformationContentDTOToJson(this);
}
