import 'dart:io';

import 'package:basetalk/domain/entities/page_number.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum EventType {
  impulseBarOpen,
  impulseBarClosed,
  impulseBarNext,
  impulseBarAudio,
  infoOpen,
  infoClosed,
  pageOpen,
  pageClosed,
  topicCloseToRating,
  topicCloseToHome,
  featureOpen,
  featureClosed,
  topicRating,
  topicFavoriteCheck,
  topicFavoriteUncheck,
  topicVisitedCheck,
  topicVisitedUncheck,
  topicOpen,
  appMaximize,
  appMinimize,
  appStart
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
          "n_value" +
          delimiter +
          "b_value" +
          "\n";

      await file.create();
      await file.writeAsString(csvHeader);
    }
    return file;
  }

  logEvent({
    EventType eventType,
    String topicName,
    String topicID,
    PageNumber pageNumber,
    int nValue,
    bool bValue,
  }) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd h:m:s');
    final String timestamp = formatter.format(now);

    //String nValueStr = (nValue == null ? "null" : nValue.toString());
    //String bValueStr = (bValue == null ? "null" : bValue.toString());
    var buffer = new StringBuffer();

    buffer.write(timestamp);
    buffer.write(delimiter);
    buffer.write(EnumToString.convertToString(eventType));
    buffer.write(delimiter);
    buffer.write(topicName);
    buffer.write(delimiter);
    buffer.write(topicID);
    buffer.write(delimiter);
    buffer.write(EnumToString.convertToString(pageNumber));
    buffer.write(delimiter);
    buffer.write(nValue.toString());
    buffer.write(delimiter);
    buffer.write(bValue.toString());
    buffer.write("\n");

    String line = buffer.toString();

    try {
      final file = await _setupStatisticFile();

      file.writeAsStringSync(line, mode: FileMode.append);
      print(line);
    } catch (e) {
      // ToDo: exception handling
      print(e);
    }
  }


}
