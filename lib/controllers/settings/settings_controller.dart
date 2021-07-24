import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/news/hive_boxes_controller.dart';
import 'package:package_info/package_info.dart';

class SettingsController extends GetxController {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final Rx<InstaFontSize> _instaFontSize = InstaFontSize.medium.obs;
  final RxList<String> _enabledList = <String>[].obs;
  List<String> get enabledList => _enabledList;
  final Rx<NotificationStatus> _notificationStatus =
      NotificationStatus.active.obs;
  final Rx<Locale> _locale = const Locale('en', 'US').obs;
  final RxString _version = ''.obs;
  InstaFontSize get instaSize => _instaFontSize.value;
  double get fontSize => (instaSize == InstaFontSize.small)
      ? 14.0
      : (instaSize == InstaFontSize.medium)
          ? 16.0
          : 18.0;
  String get version => _version.value;
  Locale get locale => _locale.value;
  NotificationStatus get notificationStatus => _notificationStatus.value;

  final utilBox = Get.find<HiveBoxes>().utilBox;

  @override
  void onInit() async {
    getNotifciationStatus();
    await getFontSize();
    await _getLocale();
    await getApplicationVersion();
    super.onInit();
  }

  @override
  void onClose() async {
    await utilBox.put('font_size', _instaFontSize.value.index);
    await utilBox.put(' notification_sources', _enabledList);
    super.onClose();
  }

//* notifications

  void getNotificationSources() {
    final index = utilBox.get('notification', defaultValue: 1) as int;
    _notificationStatus.value = NotificationStatus.values[index];
    _enabledList.value =
        utilBox.get('notification_sources', defaultValue: const <String>[])!;
  }

  bool isNotificationEnabled(String sourceId) =>
      _enabledList.contains(sourceId) ? true : false;

  Future<void> setNotificitionStatus(NotificationStatus status) async {
    final utilBox = Get.find<HiveBoxes>().utilBox;
    await utilBox.put('notification', _notificationStatus.value.index);
    _notificationStatus.value = status;
    if (status == NotificationStatus.active) {
      await _firebaseMessaging.getToken();
      for (final source in _enabledList) {
        await _firebaseMessaging.subscribeToTopic(source);
      }
    } else {
      await _firebaseMessaging.deleteToken();
    }
  }

  Future<void> getNotifciationStatus() async {
    final utilBox = Get.find<HiveBoxes>().utilBox;
    final index = utilBox.get('notification', defaultValue: 1) as int;
    _notificationStatus.value = NotificationStatus.values[index];
  }

  Future<void> subscribeToTopic(String topic) async {
    _enabledList.add(topic);
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    _enabledList.remove(topic);
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> manageAutoInit(bool enabled) async =>
      await _firebaseMessaging.setAutoInitEnabled(enabled);

//* app version
  Future<void> getApplicationVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _version.value = packageInfo.version;
  }

//* font size
  Future<void> changeFontSize(InstaFontSize size) async {
    _instaFontSize.value = size;
  }

  Future<void> getFontSize() async {
    final index = utilBox.get('font_size', defaultValue: 1) as int;
    _instaFontSize.value = InstaFontSize.values[index];
  }

//* locale
  Future<void> _getLocale() async {
    final result = utilBox.get('locale');
    if (result == 'en') {
      _locale.value = const Locale('en', 'US');
    } else if (result == 'ar') {
      _locale.value = const Locale('ar', 'EG');
    } else if (result == 'es') {
      _locale.value = const Locale('es', 'MX');
    } else {
      _locale.value = Get.deviceLocale ?? locale;
    }
    Get.updateLocale(locale);
  }

  String get radioGroupValue => locale.languageCode;

  Future<void> redioOnChanged(String value) async {
    if (value == 'en') {
      _locale.value = const Locale('en', 'US');
    } else if (value == 'ar') {
      _locale.value = const Locale('ar', 'EG');
    } else if (value == 'es') _locale.value = const Locale('es', 'MX');
    _saveLocale();
    Get.updateLocale(locale);
  }

  Future<void> _saveLocale() async {
    final value = locale.languageCode;
    await utilBox.put('locale', value);
  }
}

enum InstaFontSize {
  small,
  medium,
  large,
}
enum NotificationStatus {
  active,
  inActive,
}
