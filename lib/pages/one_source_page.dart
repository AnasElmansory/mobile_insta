import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:insta_news_mobile/hooks/ads_hook.dart';
import 'package:lottie/lottie.dart';

import 'package:insta_news_mobile/api/news_service.dart';
import 'package:insta_news_mobile/controllers/news/news_favourite_controller.dart';
import 'package:insta_news_mobile/controllers/settings/settings_controller.dart';
import 'package:insta_news_mobile/controllers/source/source_follow_controller.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/hooks/search_hook.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/utils/caching.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/widgets/empty_widget.dart';
import 'package:insta_news_mobile/widgets/news/news_widget.dart';
import 'package:insta_news_mobile/widgets/search/search_body.dart';

class OneSourcePage extends StatefulHookWidget {
  final Source source;
  const OneSourcePage({Key? key, required this.source}) : super(key: key);

  @override
  State<OneSourcePage> createState() => _OneSourcePageState();
}

class _OneSourcePageState extends State<OneSourcePage> {
  late PagingController<int, News> _pagingController;
  final newsService = getIt<NewsService>();
  Source get source => widget.source;
  Box? _cacheBox;
  @override
  void initState() {
    _pagingController = PagingController<int, News>(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) async {
      if (!await isConnected()) {
        final cachedItems = await getNamedCachedItems<News>(source.id);
        _pagingController.appendLastPage(cachedItems);
      }

      final _items =
          await newsService.getNewsBySource(widget.source.id, pageKey);
      setNamedCachedItems<News>(source.id, _items);
      if (_items.length < 10) {
        _pagingController.appendLastPage([..._items.toSet()]);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage([..._items.toSet()], nextPageKey);
      }
    });
    Get.find<NewsFavouriteController>().getUserFavouriteNews();
    super.initState();
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
    final service = getIt<NewsService>();
    final searchModel = useSearchHook<News>(
      hintText: 'Search News',
      service: service,
    );
    final isSearching = searchModel.searchBar.isSearching.value;
    return Scaffold(
      appBar: searchModel.searchBar.build(context),
      body: isSearching
          ? SearchBody<News>(notifier: searchModel.items)
          : SourceNewsList(
              source: source,
              pagingController: _pagingController,
            ),
    );
  }
}

class SourceNewsList extends StatelessWidget {
  final Source source;
  final PagingController<int, News> pagingController;
  const SourceNewsList({
    Key? key,
    required this.source,
    required this.pagingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: GFListTile(
                  titleText: source.name,
                  subTitle: Text(
                    '@' + source.username,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  description: AutoSizeText(source.description ?? ''),
                  avatar: GFAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      source.profileImageMedium,
                    ),
                  ),
                ),
              ),
              PagedSliverList.separated(
                pagingController: pagingController,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                builderDelegate: PagedChildBuilderDelegate<News>(
                  noItemsFoundIndicatorBuilder: (_) => const EmptyWidget(),
                  firstPageProgressIndicatorBuilder: (_) =>
                      Lottie.asset('assets/newspaper_spinner.json'),
                  itemBuilder: (context, news, index) {
                    final isAdIndex = index != 0 && index % 3 == 0;
                    final lastNews = pagingController.itemList?.last == news;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!lastNews)
                          NewsWidgets.fromRegular(news: news)
                        else
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NewsWidgets.fromRegular(news: news),
                              const SizedBox(height: 58),
                            ],
                          ),
                        if (isAdIndex && !lastNews)
                          const NativeAdContainer.medium(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          height: 50,
          width: context.mediaQuerySize.width,
          child: SourceActionButtons(sourceId: source.id),
        ),
      ],
    );
  }
}

class SourceActionButtons extends StatelessWidget {
  final String sourceId;
  const SourceActionButtons({Key? key, required this.sourceId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<SettingsController>();
    final sourceFollow = Get.find<SourceFollowController>();
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Obx(
            () {
              if (notificationController.isNotificationEnabled(sourceId)) {
                return GFButton(
                  text: 'mute_notification'.tr,
                  borderShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  color: Colors.red,
                  onPressed: () async {
                    if (await makeSureConnected()) {
                      await notificationController
                          .unsubscribeFromTopic(sourceId);
                    } else {
                      return;
                    }
                  },
                );
              } else {
                return GFButton(
                  text: 'enable_notification'.tr,
                  borderShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  color: Colors.blue,
                  onPressed: () async {
                    if (await makeSureConnected()) {
                      await notificationController.subscribeToTopic(sourceId);
                    } else {
                      return;
                    }
                  },
                );
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Obx(
            () {
              if (!sourceFollow.isFollowing(sourceId)) {
                return GFButton(
                  text: 'follow'.tr,
                  borderShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  color: Colors.blue,
                  onPressed: () async {
                    if (await makeSureConnected()) {
                      await sourceFollow.manageFollowSource(sourceId);
                    } else {
                      return;
                    }
                  },
                );
              } else {
                return GFButton(
                    text: 'unfollow'.tr,
                    borderShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color: Colors.red,
                    onPressed: () async {
                      if (await makeSureConnected()) {
                        await sourceFollow.manageFollowSource(sourceId);
                      } else {
                        return;
                      }
                    });
              }
            },
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
