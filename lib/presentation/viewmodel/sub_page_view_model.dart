import 'package:basetalk/domain/entities/page_number.dart';
import 'package:flutter/material.dart';

class SubPageViewModel extends ChangeNotifier {
  bool isInfoDialogVisible = false;

  final PageNumber pageNumber;

  SubPageViewModel(this.pageNumber);

  toggleInfoDialogVisible() {
    isInfoDialogVisible = !isInfoDialogVisible;
    notifyListeners();
  }
}
