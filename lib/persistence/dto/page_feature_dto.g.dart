// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_feature_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageFeatureDTO _$PageFeatureDTOFromJson(Map<String, dynamic> json) {
  return PageFeatureDTO(
    json['id'] as String,
    _$enumDecodeNullable(_$FeatureTypeEnumMap, json['featureType']),
    (json['featureFileName'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PageFeatureDTOToJson(PageFeatureDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'featureType': _$FeatureTypeEnumMap[instance.featureType],
      'featureFileName': instance.featureFileName,
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

const _$FeatureTypeEnumMap = {
  FeatureType.AUDIO: 'AUDIO',
  FeatureType.AUDIOIMAGE: 'AUDIOIMAGE',
  FeatureType.IMAGE: 'IMAGE',
  FeatureType.QUIZ: 'QUIZ',
};
