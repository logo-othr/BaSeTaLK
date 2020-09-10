import 'dart:convert';

import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/persistence/dto/quiz_data_dto.dart';
import 'package:basetalk/persistence/repositorys/datasource/interfaces/i_quiz_dto_repository.dart';

class QuizDTORepository implements IQuizDTORepository {
  Future<QuizDataDTO> getQuizDataDTO(Media quizFileMedia) async {
    String jsonString = await quizFileMedia.file.readAsString();
    QuizDataDTO topicDtos = QuizDataDTO.fromJson(jsonDecode(jsonString));
    return topicDtos;
  }
}
