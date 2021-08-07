import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/controllers/auth_controller.dart';
import 'package:insta_news_mobile/utils/navigations.dart';
import 'package:insta_news_mobile/widgets/buttons/auth_button.dart';
import 'package:share/share.dart';

class ProfilePage extends GetWidget<AuthController> {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'INSTA News',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  controller.user.name == 'Guest'
                      ? ''
                      : (controller.user.name ?? controller.user.email),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                accountEmail: Text(
                  controller.user.name != null ? controller.user.email : '',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                decoration: const BoxDecoration(color: Colors.white),
                currentAccountPicture: GFAvatar(
                  backgroundImage: (controller.user.avatar != null &&
                          controller.user.avatar!.isURL)
                      ? CachedNetworkImageProvider(
                          controller.user.avatar!,
                        )
                      : null,
                  backgroundColor: Colors.blue,
                  child: Text(
                    controller.user.name != 'Guest'
                        ? (controller.user.avatar != null)
                            ? ''
                            : (controller.user.name?[0].capitalizeFirst ?? '')
                        : controller.user.name!,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GFListTile(
                titleText: 'settings'.tr,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(0),
                avatar: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                onTap: () async => await navigateToSettingsPage(),
              ),
              const Divider(indent: 50, endIndent: 10, height: 0),
              GFListTile(
                titleText: 'share'.tr,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(0),
                avatar: const Icon(
                  Icons.share,
                  color: Colors.grey,
                ),
                onTap: () async => await Share.share('app_link'),
              ),
              const Divider(indent: 50, endIndent: 10, height: 0),
              GFListTile(
                titleText: 'about'.tr,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(0),
                avatar: const Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
              ),
              const Divider(indent: 50, endIndent: 10, height: 0),
              GFListTile(
                titleText: 'terms_conditions'.tr,
                onTap: navigateToTermsPage,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(0),
                avatar: const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.grey,
                ),
              ),
              const Divider(indent: 50, endIndent: 10, height: 0),
              GFListTile(
                titleText: 'privacy_policy'.tr,
                onTap: navigateToPrivacyPage,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(0),
                avatar: const Icon(
                  Icons.privacy_tip_rounded,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: controller.user.provider == 'guest'
                      ? AuthButton.login()
                      : AuthButton.logOut(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
