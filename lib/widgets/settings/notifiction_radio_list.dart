import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notification = Get.find<SettingsController>();
    const style = TextStyle(color: Colors.blue);

    return Obx(
      () => Column(
        children: [
          RadioListTile<NotificationStatus>(
            title: Text('on'.tr, style: style),
            value: NotificationStatus.active,
            dense: true,
            groupValue: notification.notificationStatus,
            onChanged: (value) async =>
                await notification.setNotificitionStatus(value!),
          ),
          RadioListTile<NotificationStatus>(
            title: Text('off'.tr, style: style),
            value: NotificationStatus.inActive,
            dense: true,
            groupValue: notification.notificationStatus,
            onChanged: (value) async =>
                await notification.setNotificitionStatus(value!),
          ),
        ],
      ),
    );
  }
}
