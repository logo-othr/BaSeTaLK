import 'package:json_annotation/json_annotation.dart';

part 'quiz_answer_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizAnswer {
  int id;
  String answer;

  QuizAnswer(this.id, this.answer);

  factory QuizAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$QuizAnswerToJson(this);
}
