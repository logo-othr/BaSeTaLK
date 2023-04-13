// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_impulse_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageImpulseDTO _$PageImpulseDTOFromJson(Map<String, dynamic> json) {
  return PageImpulseDTO(
    json['id'] as String,
    json['text'] as String,
    json['audio'] as String,
  );
}

Map<String, dynamic> _$PageImpulseDTOToJson(PageImpulseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'audio': instance.audio,
    };
