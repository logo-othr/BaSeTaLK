import 'package:basetalk/domain/entities/impulse.dart';
import 'package:basetalk/domain/entities/information_content.dart';
import 'package:basetalk/domain/entities/page_content.dart';
import 'package:basetalk/domain/entities/page_number.dart';

class Topic {
  int id;
  String name;
  String description;
  List<String> tags;
  String frontPageImageName;
  InformationContent frontPageInformationContent;
  List<PageContent> pageContents;
  String thumbnail;
  bool isDownloaded;
  bool isVisited;
  bool isFavorite;
  int conversationDepth;

  Topic(
      this.id,
      this.name,
      this.description,
      this.tags,
      this.frontPageImageName,
      this.frontPageInformationContent,
      this.pageContents,
      this.thumbnail,
      {this.isDownloaded = false,
      this.isVisited = false,
      this.isFavorite = false});

  void toggleFavorite() {
    this.isFavorite = !this.isFavorite;
  }

  void toggleVisited() {
    this.isVisited = !this.isVisited;
  }

  Impulse getImpulse(PageNumber pageNumber, int index) {
    Impulse result;
    for (PageContent pageContent in this.pageContents)
      if (pageContent.pageNumber == pageNumber)
        result = pageContent.pageImpluses[index];
    return result;
  }

  List<Impulse> getImpulses(PageNumber pageNumber) {
    List<Impulse> result;
    for (PageContent pageContent in this.pageContents)
      if (pageContent.pageNumber == pageNumber)
        result = pageContent.pageImpluses;
    return result;
  }

  List<String> getMediaFileNames() {
    List<String> filenames = new List();
    filenames.add(this.frontPageImageName);
    filenames.add(this.thumbnail);
    for (PageContent pageContent in this.pageContents) {
      if (pageContent.pageFeature != null)
        filenames.addAll(pageContent.pageFeature.filename);
      filenames.add(pageContent.backgroundImage);
      for (Impulse impulse in pageContent.pageImpluses) {
        filenames.add(impulse.audioFileName);
      }
    }
    return filenames;
  }
}
