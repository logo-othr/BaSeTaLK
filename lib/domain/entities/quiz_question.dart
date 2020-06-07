import 'package:basetalk/domain/entities/quiz_answer.dart';

class QuizQuestion {
  List<QuizAnswer> answers;
  QuizAnswer correctAnswer;
  int id;

  QuizQuestion(this.answers, this.correctAnswer, this.id);
}
