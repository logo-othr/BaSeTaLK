import 'package:basetalk/persistence/dto/quiz_question_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_data_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizDataDTO {
  List<QuizQuestion> questions;

  QuizDataDTO(this.questions);

  factory QuizDataDTO.fromJson(Map<String, dynamic> json) =>
      _$QuizDataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuizDataDTOToJson(this);
}
