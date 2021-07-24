import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final String dividerName;
  final TextStyle style;
  const DividerWidget({
    Key? key,
    required this.dividerName,
    this.style = const TextStyle(fontSize: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Divider(height: 2, color: Colors.black38),
        ),
        Text(
          "    " + dividerName + "    ",
          style: style,
        ),
        const Expanded(
          flex: 4,
          child: Divider(height: 2, color: Colors.black38),
        ),
      ],
    );
  }
}
