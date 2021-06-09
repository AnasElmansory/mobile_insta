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
            icon: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            label: 'favourite'.tr,
            icon: const Icon(
              Icons.bookmark,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            label: 'sources'.tr,
            icon: const Icon(
              Icons.rss_feed,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            label: 'menu'.tr,
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.blue,
            ),
          ),
        ],
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.shifting,
      );
    });
  }
}
