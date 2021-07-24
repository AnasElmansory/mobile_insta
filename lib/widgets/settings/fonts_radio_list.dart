import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';

class Fonts extends StatelessWidget {
  const Fonts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fonts = Get.find<SettingsController>();
    const style = TextStyle(color: Colors.blue);

    return Obx(
      () => Column(
        children: [
          RadioListTile<InstaFontSize>(
            title: Text('small'.tr, style: style),
            value: InstaFontSize.small,
            dense: true,
            groupValue: fonts.instaSize,
            onChanged: (value) async => await fonts.changeFontSize(value!),
          ),
          RadioListTile<InstaFontSize>(
            title: Text('medium'.tr, style: style),
            value: InstaFontSize.medium,
            dense: true,
            groupValue: fonts.instaSize,
            onChanged: (value) async => await fonts.changeFontSize(value!),
          ),
          RadioListTile<InstaFontSize>(
            title: Text("large".tr, style: style),
            value: InstaFontSize.large,
            dense: true,
            groupValue: fonts.instaSize,
            onChanged: (value) async => await fonts.changeFontSize(value!),
          ),
        ],
      ),
    );
  }
}
