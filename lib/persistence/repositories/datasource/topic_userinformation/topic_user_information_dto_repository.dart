import 'dart:convert';

import 'package:basetalk/persistence/dto/topic_user_information_dto.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_topic_user_information_dto_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicUserInformationDTORepository
    implements ITopicUserInformationDTORepository {
  @override
  Future<TopicUserInformationDTO> getTopicUserInformationDTOByTopicId(
      int topicId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonTopicUserInfo = prefs.getString(topicId.toString());
    if (jsonTopicUserInfo != null)
      return TopicUserInformationDTO.fromJson(jsonDecode(jsonTopicUserInfo));
    else
      return null;
  }

  @override
  Future<void> setTopicUserInformationDTOByTopicId(
      TopicUserInformationDTO topicUserInformationDTO, int topicId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(topicUserInformationDTO);
    prefs.setString(topicId.toString(), jsonString);
  }
}
