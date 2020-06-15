import 'package:flutter/material.dart';

class QuizViewModel extends ChangeNotifier {
  bool _isNextButtonVisible = true;

  bool get isNextButtonVisible => _isNextButtonVisible;

  setNextButtonVisibility(bool visibilityState) {
    this._isNextButtonVisible = visibilityState;
    notifyListeners();
  }
}
