import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';

class ImageSlider extends StatefulWidget {
  final List<String> images;

  ImageSlider({required this.images});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Slider'),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: widget.images
                .map((image) => PhotoView(
                      imageProvider: NetworkImage(image),
                      minScale: PhotoViewComputedScale.contained,
                      backgroundDecoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Text('Image ${_currentIndex + 1} of ${widget.images.length}'),
          ElevatedButton(
            onPressed: () {
              // Add your code to download the current image here.
            },
            child: Text('Download'),
          ),
        ],
      ),
    );
  }
}