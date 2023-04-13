// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicDTO _$TopicDTOFromJson(Map<String, dynamic> json) {
  return TopicDTO(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    (json['tags'] as List)?.map((e) => e as String)?.toList(),
    json['frontPageImageName'] as String,
    json['frontPageInformationContent'] == null
        ? null
        : InformationContentDTO.fromJson(
            json['frontPageInformationContent'] as Map<String, dynamic>),
    (json['pageContents'] as List)
        ?.map((e) => e == null
            ? null
            : PageContentDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['thumbnail'] as String,
    json['conversationDepth'] as int,
  );
}

Map<String, dynamic> _$TopicDTOToJson(TopicDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'tags': instance.tags,
      'frontPageImageName': instance.frontPageImageName,
      'frontPageInformationContent':
          instance.frontPageInformationContent?.toJson(),
      'pageContents': instance.pageContents?.map((e) => e?.toJson())?.toList(),
      'thumbnail': instance.thumbnail,
      'conversationDepth': instance.conversationDepth,
    };
