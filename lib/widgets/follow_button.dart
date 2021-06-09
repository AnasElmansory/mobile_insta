import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class FollowButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color color;

  const FollowButton.follow({
    Key? key,
    this.text = 'follow',
    this.color = Colors.green,
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
    return GFButton(
      child: AutoSizeText(
        text.tr,
        minFontSize: 10,
        maxLines: 1,
      ),
      onPressed: onPressed,
      borderShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      color: color,
    );
  }
}
