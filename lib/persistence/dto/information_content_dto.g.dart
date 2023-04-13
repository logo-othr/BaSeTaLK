// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_content_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationContentDTO _$InformationContentDTOFromJson(
    Map<String, dynamic> json) {
  return InformationContentDTO(
    json['heading'] as String,
    json['content'] as String,
  );
}

Map<String, dynamic> _$InformationContentDTOToJson(
        InformationContentDTO instance) =>
    <String, dynamic>{
      'heading': instance.heading,
      'content': instance.content,
    };
