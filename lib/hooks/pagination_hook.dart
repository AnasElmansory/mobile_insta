import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:insta_news_mobile/controllers/news/news_favourite_controller.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/utils/caching.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/widgets/country_tile.dart';
import 'package:insta_news_mobile/widgets/empty_widget.dart';
import 'package:insta_news_mobile/widgets/news/home_news.dart';
import 'package:insta_news_mobile/widgets/news/news_widget.dart';
import 'package:insta_news_mobile/widgets/source_widget.dart';
import 'package:lottie/lottie.dart';

class PaginationWidget<T> extends StatefulWidget {
  final IApiService<T> apiService;
  final Widget divider;
  final bool isFavorite;
  final bool isHomeNews;
  const PaginationWidget._({
    Key? key,
    required this.apiService,
    required this.isFavorite,
    required this.isHomeNews,
    this.divider = const Divider(),
  }) : super(key: key);

  factory PaginationWidget.favourteNews({
    required IApiService<T> apiService,
    Widget divider = const Divider(),
  }) {
    return PaginationWidget._(
      divider: divider,
      apiService: apiService,
      isFavorite: true,
      isHomeNews: false,
    );
  }
  factory PaginationWidget({
    required IApiService<T> apiService,
    Widget divider = const Divider(),
  }) {
    return PaginationWidget._(
      divider: divider,
      apiService: apiService,
      isFavorite: false,
      isHomeNews: false,
    );
  }
  factory PaginationWidget.homeNews({
    required IApiService<T> apiService,
    Widget divider = const Divider(),
  }) {
    return PaginationWidget._(
      divider: divider,
      apiService: apiService,
      isFavorite: false,
      isHomeNews: true,
    );
  }
  @override
  _PaginationWidgetState<T> createState() => _PaginationWidgetState<T>();
}

class _PaginationWidgetState<T> extends State<PaginationWidget<T>>
    with AutomaticKeepAliveClientMixin {
  late PagingController<int, T> _pagingController;
  @override
  void initState() {
    _pagingController = PagingController<int, T>(firstPageKey: 1);
    if (!widget.isFavorite) {
      _pagingController.addPageRequestListener((pageKey) async {
        if (!await isConnected()) {
          final cachedItems = await getCachedItems<T>();
          final itemList = cachedItems.values.first;
          return _pagingController.appendLastPage(itemList);
        }
        final _items = await widget.apiService.getItems(page: pageKey);
        setCachedItems<T>(pageKey, _items);
        if (_items.length < 10) {
          _pagingController.appendLastPage([..._items.toSet()]);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage([..._items.toSet()], nextPageKey);
        }
      });
    } else {
      _pagingController.addPageRequestListener((_) async {
        final favNewsController = Get.find<NewsFavouriteController>();
        await favNewsController.getUserFavouriteNews();
        _pagingController.appendLastPage(favNewsController
            .favouriteNews.reversed
            .toList()
            .map<T>((e) => e as T)
            .toList());
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final listWidget = (T == Country)
        ? PagedGridView(
            pagingController: _pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            builderDelegate: PagedChildBuilderDelegate<T>(
              noItemsFoundIndicatorBuilder: (_) => const EmptyWidget(),
              firstPageProgressIndicatorBuilder: (_) =>
                  Lottie.asset('assets/newspaper_spinner.json'),
              itemBuilder: (context, item, index) =>
                  CountryTile(country: item as Country),
            ),
          )
        : PagedListView.separated(
            pagingController: _pagingController,
            separatorBuilder: (context, index) => widget.divider,
            builderDelegate: PagedChildBuilderDelegate<T>(
              noItemsFoundIndicatorBuilder: (_) => const EmptyWidget(),
              firstPageProgressIndicatorBuilder: (_) =>
                  Lottie.asset('assets/newspaper_spinner.json'),
              itemBuilder: (context, item, index) => widget.isHomeNews
                  ? HomeNews(news: item as News)
                  : _pagedWidget<T>(item),
            ),
          );
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.itemList?.clear();
        _pagingController.nextPageKey = 1;
        _pagingController.refresh();
      },
      child: listWidget,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _pagedWidget<T>(T item) {
  if (item is Source) {
    return SourceWidget(source: item);
  } else if (item is FavoriteNews) {
    return NewsWidgets.fromWithAvatar(news: item as News);
  } else if (item is News) {
    return NewsWidgets.fromRegular(news: item);
  } else {
    return const Text('pagination error!');
  }
}
