import 'package:basetalk/domain/entities/quiz_answer.dart';

class QuizQuestion {
  final String question;
  List<QuizAnswer> answers;
  QuizAnswer correctAnswer;
  int id;

  QuizQuestion(this.question, this.answers, this.correctAnswer, this.id);
}
