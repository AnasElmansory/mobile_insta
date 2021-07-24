import 'package:get/get.dart';
import 'package:insta_news_mobile/api/favourite_service.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/utils/constants.dart';

class NewsFavouriteController extends GetxController {
  final _favouriteService = getIt<FavouriteService>();
  final RxList<News> _favouriteNews = <News>[].obs;
  List<News> get favouriteNews => _favouriteNews;

  bool isFavorite(String newsId) {
    for (final news in _favouriteNews) {
      if (news.id == newsId) return true;
    }
    return false;
  }

  Future<void> getUserFavouriteNews() async {
    final resultFavNews = await _favouriteService.getItems();
    for (final news in resultFavNews) {
      if (!_favouriteNews.contains(news)) _favouriteNews.add(news);
    }
  }

  Future<void> addNewsToFavourite({required String newsId}) async {
    final result = await _favouriteService.addNewsToFavourite(newsId);
    if (result == null) {
      Get.showSnackbar(GetBar(
        message: 'fav_add_failed'.tr,
      ));

      return;
    } else {
      _favouriteNews.add(result);
      await Get.showSnackbar(GetBar(
        message: 'fav_add_success'.tr,
        duration: kSnackBarDuration,
      ));
    }
  }

  Future<void> removeNewsFromFavourite({required String newsId}) async {
    final result = await _favouriteService.removeNewsFromFavourite(newsId);
    if (result == null) {
      await Get.showSnackbar(GetBar(
        message: 'fav_remove_failed'.tr,
        duration: kSnackBarDuration,
      ));

      return;
    } else {
      _favouriteNews.remove(result);
      await Get.showSnackbar(GetBar(
        message: 'fav_remove_success'.tr,
        duration: kSnackBarDuration,
      ));
    }
  }
}
