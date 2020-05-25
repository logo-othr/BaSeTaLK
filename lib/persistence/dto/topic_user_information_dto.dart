import 'package:json_annotation/json_annotation.dart';

part 'topic_user_information_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TopicUserInformationDTO {
  int topicId;
  bool isFavorite;
  bool isDownloaded;
  bool isVisited;

  TopicUserInformationDTO(
      this.topicId, this.isFavorite, this.isDownloaded, this.isVisited);

  factory TopicUserInformationDTO.fromJson(Map<String, dynamic> json) =>
      _$TopicUserInformationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TopicUserInformationDTOToJson(this);
}
