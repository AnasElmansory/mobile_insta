import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/hooks/ads_hook.dart';

class HomePageController extends GetxController {
  final Rx<PageController> _pageController = PageController().obs;
  final RxInt _currnetPage = 0.obs;
  final interAd = Get.find<InterAd>();
  PageController get pageController => _pageController.value;
  set pageController(PageController value) => _pageController.value = value;
  int get currnetPage => _currnetPage.value;
  set currnetPage(int value) => _currnetPage.value = value;

  void toPage(int page) {
    _currnetPage.value = page;
    _pageController.value.jumpToPage(page);
    interAd.navigationCounter++;
  }

  @override
  void dispose() {
    _pageController.value.dispose();
    super.dispose();
  }
}
