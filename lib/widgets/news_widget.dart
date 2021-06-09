import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:insta_news_mobile/controllers/settings/font_controller.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/models/twitter_models/media.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class NewsWidget extends GetWidget<FontController> {
  final News news;

  const NewsWidget({Key? key, required this.news}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hasMedia = (news.media?.isNotEmpty ?? false) && news.media != null;
    final newsPhotos = hasMedia ? _photos(news.media!) : null;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DetectableText(
                text: news.text,
                basicStyle: TextStyle(fontSize: controller.instaSize.fontSize),
                detectionRegExp: RegExp(twitterRegex),
                textAlign:
                    news.text.isArabic ? TextAlign.right : TextAlign.justify,
                textDirection:
                    news.text.isArabic ? TextDirection.rtl : TextDirection.ltr,
                onTap: openUrl,
              ),
            ),
            if (newsPhotos != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: newsPhotos
                      .map<Widget>(
                        (photo) => InkWell(
                          onTap: () async => await navigateToImagePage(photo),
                          child: Center(
                            child: Hero(
                              tag: photo,
                              child: CachedNetworkImage(
                                imageUrl: photo,
                                fit: BoxFit.cover,
                                //todo: add user_placeholder to assets
                                errorWidget: (_, __, ___) =>
                                    Image.asset('user_placeholder.png'),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            const Divider(height: 4, thickness: 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(news.createdAt.newsTime),
                GFButtonBar(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.bookmark_add_outlined),
                      onPressed: () {
                        //todo: implement news favourite
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ).paddingZero,
      ),
    );
  }
}

List<String>? _photos(List<Media> media) {
  if (media.isEmpty) return null;
  final photos = media.map<String>((ph) {
    if (ph.type == MediaType.photo) {
      return ph.url!;
    } else {
      return ph.previewImageUrl!;
    }
  }).toList();
  return photos;
}
