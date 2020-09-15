import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum EventType {
  IMPULSEBAR_OPEN,
  IMPULSEBAR_CLOSED,
  IMPULSEBAR_NEXT,
  IMPULSEBAR_AUDIO,
  INFO_OPEN,
  INFO_CLOSED,
  PAGE_OPEN,
  PAGE_CLOSED,
  TOPIC_CLOSE_TO_RATING,
  TOPIC_CLOSE_TO_HOME,
  FEATURE_OPEN,
  FEATURE_CLOSED,
  TOPIC_RATING,
  TOPIC_FAVORITE,
  TOPIC_VISITED,
  TOPIC_OPEN,
  SEARCH,
  APP_MAX,
  APP_MIN
}

class StatisticLogger {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/statistic.csv');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0.
      return 0;
    }
  }
}
