// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizQuestionDTO _$QuizQuestionDTOFromJson(Map<String, dynamic> json) {
  return QuizQuestionDTO(
    json['question'] as String,
    (json['answers'] as List)
        ?.map((e) => e == null
            ? null
            : QuizAnswerDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['correctAnswerId'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$QuizQuestionDTOToJson(QuizQuestionDTO instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answers': instance.answers?.map((e) => e?.toJson())?.toList(),
      'correctAnswerId': instance.correctAnswerId,
      'id': instance.id,
    };
