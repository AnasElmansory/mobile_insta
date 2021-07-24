import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:insta_news_mobile/models/search_model.dart';

SearchModel<T> useSearchHook<T>({
  String appBarTitle = 'INSTA News',
  required String hintText,
  required IApiService<T> service,
}) {
  return use(
    _Search<T>(
      appBarTitle: appBarTitle,
      hintText: hintText,
      service: service,
    ),
  );
}

class _Search<T> extends Hook<SearchModel<T>> {
  final String appBarTitle;
  final String hintText;
  final IApiService<T> service;

  const _Search({
    required this.appBarTitle,
    required this.hintText,
    required this.service,
  });

  @override
  _SearchBarState<T> createState() => _SearchBarState<T>();
}

class _SearchBarState<T> extends HookState<SearchModel<T>, _Search<T>> {
  late SearchBar searchBar;
  late ValueNotifier<List<T>> notifier;
  late Widget searchBody;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'INSTA News',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        searchBar.getSearchAction(context),
      ],
    );
  }

  Future<void> doSearch(String query) async {
    searchBar.beginSearch(context);
    final result = await hook.service.searchItems(query: query);
    notifier.value = result;
  }

  @override
  void initHook() {
    searchBar = SearchBar(
      setState: setState,
      buildDefaultAppBar: buildAppBar,
      onSubmitted: (query) async => await doSearch(query),
      hintText: hook.hintText,
    );
    notifier = ValueNotifier(<T>[]);

    super.initHook();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  SearchModel<T> build(BuildContext context) {
    return SearchModel<T>(
      notifier,
      searchBar,
    );
  }
}
