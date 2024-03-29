import 'package:basetalk/persistence/dto/quiz_answer_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_question_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizQuestionDTO {
  final String question;
  List<QuizAnswerDTO> answers;
  String correctAnswerId;
  String id;

  QuizQuestionDTO(this.question, this.answers, this.correctAnswerId, this.id);

  factory QuizQuestionDTO.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuizQuestionDTOToJson(this);
}
