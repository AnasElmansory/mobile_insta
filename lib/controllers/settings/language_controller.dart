import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  Rx<Locale> locale = const Locale('en', 'US').obs;
  Future<void> _getLocale() async {
    final shared = await SharedPreferences.getInstance();
    final result = shared.getString('locale');
    if (result == 'en') {
      locale.value = const Locale('en', 'US');
    } else if (result == 'ar') {
      locale.value = const Locale('ar', 'EG');
    } else if (result == 'es') {
      locale.value = const Locale('es', 'MX');
    } else {
      locale.value = Get.deviceLocale ?? locale.value;
    }
    Get.updateLocale(locale.value);
  }

  String get radioGroupValue => locale.value.languageCode;

  Future<void> redioOnChanged(String value) async {
    if (value == 'en') {
      locale.value = const Locale('en', 'US');
    } else if (value == 'ar') {
      locale.value = const Locale('ar', 'EG');
    } else if (value == 'es') locale.value = const Locale('es', 'MX');
    _saveLocale();
    Get.updateLocale(locale.value);
  }

  Future<void> _saveLocale() async {
    final value = locale.value.languageCode;
    final shared = await SharedPreferences.getInstance();
    await shared.setString('locale', value);
  }

  @override
  void onInit() async {
    super.onInit();
    await _getLocale();
  }
}
