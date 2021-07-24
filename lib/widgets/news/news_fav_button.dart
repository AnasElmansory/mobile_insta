import 'package:flutter/material.dart';

class NewsFavButton extends StatelessWidget {
  final Icon icon;
  final void Function() onPressed;

  const NewsFavButton.notFavorite({Key? key, required this.onPressed})
      : icon = const Icon(
          Icons.bookmark_add_outlined,
          color: Colors.grey,
        ),
        super(key: key);

  const NewsFavButton.favorite({Key? key, required this.onPressed})
      : icon = const Icon(
          Icons.bookmark_added,
          color: Colors.green,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
    );
  }
}
