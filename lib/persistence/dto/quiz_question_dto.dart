import 'package:basetalk/persistence/dto/quiz_answer_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_question_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizQuestion {
  final String question;
  List<QuizAnswer> answers;
  int correctAnswerIndex;
  int id;

  QuizQuestion(this.question, this.answers, this.correctAnswerIndex, this.id);

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuizQuestionToJson(this);
}
