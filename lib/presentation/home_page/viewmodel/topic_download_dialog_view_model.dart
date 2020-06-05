import 'package:flutter/foundation.dart';

class TopicDownloadDialogViewModel extends ChangeNotifier {
  bool isLoadingState = false;

  void toggleLoadingState() {
    isLoadingState = !isLoadingState;
    notifyListeners();
  }
}
