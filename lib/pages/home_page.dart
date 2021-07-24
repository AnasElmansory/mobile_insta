import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/pages/favourtie_news_page.dart';
import 'package:insta_news_mobile/pages/home_page_news.dart';
import 'package:insta_news_mobile/pages/profile_page.dart';
import 'package:insta_news_mobile/controllers/settings/home_page_controller.dart';
import 'package:insta_news_mobile/widgets/home_naviagtion_bar.dart';

import 'sources_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.toPage,
        children: const [
          HomePageNews(),
          FavouriteNewsPage(),
          SourcesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const HomeNavigationBar(),
    );
  }
}
