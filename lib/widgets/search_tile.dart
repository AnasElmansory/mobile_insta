import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'country_tile.dart';
import 'source_widget.dart';

class SearchTile {
  static fromItem<T>(T item) {
    if (item is Source) {
      return SourceWidget(source: item);
    } else if (item is Country) return CountryTile(country: item);
  }
}
