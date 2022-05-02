import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/album/photo.dart';

class PhotoCarouselPage extends StatelessWidget {
  final List<Photo> photos;
  final int startFrom;

  const PhotoCarouselPage({
    Key? key,
    required this.photos,
    required this.startFrom
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1,
              enlargeCenterPage: false,
              initialPage: startFrom,
            ),
            items: photos.map((photo) => Center(
              child: Image.network(
                photo.url,
                fit: BoxFit.cover,
                height: height,),
            )).toList(),
          );
        },
      ),
    );
  }
}
