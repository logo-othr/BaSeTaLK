// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizDataDTO _$QuizDataDTOFromJson(Map<String, dynamic> json) {
  return QuizDataDTO(
    (json['questions'] as List)
        ?.map((e) => e == null
            ? null
            : QuizQuestionDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..id = json['id'] as String;
}

Map<String, dynamic> _$QuizDataDTOToJson(QuizDataDTO instance) =>
    <String, dynamic>{
      'questions': instance.questions?.map((e) => e?.toJson())?.toList(),
      'id': instance.id,
    };
