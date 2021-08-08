import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color color;

  const FollowButton.follow({
    Key? key,
    this.text = 'follow',
    this.color = Colors.blue,
    required this.onPressed,
  }) : super(key: key);

  const FollowButton.unfollow({
    Key? key,
    this.text = 'unfollow',
    this.color = Colors.red,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        child: AutoSizeText(
          text.tr,
          minFontSize: 12,
          maxFontSize: Get.locale!.languageCode == 'es' ? 12 : 14,
          maxLines: 1,
          style: TextStyle(color: color),
        ),
        onPressed: onPressed,
        style: const ButtonStyle(),
      ),
    );
  }
}
