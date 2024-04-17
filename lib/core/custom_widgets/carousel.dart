import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<String> gallery;
  const CustomCarouselSlider({
    super.key,
    required this.gallery,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        enlargeFactor: 0.3,
        enlargeCenterPage: true,
        viewportFraction: 0.6,
      ),
      items: gallery.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              clipBehavior: Clip.antiAlias,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.transparent,
                ),
                child: FittedBox(fit: BoxFit.cover,child: Image.memory(const Base64Decoder().convert(i)),));
          },
        );
      }).toList(),
    );
  }
}