import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:insta_news_mobile/utils/helper.dart';

PagingController<int, T> usePagingController<T>(
  int? pageKey,
  IApiService<T> apiService,
) {
  return use(_PaginationHook<T>(pageKey, apiService));
}

class _PaginationHook<T> extends Hook<PagingController<int, T>> {
  final int? pageKey;
  final IApiService<T> apiService;
  const _PaginationHook(this.pageKey, this.apiService);

  @override
  _PaginationHookState<T> createState() => _PaginationHookState<T>();
}

class _PaginationHookState<T>
    extends HookState<PagingController<int, T>, _PaginationHook<T>> {
  late PagingController<int, T> _pagingController;
  @override
  void initHook() {
    super.initHook();
    _pagingController = PagingController<int, T>(firstPageKey: 1);
    _pagingController.addPageRequestListener((_pageKey) async {
      if (!await isConnected()) {
        final cachedItems = await getCachedItems<T>();
        final itemList = cachedItems.values.first;
        return _pagingController.appendLastPage(itemList);
      }
      final _items = await hook.apiService.getItems(page: _pageKey);
      if (_items.length < 10) {
        _pagingController.appendLastPage([..._items.toSet()]);
        setCachedItems<T>(_pageKey, _items);
      } else {
        final nextPageKey = _pageKey + 1;
        _pagingController.appendPage([..._items.toSet()], nextPageKey);
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  PagingController<int, T> build(BuildContext context) {
    return _pagingController;
  }
}
