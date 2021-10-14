import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarouselPage extends StatefulWidget {
  List<XFile>? listCarousel;
  CarouselPage({this.listCarousel});

  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Carousel Slider",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Container(
          height: size.height,
          width: size.width,
          // color: Colors.red,
          child: CarouselSlider.builder(
            itemCount: widget.listCarousel!.length,
            itemBuilder: (context, i, index) {
              return Container(
                height: size.height,
                width: size.width,
                child: Image.file(
                  File(widget.listCarousel![i].path),
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(microseconds: 1000),
                height: size.height,
                autoPlayCurve: Curves.easeInOutCubicEmphasized,
                scrollDirection: Axis.horizontal),
          )),
    );
  }
}
