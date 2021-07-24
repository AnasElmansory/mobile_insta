import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/models/twitter_models/media.dart';
import 'package:photo_view/photo_view.dart';

import 'package:insta_news_mobile/widgets/slider_indicator.dart';

abstract class ImagePage extends StatelessWidget {
  const ImagePage({Key? key}) : super(key: key);
  factory ImagePage.oneImage(Media media) {
    return OneImage(media: media);
  }
  factory ImagePage.manyImages(List<Media> mediaList, int imageIndex) {
    return ManyImages(mediaList: mediaList, firstIndex: imageIndex);
  }
}

class OneImage extends ImagePage {
  final Media media;
  const OneImage({Key? key, required this.media}) : super(key: key);
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
            heroAttributes: PhotoViewHeroAttributes(
                tag: media.url ?? media.previewImageUrl ?? ''),
            minScale: PhotoViewComputedScale.contained,
            child: CachedNetworkImage(
              imageUrl: media.url ?? media.previewImageUrl ?? '',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class ManyImages extends ImagePage {
  final List<Media> mediaList;
  final int firstIndex;
  const ManyImages({
    Key? key,
    required this.mediaList,
    required this.firstIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87),
      backgroundColor: Colors.black87,
      body: Center(
        child: SizedBox(
          child: ValueBuilder<int?>(
              initialValue: firstIndex,
              builder: (value, update) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: PageView(
                        controller: PageController(initialPage: firstIndex),
                        onPageChanged: (index) => update(index),
                        children: mediaList.map<Widget>((media) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: PhotoView.customChild(
                              heroAttributes: PhotoViewHeroAttributes(
                                  tag:
                                      media.url ?? media.previewImageUrl ?? ''),
                              minScale: PhotoViewComputedScale.contained,
                              child: CachedNetworkImage(
                                imageUrl:
                                    media.url ?? media.previewImageUrl ?? '',
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SliderIndicator(
                      photos: mediaList.map((m) => m.mediaKey!).toList(),
                      currentIndex: value ?? firstIndex,
                      unSelectedColor: Colors.white,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
