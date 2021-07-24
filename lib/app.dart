import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/auth_controller.dart';
import 'package:insta_news_mobile/controllers/news/news_favourite_controller.dart';
import 'package:insta_news_mobile/pages/auth_page.dart';
import 'package:insta_news_mobile/utils/translations.dart';

import 'controllers/settings/home_page_controller.dart';
import 'controllers/settings/settings_controller.dart';
import 'controllers/source/source_follow_controller.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final settings = Get.put(SettingsController());
    Get.put(NewsFavouriteController());
    Get.put(SourceFollowController());
    Get.put(AuthController());
    Get.put(HomePageController());

    return GetMaterialApp(
      translations: InstaTranslation(),
      locale: settings.locale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        fontFamily: 'Tajawal',
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.blue[800],
        ),
      ),
      home: const AuthPage(),
    );
  }
}
