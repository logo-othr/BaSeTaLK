// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_content_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageContentDTO _$PageContentDTOFromJson(Map<String, dynamic> json) {
  return PageContentDTO(
    json['id'] as String,
    json['topicId'] as int,
    _$enumDecodeNullable(_$PageNumberEnumMap, json['pageNumber']),
    json['pageFeature'] == null
        ? null
        : PageFeatureDTO.fromJson(json['pageFeature'] as Map<String, dynamic>),
    (json['pageImpluses'] as List)
        ?.map((e) => e == null
            ? null
            : PageImpulseDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['informationContent'] == null
        ? null
        : InformationContentDTO.fromJson(
            json['informationContent'] as Map<String, dynamic>),
    json['backgroundImage'] as String,
  );
}

Map<String, dynamic> _$PageContentDTOToJson(PageContentDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topicId': instance.topicId,
      'pageNumber': _$PageNumberEnumMap[instance.pageNumber],
      'pageFeature': instance.pageFeature,
      'pageImpluses': instance.pageImpluses,
      'informationContent': instance.informationContent,
      'backgroundImage': instance.backgroundImage,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PageNumberEnumMap = {
  PageNumber.none: 'none',
  PageNumber.zero: 'zero',
  PageNumber.one: 'one',
  PageNumber.two: 'two',
  PageNumber.three: 'three',
};
