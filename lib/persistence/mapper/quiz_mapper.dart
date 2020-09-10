import 'package:basetalk/domain/entities/quiz_answer.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
import 'package:basetalk/domain/entities/quiz_question.dart';
import 'package:basetalk/persistence/dto/quiz_answer_dto.dart';
import 'package:basetalk/persistence/dto/quiz_data_dto.dart';
import 'package:basetalk/persistence/dto/quiz_question_dto.dart';

import 'i_mapper.dart';

class QuizMapper implements IMapper<QuizData, QuizDataDTO> {
  @override
  QuizData map(QuizDataDTO quizDataDTO) {
    List<QuizQuestionDTO> questionDTOs = quizDataDTO.questions;
    List<QuizQuestion> questions = List();
    for (QuizQuestionDTO questionDTO in questionDTOs) {
      List<QuizAnswer> answers = List();
      for (QuizAnswerDTO quizAnswerDTO in questionDTO.answers) {
        answers.add(QuizAnswer(quizAnswerDTO.id, quizAnswerDTO.answer));
      }
      QuizQuestion quizQuestion = QuizQuestion(questionDTO.question, answers,
          answers[questionDTO.correctAnswerIndex], questionDTO.id);
      questions.add(quizQuestion);
    }

    QuizData quizData = QuizData(questions, quizDataDTO.id);
  }

  @override
  QuizDataDTO revertMap(QuizData t) {
    // TODO: implement revertMap
    throw UnimplementedError();
  }
}