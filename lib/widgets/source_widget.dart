import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/controllers/source_follow_controller.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

import 'follow_button.dart';

class SourceWidget extends StatelessWidget {
  final Source source;

  const SourceWidget({Key? key, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourceFollow = Get.find<SourceFollow>();
    return Card(
      elevation: 5,
      child: GFListTile(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        onTap: () async => await navigateToOneSourcePage(source),
        title: Align(
          alignment: (source.description ?? '').isArabic
              ? Alignment.center
              : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              source.description ?? 'source_have_no_bio',
              textAlign:
                  (source.description ?? '').isArabic ? TextAlign.right : null,
              textDirection: (source.description ?? '').isArabic
                  ? TextDirection.rtl
                  : null,
            ),
          ),
        ),
        description: Container(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 9,
                child: GFButton(
                  child: AutoSizeText(
                    'mute_notification'.tr,
                    maxLines: 1,
                  ),
                  borderShape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  type: GFButtonType.outline,
                  onPressed: () {
                    //todo unsubscribe from this topic;
                  },
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 6,
                child: Obx(
                  () {
                    if (!sourceFollow.isFollowing(source)) {
                      return FollowButton.follow(onPressed: () async {
                        await sourceFollow.followSource(source);
                      });
                    } else {
                      return FollowButton.unfollow(onPressed: () async {
                        await sourceFollow.unfollowSource(source);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        avatar: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              GFAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  source.profileImageMedium,
                ),
                radius: 35,
              ),
              Text(source.name),
              Text(
                '@' + (source.username),
                style: const TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
