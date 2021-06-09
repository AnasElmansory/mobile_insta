import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/controllers/settings/language_controller.dart';

class Languages extends StatelessWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<LanguageController>();
    return Obx(
      () => Column(
        children: [
          RadioListTile<String>(
            title: const Text('العربية'),
            value: 'ar',
            dense: true,
            groupValue: language.radioGroupValue,
            onChanged: (value) async => await language.redioOnChanged(value!),
          ),
          RadioListTile<String>(
            title: const Text('English'),
            value: 'en',
            dense: true,
            groupValue: language.radioGroupValue,
            onChanged: (value) async => await language.redioOnChanged(value!),
          ),
          RadioListTile<String>(
            title: const Text("Español"),
            value: 'es',
            dense: true,
            groupValue: language.radioGroupValue,
            onChanged: (value) async => await language.redioOnChanged(value!),
          ),
        ],
      ),
    );
  }
}
