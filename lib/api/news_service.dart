import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class NewsService extends IApiService<News> {
  final Dio _dio;
  const NewsService(this._dio);

  @override
  Future<List<News>> getItems({int? page = 1, int pageSize = 10}) async {
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.get(
        baseUrl + '/news/follow',
        options: Options(headers: await constructHeaders(userId: userId)),
      );

      final newsList = (result.data as List)
          .map<News>((news) => News.fromMap(news))
          .toList();
      return newsList;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return const <News>[];
    }
  }

  Future<List<News>> getNewsBySource(String sourceId, int page) async {
    final data = {'page': page, 'sourceId': sourceId};
    try {
      final result = await _dio.get(
        baseUrl + '/news/by/source',
        queryParameters: data,
        options: Options(headers: await constructHeaders()),
      );
      final newsList = (result.data as List)
          .map<News>((news) => News.fromMap(news))
          .toList();
      return newsList;
    } on DioError catch (_) {
      return const <News>[];
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
    final data = {'query': query};
    try {
      final result = await _dio.get(
        baseUrl + '/news/search/by/follow',
        queryParameters: data,
        options: Options(headers: await constructHeaders(userId: userId)),
      );

      final newsList = (result.data as List)
          .map<News>((news) => News.fromMap(news))
          .toList();
      return newsList;
    } on DioError catch (_) {
      return const <News>[];
    }
  }
}
