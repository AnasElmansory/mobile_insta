import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

import 'i_api_service.dart';

class FavouriteService extends IApiService<FavoriteNews> {
  final Dio _dio;
  const FavouriteService(this._dio);

  @override
  Future<List<News>> getItems({int? page}) async {
    final guestBox = await Hive.openBox('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.get(
        baseUrl + '/favourite',
        options: Options(headers: await constructHeaders(userId: userId)),
      );

      final news = (result.data as List)
          .map<News>((news) => News.fromMap(news))
          .toList();
      return news;
    } on DioError catch (_) {
      return const <News>[];
    }
  }

  Future<News?> addNewsToFavourite(String newsId) async {
    final data = json.encode({"newsId": newsId});
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.post(
        baseUrl + '/favourite/news',
        data: data,
        options: Options(headers: await constructHeaders(userId: userId)),
      );
      if (result.data == null) return null;
      final news = News.fromMap(result.data);
      return news;
    } on DioError catch (_) {
      return null;
    }
  }

  Future<News?> removeNewsFromFavourite(String newsId) async {
    final data = json.encode({"newsId": newsId});
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.post(
        baseUrl + '/favourite/news',
        data: data,
        options: Options(headers: await constructHeaders(userId: userId)),
      );
      if (result.data == null) return null;
      final news = News.fromMap(result.data);
      return news;
    } on DioError catch (_) {
      return null;
    }
  }

  @override
  Future<List<News>> searchItems({
    required String query,
    int page = 1,
    int pageSize = 10,
  }) async {
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.get(
        baseUrl + '/favourite/search',
        queryParameters: {'query': query},
        options: Options(headers: await constructHeaders(userId: userId)),
      );
      final news = (result.data as List)
          .map<News>((news) => News.fromMap(news))
          .toList();
      return news;
    } on DioError catch (_) {
      return const <News>[];
    }
  }
}
