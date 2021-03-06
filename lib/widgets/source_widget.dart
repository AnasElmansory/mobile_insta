import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';
import 'package:insta_news_mobile/controllers/source/source_follow_controller.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/navigations.dart';
import 'package:insta_news_mobile/widgets/buttons/notification_button.dart';

import 'buttons/follow_button.dart';

class SourceWidget extends StatelessWidget {
  final Source source;

  const SourceWidget({Key? key, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourceFollow = Get.find<SourceFollowController>();
    final notificatonController = Get.find<SettingsController>();
    final size = context.mediaQuerySize;
    return SizedBox(
      height: size.height * .25,
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () async => await navigateToOneSourcePage(source),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //TODO: edit link in next version
                      CircularProfileAvatar(
                        "source.profileImageMedium",
                        radius: 30,
                        borderWidth: 0.5,
                        borderColor: Colors.blue[800]!,
                        placeHolder: (_, __) =>
                            Image.asset('user_placeholder.png'),
                        errorWidget: (_, __, ___) =>
                            Image.asset('user_placeholder.png'),
                      ),
                      const SizedBox(height: 8),
                      AutoSizeText(
                        source.name,
                        maxLines: 1,
                        textDirection: source.name.adaptiveTextDirection,
                        textAlign: source.name.adaptiveTextAlign,
                      ),
                      AutoSizeText(
                        '@' + source.username,
                        maxLines: 1,
                        textDirection: source.username.adaptiveTextDirection,
                        textAlign: source.username.adaptiveTextAlign,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .10,
                child: const VerticalDivider(
                  color: Colors.black26,
                  width: 4,
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                          left: 8.0,
                        ),
                        child: Center(
                          child: DetectableText(
                            text: source.description ?? '',
                            detectionRegExp: RegExp(twitterRegex),
                            maxLines: 2,
                            textDirection:
                                source.description.adaptiveTextDirection,
                            textAlign: source.description.adaptiveTextAlign,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(
                              () {
                                if (notificatonController
                                    .isNotificationEnabled(source.id)) {
                                  return NotificationButton.mute(
                                    onPressed: () async {
                                      if (await makeSureConnected()) {
                                        await notificatonController
                                            .unsubscribeFromTopic(source.id);
                                      } else {
                                        return;
                                      }
                                    },
                                  );
                                } else {
                                  return NotificationButton.enable(
                                      onPressed: () async {
                                    if (await makeSureConnected()) {
                                      await notificatonController
                                          .subscribeToTopic(source.id);
                                    } else {
                                      return;
                                    }
                                  });
                                }
                              },
                            ),
                            const VerticalDivider(
                              width: 2,
                              // thickness: 1,
                              color: Colors.black26,
                              indent: 4,
                              endIndent: 8,
                            ),
                            Obx(
                              () {
                                if (!sourceFollow.isFollowing(source.id)) {
                                  return FollowButton.follow(
                                      onPressed: () async {
                                    if (await makeSureConnected()) {
                                      await sourceFollow
                                          .manageFollowSource(source.id);
                                    } else {
                                      return;
                                    }
                                  });
                                } else {
                                  return FollowButton.unfollow(
                                      onPressed: () async {
                                    if (await makeSureConnected()) {
                                      await sourceFollow
                                          .manageFollowSource(source.id);
                                    } else {
                                      return;
                                    }
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
