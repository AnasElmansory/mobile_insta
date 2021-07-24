import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'package:insta_news_mobile/api/favourite_service.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/hooks/pagination_hook.dart';
import 'package:insta_news_mobile/hooks/search_hook.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/widgets/search/search_body.dart';

class FavouriteNewsPage extends HookWidget {
  const FavouriteNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouriteService = getIt<FavouriteService>();
    final searchModel = useSearchHook<FavoriteNews>(
      hintText: 'search_for_favorite_news'.tr,
      service: favouriteService,
    );
    final searching = useValueListenable(searchModel.searchBar.isSearching);

    return Scaffold(
      appBar: searchModel.searchBar.build(context),
      body: searching
          ? SearchBody<FavoriteNews>(notifier: searchModel.items)
          : PaginationWidget.favourteNews(
              apiService: favouriteService,
            ),
    );
  }
}
