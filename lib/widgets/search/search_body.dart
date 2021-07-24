import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/widgets/country_tile.dart';
import 'package:insta_news_mobile/widgets/empty_widget.dart';
import 'package:insta_news_mobile/widgets/news/news_widget.dart';
import 'package:insta_news_mobile/widgets/source_widget.dart';

class SearchBody<T> extends StatelessWidget {
  final ValueListenable<List<T>> notifier;
  const SearchBody({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: notifier,
      builder: (_, items, __) {
        if (items.isEmpty) {
          return const EmptyWidget();
        } else {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is Country) {
                return CountryTile.inSearch(country: item);
              } else if (item is Source) {
                return SourceWidget(source: item);
              } else if (item is News) {
                return NewsWidgets.fromRegular(news: item);
              } else if (item is FavoriteNews) {
                return NewsWidgets.fromWithAvatar(news: item as News);
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            },
          );
        }
      },
    );
  }
}
