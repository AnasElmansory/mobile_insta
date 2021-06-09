import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/pages/profile_page.dart';
import 'package:insta_news_mobile/controllers/settings/home_page_controller.dart';
import 'package:insta_news_mobile/widgets/home_naviagtion_bar.dart';

import 'sources_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomePageController());

    return Scaffold(
      body: PageView(
        controller: homeController.pageController,
        onPageChanged: (page) => homeController.toPage(page),
        children: const [
          Text('text2'),
          Text('text3'),
          SourcesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const HomeNavigationBar(),
    );
  }
}
