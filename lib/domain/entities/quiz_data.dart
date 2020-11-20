import 'package:basetalk/domain/entities/quiz_question.dart';

class QuizData {
  List<QuizQuestion> questions;
  String id;

  QuizData(this.questions, this.id);
}
