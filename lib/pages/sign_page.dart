import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/controllers/auth_controller.dart';
import 'package:insta_news_mobile/controllers/settings/home_page_controller.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

//? facebook hash 2eAEjoB6zkAj8RTwgCO1vxt92M4=
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
    final padding = context.mediaQueryPadding;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: padding.top + kToolbarHeight),
          const LanguageTextButton(),
          SizedBox(
            height: size.height * .2,
            width: size.width * .8,
            child: Center(
              child: Image(
                fit: BoxFit.cover,
                width: size.width * .8,
                image: const AssetImage('horizontal_logo.png'),
              ),
            ),
          ),
          SizedBox(height: size.height * .1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GFButton(
              elevation: 10,
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
              final result = await _signAsGuest(isFirstTime, context);
              if (result) _onAuthCompleted(isFirstTime);
            },
          ),
        ],
      ),
    );
  }
}

void _onAuthCompleted(bool isFirstTime) {
  final controller = Get.find<HomePageController>();
  controller.currnetPage = 2;
  controller.pageController = PageController(initialPage: 2);
  if (isFirstTime) {
    navigateToHomePage();
  } else {
    navigateToHomePage();
  }
}

Future<bool> _signAsGuest(bool isFirstTime, BuildContext context) async {
  if (!await makeSureConnected()) return false;
  final size = context.mediaQuerySize;
  final guestAlert = 'guset_login_alert'.tr;
  final result = await Get.dialog<bool>(
    SizedBox(
      width: size.width * .7,
      child: Dialog(
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
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  guestAlert,
                  textAlign: guestAlert.adaptiveTextAlign,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Divider(height: 0),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text('cancel'.tr),
                      onPressed: () => Get.back(result: false),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    child: VerticalDivider(width: 0),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Text('continue'.tr),
                      onPressed: () => Get.back(result: true),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  return result ?? false;
}

class LanguageTextButton extends GetWidget<SettingsController> {
  const LanguageTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isArabic = controller.locale.languageCode == 'ar';
    final buttonText = isArabic ? 'English' : 'عربي';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            if (isArabic) {
              controller.redioOnChanged('en');
            } else {
              controller.redioOnChanged('ar');
            }
          },
          child: Text(buttonText),
        ),
      ),
    );
  }
}
