import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
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


}
