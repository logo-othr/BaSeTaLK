import 'package:flutter/material.dart';

class SubPageViewModel extends ChangeNotifier {
  bool isInfoDialogVisible = false;

  toggleInfoDialogVisible() {
    isInfoDialogVisible = !isInfoDialogVisible;
    notifyListeners();
  }
}
