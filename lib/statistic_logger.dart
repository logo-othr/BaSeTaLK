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
  final String delimiter = ",";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/statistic.csv');
  }

  Future<File> _setupStatisticFile() async {
    final file = await _localFile;
    //file.delete();
    if (!(await file.exists())) {
      String csvHeader = "timestamp" +
          delimiter +
          "event_type" +
          delimiter +
          "topic" +
          delimiter +
          "topic_id" +
          delimiter +
          "page_number" +
          delimiter +
          "rating" +
          delimiter +
          "value";

      await file.create();
      await file.writeAsString(csvHeader);
    }
    return file;
  }

  logEvent({
    String eventType = "",
    String topicName = "",
    String topicID = "",
    String pageNumber = "",
    String nValue = "",
    String bValue = "",
  }) async {
    try {
      final file = await _setupStatisticFile();
      String line = "timestamp" +
          "0" +
          delimiter +
          "event_type" +
          eventType +
          delimiter +
          "topic" +
          topicName +
          delimiter +
          "topic_id" +
          topicID +
          delimiter +
          "page_number" +
          pageNumber +
          delimiter +
          "rating" +
          nValue +
          delimiter +
          "value" +
          bValue;
      await file.writeAsString(line);
    } catch (e) {
      // ToDo: exception handling
      print(e);
    }
  }

  Future<int> readFile() async {
    try {
      final file = await _setupStatisticFile();

      String contents = await file.readAsString();
      print(contents);
    } catch (e) {
      // ToDo: exception handling
      print(e);
    }
  }
}
