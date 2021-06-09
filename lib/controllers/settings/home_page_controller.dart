import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final _pageController = PageController();
  final RxInt _currnetPage = 0.obs;
  PageController get pageController => _pageController;
  int get currnetPage => _currnetPage.value;

  void toPage(int page) {
    _currnetPage.value = page;
    _pageController.jumpToPage(page);
  }
}
