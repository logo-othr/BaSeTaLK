import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/image_feature_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageFeatureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ImageProvider background = AssetImage("assets/img/placeholder.png");
    return FutureBuilder(
        future: Provider.of<ImageFeatureViewModel>(context, listen: false)
            .getImage(),
        builder: (BuildContext context, AsyncSnapshot<Media> image) {
          if (image.hasData) {
            background = FileImage(image.data.file);
            return Card(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image(
                      image: background,
                      fit: BoxFit.cover,
                    )));
          } else
            return Container();
        });
  }
}
