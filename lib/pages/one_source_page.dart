import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:insta_news_mobile/api/news_service.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/widgets/news_widget.dart';

class OneSourcePage extends StatefulWidget {
  final Source source;
  const OneSourcePage({Key? key, required this.source}) : super(key: key);

  @override
  State<OneSourcePage> createState() => _OneSourcePageState();
}

class _OneSourcePageState extends State<OneSourcePage> {
  Source get source => widget.source;
  final newsService = getIt<NewsService>();
  Box? _cacheBox;
  late PagingController<int, News> _pagingController;
  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, News>(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) async {
      if (!await isConnected()) {
        _cacheBox = await Hive.openBox('sourcesNews');
        final cacheList = _cacheBox!.get(source.id, defaultValue: const [])!;
        _pagingController.appendLastPage(cacheList);
      }

      final _items = await newsService.getNewsBySource(widget.source, pageKey);
      if (_items.length < 10) {
        _pagingController.appendLastPage([..._items.toSet()]);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage([..._items.toSet()], nextPageKey);
      }
    });
  }

  @override
  void dispose() {
    if (_cacheBox?.isOpen ?? false) {
      final sourceNews = _pagingController.itemList ?? [];
      _cacheBox?.put(source.id, sourceNews);
    }
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GFListTile(
            titleText: source.name,
            subTitle: Text(
              '@' + source.username,
              style: const TextStyle(color: Colors.blue),
            ),
            description: AutoSizeText(
              source.description ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            avatar: GFAvatar(
              backgroundImage: CachedNetworkImageProvider(
                source.profileImageMedium,
              ),
            ),
          ),
          Expanded(
            child: PagedListView.separated(
              pagingController: _pagingController,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              builderDelegate: PagedChildBuilderDelegate<News>(
                itemBuilder: (context, news, index) {
                  return NewsWidget(news: news);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
