import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'search_tile.dart';

class SearchBar<T> extends StatefulWidget {
  final IApiService<T> apiService;
  final String hint;
  const SearchBar({
    Key? key,
    required this.apiService,
    required this.hint,
  }) : super(key: key);

  @override
  _SearchBarState<T> createState() => _SearchBarState<T>();
}

class _SearchBarState<T> extends State<SearchBar<T>> {
  late ValueNotifier<List<T>> _itemNotifier;
  @override
  void initState() {
    super.initState();
    _itemNotifier = ValueNotifier(<T>[]);
  }

  @override
  void dispose() {
    _itemNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      onSubmitted: (query) async {
        final result = await widget.apiService.searchItems(query: query);
        _itemNotifier.value = result;
      },
      hint: widget.hint.tr,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      margins: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      iconColor: Colors.blue,
      automaticallyImplyBackButton: false,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      builder: (context, transition) {
        return ValueListenableBuilder<List<T>>(
          valueListenable: _itemNotifier,
          builder: (context, items, child) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (_, index) {
                final item = items[index];
                return SearchTile.fromItem<T>(item);
              },
            );
          },
        );
      },
    );
  }
}
