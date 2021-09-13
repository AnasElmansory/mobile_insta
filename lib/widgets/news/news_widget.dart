import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:insta_news_mobile/controllers/news/news_favourite_controller.dart';
import 'package:insta_news_mobile/controllers/news/video_controller.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/models/twitter_models/media.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/navigations.dart';
import 'package:insta_news_mobile/widgets/slider_indicator.dart';

import 'news_fav_button.dart';

abstract class NewsWidgets extends StatelessWidget {
  const NewsWidgets({Key? key}) : super(key: key);
  factory NewsWidgets.fromRegular({required News news}) {
    if (news.referencedTweets.isNotEmpty &&
        news.referencedTweets.first.type == 'quoted') {
      return _SpecialNewsWidget.regular(news: news);
    } else {
      return _NewsWidget.regular(news: news);
    }
  }
  factory NewsWidgets.fromWithAvatar({required News news}) {
    if (news.referencedTweets.isNotEmpty) {
      return _SpecialNewsWidget.withAvatar(news: news);
    } else {
      return _NewsWidget.withAvatar(news: news);
    }
  }
}

abstract class MediaWidget extends StatefulWidget {
  const MediaWidget({Key? key}) : super(key: key);
  factory MediaWidget.fromMedia({
    required Media media,
    required String newsId,
  }) {
    if (media.type == MediaType.photo) {
      return _MediaImage(image: media.url!);
    } else if (media.type == MediaType.video) {
      return _MediaVideo(
        videoUrl: media.url,
        videoPreviewImage: media.previewImageUrl!,
        newsId: newsId,
      );
    } else {
      return _MediaImage(image: media.url!);
    }
  }
}

class _NewsWidget extends NewsWidgets {
  final News news;
  final bool useAvatar;
  const _NewsWidget.regular({
    Key? key,
    required this.news,
  })  : useAvatar = false,
        super(key: key);
  const _NewsWidget.withAvatar({
    Key? key,
    required this.news,
  })  : useAvatar = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (useAvatar)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 2),
            child: GFAvatar(
              backgroundImage: 
              AssetImage('user_placeholder.png'),
              // CachedNetworkImageProvider(
              //   news.users.first.profileImageMedium,
              // ),
              radius: 15,
            ),
          ),
        Expanded(
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(8.0),
            shape: useAvatar
                ? Get.locale.adaptiveRoundedBorder
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _NewsBody(news: news),
            ),
          ).paddingOnly(top: (useAvatar) ? 16 : 0),
        ),
      ],
    );
  }
}

class _SpecialNewsWidget extends NewsWidgets {
  final News news;
  final bool useAvatar;
  const _SpecialNewsWidget.regular({
    Key? key,
    required this.news,
  })  : useAvatar = false,
        super(key: key);
  const _SpecialNewsWidget.withAvatar({
    Key? key,
    required this.news,
  })  : useAvatar = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          useAvatar
              ? _NewsWidget.withAvatar(news: news)
              : _NewsWidget.regular(news: news),
          ...news.referencedTweetObjects.map<Widget>(
            (x) => _ReferencedNewsBody(
              useAvatar: useAvatar,
              news: news,
            ),
          )
        ],
      ).paddingZero,
    );
  }
}

//* news widgets
class _MediaSection extends StatelessWidget {
  final List<Media> mediaList;
  final String newsId;
  const _MediaSection({
    Key? key,
    required this.mediaList,
    required this.newsId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<int?>(
      initialValue: 0,
      builder: (value, update) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GFCarousel(
              viewportFraction: 1.0,
              enlargeMainPage: true,
              onPageChanged: (index) => update(index),
              items: mediaList.map<Widget>((media) {
                return InkWell(
                  onTap: () async {
                    if (mediaList.length > 1) {
                      final mediaIndex = mediaList.indexOf(media);
                      await navigateToImagesPage(mediaList, mediaIndex);
                    } else {
                      await navigateToImagePage(media);
                    }
                  },
                  child: MediaWidget.fromMedia(
                    media: media,
                    newsId: newsId,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 4),
            if (mediaList.length > 1)
              SliderIndicator(
                photos: mediaList.map((m) => m.url ?? 'photo').toList(),
                currentIndex: value ?? 0,
              ),
          ],
        );
      },
    );
  }
}

class _MediaImage extends MediaWidget {
  final String image;

  const _MediaImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<_MediaImage> createState() => _MediaImageState();
}

class _MediaImageState extends State<_MediaImage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Hero(
        tag: widget.image,
        child: CachedNetworkImage(
          imageUrl: widget.image,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => Image.asset('user_placeholder.png'),
        ),
      ),
    );
  }
}

class _MediaVideo extends MediaWidget {
  final String newsId;
  final String? videoUrl;
  final String videoPreviewImage;
  const _MediaVideo({
    Key? key,
    required this.newsId,
    required this.videoUrl,
    required this.videoPreviewImage,
  }) : super(key: key);

  @override
  State<_MediaVideo> createState() => _MediaVideoState();
}

class _MediaVideoState extends State<_MediaVideo> {
  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(VideoController());
    videoController.getVideo(widget.videoUrl);
    return Obx(() {
      if (videoController.showPreviewImage) {
        return _MediaImage(image: widget.videoPreviewImage);
      } else {
        return ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: Chewie(
            controller: videoController.chewieController,
          ),
        );
      }
    });
  }
}

class _NewsBody extends GetWidget<SettingsController> {
  final News news;
  const _NewsBody({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favNewsController = Get.find<NewsFavouriteController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: DetectableText(
            text: news.text,
            basicStyle: TextStyle(fontSize: controller.fontSize),
            detectionRegExp: RegExp(twitterRegex),
            textAlign: news.text.isArabic ? TextAlign.right : TextAlign.justify,
            textDirection: news.text.adaptiveTextDirection,
            onTap: openUrl,
          ),
        ),
        if (news.media.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: _MediaSection(
              mediaList: news.media,
              newsId: news.id,
            ),
          ),
        const Divider(height: 4, thickness: 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(news.createdAt.newsTime),
            GFButtonBar(
              children: [
                Obx(
                  () {
                    if (favNewsController.isFavorite(news.id)) {
                      return NewsFavButton.favorite(
                        onPressed: () async => await favNewsController
                            .removeNewsFromFavourite(newsId: news.id),
                      );
                    } else {
                      return NewsFavButton.notFavorite(
                        onPressed: () async => await favNewsController
                            .addNewsToFavourite(newsId: news.id),
                      );
                    }
                  },
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

class _ReferencedNewsBody extends StatefulWidget {
  final bool useAvatar;
  final News news;
  const _ReferencedNewsBody({
    Key? key,
    required this.useAvatar,
    required this.news,
  }) : super(key: key);

  @override
  __ReferencedNewsBodyState createState() => __ReferencedNewsBodyState();
}

class __ReferencedNewsBodyState extends State<_ReferencedNewsBody> {
  News get news => widget.news;
  bool get useAvatar => widget.useAvatar;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 32,
            child: VerticalDivider(
              color: Colors.black38,
            ),
          ),
        ),
        useAvatar
            ? _NewsWidget.withAvatar(news: news)
            : _NewsWidget.regular(news: news)
      ],
    );
  }
}
