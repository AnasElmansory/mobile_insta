import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/auth_controller.dart';
import 'package:insta_news_mobile/controllers/settings/home_page_controller.dart';
import 'package:insta_news_mobile/hooks/ads_hook.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    authCheck(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: SizedBox(
              height: size.height * .35,
              width: size.width * .65,
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage('logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void authCheck(BuildContext context) {
  final authController = Get.find<AuthController>();
  WidgetsBinding.instance?.addPostFrameCallback((_) async {
    await OpenAd.showAd();
    if (await authController.isLoggedIn()) await authController.getUser();
    if (await isfirstTime()) {
      final controller = Get.find<HomePageController>();
      controller.currnetPage = 2;
      controller.pageController = PageController(initialPage: 2);
      await navigateToTermsPage(firstTime: true);
    } else {
      await navigateToHomePage();
    }
  });
}
