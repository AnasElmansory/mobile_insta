import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appVersion = Get.put(SettingsController());
    return Obx(
      () => GFListTile(
        title: Text(
          'current_version'.tr + ' : ' + appVersion.version,
        ),
      ),
    );
  }
}
