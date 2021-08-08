import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:insta_news_mobile/controllers/news/hive_boxes_controller.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';
import 'package:insta_news_mobile/controllers/source/source_follow_controller.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class HomeNews extends StatelessWidget {
  final News news;
  const HomeNews({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    final hiveBoxes = Get.find<HiveBoxes>();

    return InkWell(
      onTap: () async {
        await hiveBoxes.saveLastReadNews(news.users.first.id, news.id);
        await navigateToOneSourcePage(news.users.first);
      },
      child: SizedBox(
        height: size.height * 0.23,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => GFAvatar(
                  child: hiveBoxes.isNewsUnread(news.users.first.id, news.id)
                      ? const Align(
                          alignment: Alignment.topRight,
                          child: GFBadge(
                            shape: GFBadgeShape.circle,
                            border: BorderSide(color: Colors.white, width: .5),
                            size: 25,
                          ),
                        )
                      : null,
                  backgroundImage: CachedNetworkImageProvider(
                    news.users.first.profileImageMedium,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Card(
                  elevation: 5,
                  shape: Get.locale.adaptiveRoundedBorder,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Get.locale.adaptiveWidgetAlignment,
                            child: HomeNewsOptionsDropMenu(
                              source: news.users.first.id,
                              newsId: news.id,
                            ),
                          ),
                        ),
                        const Divider(
                          indent: 20,
                          endIndent: 8,
                        ),
                        Expanded(
                          flex: 3,
                          child: DetectableText(
                            text: news.text,
                            detectionRegExp: RegExp(twitterRegex),
                            textDirection: news.text.adaptiveTextDirection,
                            textAlign: news.text.adaptiveTextAlign,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        const Divider(
                          indent: 20,
                          endIndent: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(news.createdAt.newsTime),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeNewsOptionsDropMenu extends StatelessWidget {
  final String source;
  final String newsId;
  const HomeNewsOptionsDropMenu({
    Key? key,
    required this.source,
    required this.newsId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hiveBoxes = Get.find<HiveBoxes>();
    final notificationController = Get.find<SettingsController>();
    final followController = Get.find<SourceFollowController>();

    return Obx(
      () => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: const Icon(
            Icons.more_horiz,
            size: GFSize.SMALL,
          ),
          onChanged: (_) {},
          items: [
            (followController.isFollowing(source))
                ? DropdownMenuItem(
                    value: '1',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.cancel),
                        const SizedBox(width: 8),
                        Text('unfollow'.tr),
                      ],
                    ),
                    onTap: () async =>
                        await followController.manageFollowSource(source),
                  )
                : DropdownMenuItem(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.follow_the_signs),
                        const SizedBox(width: 8),
                        Text('follow'.tr),
                      ],
                    ),
                    value: '2',
                    onTap: () async =>
                        await followController.manageFollowSource(source),
                  ),
            (notificationController.isNotificationEnabled(source))
                ? DropdownMenuItem(
                    value: '3',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.notifications_off),
                        const SizedBox(width: 8),
                        Text('mute_notification'.tr),
                      ],
                    ),
                    onTap: () async => await notificationController
                        .unsubscribeFromTopic(source),
                  )
                : DropdownMenuItem(
                    value: '4',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.notifications_on),
                        const SizedBox(width: 8),
                        Text('enable_notification'.tr),
                      ],
                    ),
                    onTap: () async =>
                        await notificationController.subscribeToTopic(source),
                  ),
            DropdownMenuItem(
              value: '5',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.done),
                  const SizedBox(width: 8),
                  Text('mark_as_read'.tr),
                ],
              ),
              onTap: hiveBoxes.isNewsUnread(source, newsId)
                  ? () async => await hiveBoxes.saveLastReadNews(source, newsId)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
