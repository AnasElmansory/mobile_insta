import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/utils/extentions.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final welcomeText = 'welcome_to_insta'.tr;
    final emptyWidgetText = 'empty_widget_text'.tr;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            welcomeText,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            emptyWidgetText,
            textDirection: emptyWidgetText.adaptiveTextDirection,
            textAlign: emptyWidgetText.adaptiveTextAlign,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
