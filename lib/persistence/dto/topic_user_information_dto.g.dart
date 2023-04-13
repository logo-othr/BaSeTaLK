// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_user_information_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicUserInformationDTO _$TopicUserInformationDTOFromJson(
    Map<String, dynamic> json) {
  return TopicUserInformationDTO(
    json['topicId'] as int,
    json['isFavorite'] as bool,
    json['isDownloaded'] as bool,
    json['isVisited'] as bool,
  );
}

Map<String, dynamic> _$TopicUserInformationDTOToJson(
        TopicUserInformationDTO instance) =>
    <String, dynamic>{
      'topicId': instance.topicId,
      'isFavorite': instance.isFavorite,
      'isDownloaded': instance.isDownloaded,
      'isVisited': instance.isVisited,
    };
