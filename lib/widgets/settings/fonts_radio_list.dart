import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/settings/font_controller.dart';

class Fonts extends StatelessWidget {
  const Fonts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fonts = Get.find<FontController>();
    return Obx(
      () => Column(
        children: [
          RadioListTile<InstaFontSize>(
            title: Text('small'.tr),
            value: InstaFontSize.small,
            dense: true,
            groupValue: fonts.instaSize,
            onChanged: (value) async => await fonts.changeFontSize(value!),
          ),
          RadioListTile<InstaFontSize>(
            title: Text('medium'.tr),
            value: InstaFontSize.medium,
            dense: true,
            groupValue: fonts.instaSize,
            onChanged: (value) async => await fonts.changeFontSize(value!),
          ),
          RadioListTile<InstaFontSize>(
            title: Text("large".tr),
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
