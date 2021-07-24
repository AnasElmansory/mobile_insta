import 'package:flutter/material.dart';

class SliderIndicator extends StatelessWidget {
  final List<String> photos;
  final int currentIndex;
  final Color unSelectedColor;
  const SliderIndicator({
    Key? key,
    required this.photos,
    required this.currentIndex,
    this.unSelectedColor = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: photos.map<Widget>((_) {
        final index = photos.indexOf(_);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.only(
            top: 2.0,
            bottom: 10.0,
            left: 2.0,
            right: 2.0,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.blue[700] : unSelectedColor,
          ),
        );
      }).toList(),
    );
  }
}
