import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/api/news_service.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/hooks/pagination_hook.dart';
import 'package:insta_news_mobile/hooks/search_hook.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/widgets/search/search_body.dart';

class HomePageNews extends HookWidget {
  const HomePageNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = getIt<NewsService>();
    final searchModel = useSearchHook<News>(
      hintText: 'search_news'.tr,
      service: newsService,
    );
    bool isSearching = searchModel.searchBar.isSearching.value;
    return Scaffold(
      appBar: searchModel.searchBar.build(context),
      body: isSearching
          ? SearchBody<News>(notifier: searchModel.items)
          : Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: PaginationWidget.homeNews(apiService: newsService),
            ),
    );
  }
}
