import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/impulse.dart';
import 'package:basetalk/domain/entities/information_content.dart';
import 'package:basetalk/domain/entities/page_number.dart';

class PageContent {
  int id;
  int topicId;
  PageNumber pageNumber;
  PageFeature pageFeature;
  List<Impulse> pageImpluses;
  InformationContent informationContent;
  String backgroundImage;

  PageContent(this.id, this.topicId, this.pageNumber, this.pageFeature,
      this.pageImpluses, this.informationContent, this.backgroundImage);
}
