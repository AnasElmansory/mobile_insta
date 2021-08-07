import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/settings/home_page_controller.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomePageController>();
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: homeController.currnetPage,
        onTap: homeController.toPage,
        items: [
          BottomNavigationBarItem(
            label: 'home'.tr,
            icon: const Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'favorite'.tr,
            icon: const Icon(Icons.bookmark),
          ),
          BottomNavigationBarItem(
            label: 'sources'.tr,
            icon: const Icon(Icons.rss_feed),
          ),
          BottomNavigationBarItem(
            label: 'menu'.tr,
            icon: const Icon(Icons.more_horiz),
          ),
        ],
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
      );
    });
  }
}
