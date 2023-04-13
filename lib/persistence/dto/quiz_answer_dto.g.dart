// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_answer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAnswerDTO _$QuizAnswerDTOFromJson(Map<String, dynamic> json) {
  return QuizAnswerDTO(
    json['id'] as String,
    json['answer'] as String,
  );
}

Map<String, dynamic> _$QuizAnswerDTOToJson(QuizAnswerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
    };
