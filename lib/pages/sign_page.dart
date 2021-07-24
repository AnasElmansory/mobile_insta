import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/controllers/auth_controller.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class SignPage extends GetWidget<AuthController> {
  final bool isFirstTime;
  const SignPage({Key? key})
      : isFirstTime = false,
        super(key: key);
  const SignPage.firstTime({Key? key})
      : isFirstTime = true,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: size.height * .1),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('horizontal_logo.png'),
              ),
            ),
          ),
          SizedBox(height: size.height * .1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GFButton(
              elevation: 5,
              icon: const Icon(
                FontAwesomeIcons.facebookF,
                color: Colors.white,
              ),
              borderShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              position: GFPosition.end,
              fullWidthButton: true,
              text: 'facebook_login'.tr,
              color: Colors.blue[800]!,
              onPressed: () async => await controller
                  .signInWithFacebook()
                  .whenComplete(() => _onAuthCompleted(isFirstTime)),
            ).marginSymmetric(horizontal: 8),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GFButton(
              elevation: 5,
              fullWidthButton: true,
              color: Colors.white,
              position: GFPosition.end,
              icon: const Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              text: 'google_login'.tr,
              borderShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              textColor: Colors.black,
              onPressed: () async => await controller
                  .signInWithGoogle()
                  .whenComplete(() => _onAuthCompleted(isFirstTime)),
            ).marginSymmetric(horizontal: 8),
          ),
          const SizedBox(height: 24),
          GFButton(
            text: 'guset_login'.tr,
            type: GFButtonType.transparent,
            textColor: Colors.black,
            onPressed: () async {
              final result = await _signAsGuest(isFirstTime);
              if (result) _onAuthCompleted(isFirstTime);
            },
          ),
        ],
      ),
    );
  }
}

void _onAuthCompleted(bool isFirstTime) {
  if (isFirstTime) {
    navigateToHomePage();
  } else {
    Get.back();
  }
}

Future<bool> _signAsGuest(bool isFirstTime) async {
  if (!await makeSureConnected()) return false;
  final result = await Get.dialog<bool>(
    Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GFListTile(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(0),
            avatar: const Icon(
              Icons.info,
              color: Colors.amber,
            ),
            title: Text('guset_login_alert'.tr),
          ),
          const Divider(height: 0),
          GFButtonBar(
            children: [
              GFButton(
                text: 'cancel'.tr,
                color: Colors.white,
                type: GFButtonType.outline,
                textColor: Colors.black,
                onPressed: () => Get.back(result: false),
              ),
              const SizedBox(
                height: 40,
                child: VerticalDivider(),
              ),
              GFButton(
                text: 'continue'.tr,
                color: Colors.white,
                textColor: Colors.blue,
                onPressed: () => Get.back(result: true),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  return result ?? false;
}
