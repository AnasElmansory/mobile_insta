import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class FavouriteService {
  final Dio _dio;
  const FavouriteService(this._dio);

  Future<List<News>> getFavouriteNews({int? page, int? pageSize}) async {
    try {
      final result = await _dio.get(
        baseUrl + '/favourite/news',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final news = (result.data as List)
          .map<News>((news) => News.fromMap(news))
          .toList();
      return news;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return const <News>[];
    }
  }

  Future<News?> addNewsToFavourite(String newsId) async {
    final data = json.encode({"newsId": newsId});
    try {
      final result = await _dio.post(
        baseUrl + '/favourite/news',
        data: data,
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final news = News.fromMap(result.data);
      return news;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return null;
    }
  }
}
