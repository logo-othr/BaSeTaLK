class TopicParseException implements Exception {
  final String error;
  final String topicAsJsonString;

  TopicParseException(this.error, this.topicAsJsonString);

  String toString() =>
      'The error \'$error\' was thrown while parsing the json string : \'$topicAsJsonString\'';
}
