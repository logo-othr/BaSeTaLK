import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/quiz_answer.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
import 'package:basetalk/domain/entities/quiz_question.dart';
import 'package:basetalk/domain/usecases/get_quiz_data_usecase.dart';
import 'package:flutter/material.dart';

class QuizViewModel extends ChangeNotifier {
  final GetQuizDataUsecase getQuizDataUsecase;

  final PageFeature pageFeature;
  QuizData quizData;

  bool _isNextButtonVisible = true;

  QuizViewModel(this.pageFeature)
      : this.getQuizDataUsecase = serviceLocator.get<GetQuizDataUsecase>();

  bool get isNextButtonVisible => _isNextButtonVisible;

  setNextButtonVisibility(bool visibilityState) {
    this._isNextButtonVisible = visibilityState;
    notifyListeners();
  }

  Future<QuizData> getQuizData() async {
    if (quizData == null) {
      this.quizData = await getQuizDataUsecase(pageFeature.filename[0]);
    }
    return quizData;
  }

  QuizData _mockQuizData() {
    List<QuizAnswer> mockAnswersQuestions1 = List();
    QuizAnswer correctAnswer1 = QuizAnswer(1, "Antwort 1 Frage 1");
    mockAnswersQuestions1.add(correctAnswer1);
    mockAnswersQuestions1.add(QuizAnswer(2, "Antwort 2 Frage 1"));
    mockAnswersQuestions1.add(QuizAnswer(3, "Antwort 3 Frage 1"));
    QuizQuestion question1 =
        QuizQuestion("Frage 1", mockAnswersQuestions1, correctAnswer1, 1);

    List<QuizAnswer> mockAnswersQuestions2 = List();
    QuizAnswer correctAnswer2 = QuizAnswer(4, "Antwort 1  Frage 2");
    mockAnswersQuestions2.add(correctAnswer2);
    mockAnswersQuestions2.add(QuizAnswer(5, "Antwort 2  Frage 2"));
    mockAnswersQuestions2.add(QuizAnswer(6, "Antwort 3  Frage 2"));
    QuizQuestion question2 =
    QuizQuestion("Frage 2", mockAnswersQuestions2, correctAnswer2, 2);

    List<QuizQuestion> questions = List();
    questions.add(question1);
    questions.add(question2);
    QuizData quizData = new QuizData(questions, 1);
    return quizData;
  }
}
