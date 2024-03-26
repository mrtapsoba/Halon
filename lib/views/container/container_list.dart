import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ContainerList extends StatelessWidget {
  final List<dynamic> strings;

  ContainerList(this.strings);

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      autoPlayInterval: 5000,
      isLoop: true,
      children: strings.map((str) => buildContainer(context, str)).toList(),
    );
  }

  Widget buildContainer(BuildContext context, String text) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(text)),
        ));
  }
}
