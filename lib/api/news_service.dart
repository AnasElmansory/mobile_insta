import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class NewsService extends IApiService<News> {
  final Dio _dio;
  const NewsService(this._dio);

  @override
  Future<List<News>> getItems({int? page, int? pageSize}) async {
    try {
      final result = await _dio.get(
        baseUrl + '/news',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
        options: Options(
          headers: await constructHeaders(),
        ),
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

  Future<News?> getOneNewsById(String id) async {
    try {
      final result = await _dio.get(
        baseUrl + '/news/$id',
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

  Future<List<News>> getNewsBySource(Source source, int page) async {
    final data = {'page': page, 'source': source.toMap()};
    try {
      final result = await _dio.get(
        baseUrl + '/news/by/source',
        queryParameters: data,
        options: Options(
          headers: await constructHeaders(),
        ),
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
  Future<List<News>> searchItems(String query) {
    throw UnimplementedError();
  }
}
