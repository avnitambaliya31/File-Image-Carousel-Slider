import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_slide_show/carousel_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<XFile> imageList = [];
  final ImagePicker _picker = ImagePicker();

  bool isSelectedImage = false;

  imagePick() async {
    try {
      XFile? imageData = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        imageList.add(imageData!);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Image Selection",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Container(
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Image Picker For Carousel Slider",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 180,
                    color: Colors.blue,
                    child: FlatButton(
                      onPressed: () {
                        imagePick();
                        setState(() {
                          isSelectedImage = true;
                        });
                      },
                      child: const Text(
                        "Select Image",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: imageList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Stack(
                              children: [
                                Container(
                                  child:
                                      Image.file(File(imageList[index].path)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imageList.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            isSelectedImage == true
                ? Container(
                    height: 50,
                    width: 180,
                    color: Colors.blue,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CarouselPage(
                                  listCarousel: imageList,
                                )));
                      },
                      child: const Text(
                        "Make Carousel",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
