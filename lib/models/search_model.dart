import 'package:flutter/cupertino.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class SearchModel<T> {
  final SearchBar searchBar;
  final ValueNotifier<List<T>> items;
  const SearchModel(
    this.items,
    this.searchBar,
  );
}
