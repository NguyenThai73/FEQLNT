import 'package:fe/z_provider/base.url.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';

class ViewCCCDScreen extends StatefulWidget {
  final List<String> images;

  ViewCCCDScreen({required this.images});

  @override
  _State createState() => _State();
}

class _State extends State<ViewCCCDScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File ảnh CCCD'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CarouselSlider(
                items: widget.images
                    .map((image) => PhotoView(
                          imageProvider: NetworkImage("$baseUrl/api/files/$image"),
                          minScale: PhotoViewComputedScale.contained,
                          backgroundDecoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  aspectRatio: 9 / 16,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Image ${_currentIndex + 1} of ${widget.images.length}'),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('Tải xuống'),
          // ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
