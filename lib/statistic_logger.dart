import 'dart:io';

import 'package:basetalk/domain/entities/page_number.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum EventType {
  DEFAULT,
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
  final String delimiter = ";";

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
          "value" +
          "\n";

      await file.create();
      await file.writeAsString(csvHeader);
    }
    return file;
  }

  logEvent({
    EventType eventType = EventType.DEFAULT,
    String topicName = "",
    String topicID = "",
    PageNumber pageNumber = PageNumber.none,
    String nValue = "",
    String bValue = "",
  }) async {
    print("logging...");
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd-H-Hm-Hms');
    final String timestamp = formatter.format(now);

    String line = timestamp + delimiter +
        EnumToString.convertToString(eventType) + delimiter +
        topicName + delimiter +
        topicID + delimiter +
        EnumToString.convertToString(pageNumber) + delimiter +
        nValue + delimiter +
        bValue + "\n";
    try {
      final file = await _setupStatisticFile();

      await file.writeAsString(line, mode: FileMode.append);
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
