import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class TopicFrontPage extends StatefulWidget {
  @override
  _TopicFrontPageState createState() => _TopicFrontPageState();
}

class _TopicFrontPageState extends State<TopicFrontPage> {
  Future<FileImage> loadBackgroundImage() async {
    String backgroundImagefileName = Provider.of<TopicViewModel>(context)
        .getBackgroundImageFileName(
            Provider.of<TopicPageViewModel>(context).pageNumber);
    Media backgroundMedia = await Provider.of<TopicPageViewModel>(context)
        .getBackgroundImage(backgroundImagefileName);
    return FileImage(backgroundMedia.file);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadBackgroundImage(),
      builder: (BuildContext context, AsyncSnapshot<FileImage> image) {
        ImageProvider background = AssetImage("assets/img/placeholder.png");
        if (image.hasData) background = image.data;
        return Container(
            child: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: background,
              fit: BoxFit.cover,
            ),
            Center(
              child: Container(),
            )
          ],
        ));
      },
    );
  }
}
