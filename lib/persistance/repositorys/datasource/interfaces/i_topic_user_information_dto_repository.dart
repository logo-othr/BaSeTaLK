import 'package:basetalk/persistance/dto/topic_user_information_dto.dart';

abstract class ITopicUserInformationDTORepository {
  Future<TopicUserInformationDTO> getTopicUserInformationDTOByTopicId(
      int topicId);

  Future<void> setTopicUserInformationDTOByTopicId(
      TopicUserInformationDTO topicUserInformationDTO, int topicId);
}
