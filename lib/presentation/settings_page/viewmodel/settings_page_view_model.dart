import 'package:flutter/cupertino.dart';

class SettingsPageViewModel extends ChangeNotifier {
  String topicReloadIndicator = "";
  bool topicsCurrentlyReloading = false;

  void setTopicReloadIndicator(String topicReloadIndicator) {
    this.topicReloadIndicator = topicReloadIndicator;
    notifyListeners();
  }

  void toggleTopicsCurrentlyReloading() {
    this.topicsCurrentlyReloading = !this.topicsCurrentlyReloading;
    notifyListeners();
  }
}
