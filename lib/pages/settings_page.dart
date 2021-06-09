import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/widgets/divider_widget.dart';
import 'package:insta_news_mobile/widgets/settings/app_version_widget.dart';
import 'package:insta_news_mobile/widgets/settings/fonts_radio_list.dart';
import 'package:insta_news_mobile/widgets/settings/languages_radio_list.dart';
import 'package:insta_news_mobile/widgets/settings/notifiction_radio_list.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            DividerWidget(dividerName: 'language'.tr),
            const Languages(),
            DividerWidget(dividerName: 'font_size'.tr),
            const Fonts(),
            DividerWidget(dividerName: 'notifications'.tr),
            const Notifications(),
            DividerWidget(dividerName: 'app_version'.tr),
            const AppVersion(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
