import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/controllers/auth_controller.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final bool userSignOut;

  const AuthButton._(this.text, this.icon, this.userSignOut);

  factory AuthButton.login() {
    return AuthButton._(
      'login'.tr,
      const Icon(
        Icons.login,
      ),
      false,
    );
  }
  factory AuthButton.logOut() {
    return AuthButton._(
      'logout'.tr,
      const Icon(
        Icons.logout,
      ),
      true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return GFButton(
      text: text,
      icon: icon,
      textColor: Colors.black,
      type: GFButtonType.transparent,
      onPressed: () async {
        if (await makeSureConnected()) {
          if (userSignOut) {
            await controller.signOut();
          } else {
            await navigateToSignPage();
          }
        } else {
          return;
        }
      },
    );
  }
}
