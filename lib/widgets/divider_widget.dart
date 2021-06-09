import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final String dividerName;

  const DividerWidget({
    Key? key,
    required this.dividerName,
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
        ),
        const Expanded(
          flex: 4,
          child: Divider(height: 2, color: Colors.black38),
        ),
      ],
    );
  }
}
