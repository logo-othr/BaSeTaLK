import 'package:json_annotation/json_annotation.dart';

part 'quiz_answer_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizAnswerDTO {
  int id;
  String answer;

  QuizAnswerDTO(this.id, this.answer);

  factory QuizAnswerDTO.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuizAnswerDTOToJson(this);
}
