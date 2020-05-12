import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/impulse.dart';
import 'package:basetalk/domain/entities/information_content.dart';
import 'package:basetalk/domain/entities/page_content.dart';
import 'package:basetalk/domain/entities/topic.dart';
import 'package:basetalk/persistance/dto/information_content_dto.dart';
import 'package:basetalk/persistance/dto/page_content_dto.dart';
import 'package:basetalk/persistance/dto/page_feature_dto.dart';
import 'package:basetalk/persistance/dto/page_impulse_dto.dart';
import 'package:basetalk/persistance/dto/topic_dto.dart';
import 'package:basetalk/persistance/mapper/i_mapper.dart';

class TopicMapper implements IMapper<Topic, TopicDTO> {
  @override
  Topic map(TopicDTO topicDto) {
    InformationContent informationContent = new InformationContent(
        topicDto.frontPageInformationContent.heading,
        topicDto.frontPageInformationContent.content);

    List<PageContent> pageContents = new List();
    for (PageContentDTO pageContentDto in topicDto.pageContents) {
      List<Impulse> impulses = new List();
      for (PageImpulseDTO impulseDto in pageContentDto.pageImpluses) {
        impulses
            .add(new Impulse(impulseDto.id, impulseDto.text, impulseDto.audio));
      }
      PageContent pageContent = new PageContent(
          pageContentDto.id,
          pageContentDto.topicId,
          pageContentDto.pageNumber,
          new PageFeature(pageContentDto.pageFeature.id,
              pageContentDto.pageFeature.featureFileName),
          impulses,
          new InformationContent(pageContentDto.informationContent.heading,
              pageContentDto.informationContent.content),
          pageContentDto.backgroundImage);
      pageContents.add(pageContent);
    }

    Topic topic = new Topic(
        topicDto.id,
        topicDto.name,
        topicDto.description,
        topicDto.tags,
        topicDto.frontPageImageName,
        informationContent,
        pageContents,
        topicDto.thumbnail);
    return topic;
  }

  // Maps [TopicDTO] to [Topic].
  // Note that the topic user data is set to default.
  @override
  TopicDTO revertMap(Topic topic) {
    InformationContentDTO informationContentDTO = new InformationContentDTO(
        topic.frontPageInformationContent.heading,
        topic.frontPageInformationContent.content);
    List<PageContentDTO> pageContentDTOs = new List();
    for (PageContent pageContent in topic.pageContents) {
      List<PageImpulseDTO> pageImpulseDTOs = new List();
      for (Impulse impulse in pageContent.pageImpluses) {
        pageImpulseDTOs.add(new PageImpulseDTO(
            impulse.id, impulse.text, impulse.audioFileName));
      }

      PageContentDTO pageContentDTO = new PageContentDTO(
          pageContent.id,
          pageContent.topicId,
          pageContent.pageNumber,
          new PageFeatureDTO(pageContent.pageFeature.id,
              pageContent.pageFeature.featureFileName),
          pageImpulseDTOs,
          new InformationContentDTO(pageContent.informationContent.heading,
              pageContent.informationContent.content),
          pageContent.backgroundImage);

      pageContentDTOs.add(pageContentDTO);
    }

    TopicDTO topicDTO = new TopicDTO(
        topic.id,
        topic.name,
        topic.description,
        topic.tags,
        topic.frontPageImageName,
        informationContentDTO,
        pageContentDTOs,
        topic.thumbnail);
    return topicDTO;
  }
}
