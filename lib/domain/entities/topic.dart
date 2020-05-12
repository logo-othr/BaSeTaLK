import 'package:basetalk/domain/entities/impulse.dart';
import 'package:basetalk/domain/entities/information_content.dart';
import 'package:basetalk/domain/entities/page_content.dart';

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

  List<String> getMediaFileNames() {
    List<String> filenames = new List();
    filenames.add(this.frontPageImageName);
    filenames.add(this.thumbnail);
    for (PageContent pageContent in this.pageContents) {
      filenames.add(pageContent.pageFeature.featureFileName);
      filenames.add(pageContent.backgroundImage);
      for (Impulse impulse in pageContent.pageImpluses) {
        filenames.add(impulse.audioFileName);
      }
    }
    return filenames;
  }
}
