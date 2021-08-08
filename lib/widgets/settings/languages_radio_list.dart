import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';

class Languages extends StatelessWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<SettingsController>();
    const style = TextStyle(color: Colors.blue);
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('العربية', style: style),
            value: 'ar',
            dense: true,
            groupValue: language.radioGroupValue,
            onChanged: (value) async => await language.redioOnChanged(value!),
          ),
          RadioListTile<String>(
            title: const Text('English', style: style),
            value: 'en',
            dense: true,
            groupValue: language.radioGroupValue,
            onChanged: (value) async => await language.redioOnChanged(value!),
          ),
          // RadioListTile<String>(
          //   title: const Text("Español", style: style),
          //   value: 'es',
          //   dense: true,
          //   groupValue: language.radioGroupValue,
          //   onChanged: (value) async => await language.redioOnChanged(value!),
          // ),
        ],
      ),
    );
  }
}
