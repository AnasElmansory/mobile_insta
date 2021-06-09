import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatelessWidget {
  final String image;
  const ImagePage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87),
      backgroundColor: Colors.black87,
      body: Center(
        child: SizedBox(
          height: size.height * .5,
          child: PhotoView.customChild(
            heroAttributes: PhotoViewHeroAttributes(tag: image),
            minScale: PhotoViewComputedScale.contained,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
