import 'package:dio/dio.dart';
import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class SourcesService extends IApiService<Source> {
  final Dio _dio;

  const SourcesService(this._dio);

  @override
  Future<List<Source>> getItems({int? page, int? pageSize}) async {
    try {
      final result = await _dio.get(
        baseUrl + '/sources',
        queryParameters: {
          "page": page,
          "pageSize": pageSize,
        },
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final sources = (result.data as List)
          .map<Source>((source) => Source.fromMap(source))
          .toList();
      return sources;
    } on DioError catch (_) {
      return const <Source>[];
    }
  }

  Future<Source?> getSourceById(String id) async {
    try {
      final result = await _dio.get(
        baseUrl + '/sources/byId/$id',
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final source = Source.fromMap(result.data);

      return source;
    } on DioError catch (_) {
      return null;
    }
  }

  @override
  Future<List<Source>> searchItems(String query) async {
    try {
      final result = await _dio.get(
        baseUrl + '/sources/by/username/$query',
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final sources = (result.data as List)
          .map<Source>((source) => Source.fromMap(source))
          .toList();
      return sources;
    } on DioError catch (_) {
      return const <Source>[];
    }
  }
}
