import 'package:basetalk/persistence/dto/information_content_dto.dart';
import 'package:basetalk/persistence/dto/page_content_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TopicDTO {
  int id;
  String name;
  String description;
  List<String> tags;
  String frontPageImageName;
  InformationContentDTO frontPageInformationContent;
  List<PageContentDTO> pageContents;
  String thumbnail;
  int conversationDepth;

  TopicDTO(
      this.id,
      this.name,
      this.description,
      this.tags,
      this.frontPageImageName,
      this.frontPageInformationContent,
      this.pageContents,
      this.thumbnail,
      this.conversationDepth);

  factory TopicDTO.fromJson(Map<String, dynamic> json) =>
      _$TopicDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TopicDTOToJson(this);
}
