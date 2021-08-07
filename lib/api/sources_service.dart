import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:insta_news_mobile/controllers/source/source_follow_controller.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class SourcesService extends IApiService<Source> {
  final Dio _dio;

  const SourcesService(this._dio);
  @override
  Future<List<Source>> getItems({int? page = 1, int pageSize = 10}) async {
    final followController = Get.find<SourceFollowController>();
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.get(
        baseUrl + '/sources/follow',
        queryParameters: {'page': page},
        options: Options(headers: await constructHeaders(userId: userId)),
      );
      final sources = (result.data as List)
          .map<Source>((source) => Source.fromMap(source))
          .toList();
      await followController.getFollowedSources(
        sources: sources.map<String>((s) => s.id).toList(),
      );
      return sources;
    } on DioError catch (_) {
      return const <Source>[];
    }
  }

  Future<List<Source>> getSourcesByCountry(String country) async {
    try {
      final result = await _dio.get(
        baseUrl + '/sources/by/country/$country',
        options: Options(headers: await constructHeaders()),
      );
      final sources = (result.data as List)
          .map<Source>((source) => Source.fromMap(source))
          .toList();
      return sources;
    } on DioError catch (_) {
      return const <Source>[];
    }
  }

  Future<Map<String, dynamic>> manageFollowSources(String sourceId) async {
    final data = json.encode({"sourceId": sourceId});
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.post(
        baseUrl + '/sources/manage/follow',
        data: data,
        options: Options(headers: await constructHeaders(userId: userId)),
      );
      final sources = Map<String, dynamic>.from(result.data);
      return sources;
    } on DioError catch (_) {
      return const <String, dynamic>{};
    }
  }

  @override
  Future<List<Source>> searchItems({
    required String query,
    int page = 1,
    int pageSize = 10,
  }) async {
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.get(
        baseUrl + '/sources/search/by/follow',
        queryParameters: {'query': query, 'page': page},
        options: Options(headers: await constructHeaders(userId: userId)),
      );

      final sources = (result.data as List)
          .map<Source>((source) => Source.fromMap(source))
          .toList();
      return sources;
    } on DioError catch (_) {
      return const <Source>[];
    }
  }

  Future<List<Source>> searchCountrySources({
    required String country,
    required String query,
    int page = 1,
    int pageSize = 10,
  }) async {
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    try {
      final result = await _dio.get(
        baseUrl + '/sources/search/by/country/$country',
        queryParameters: {'query': query, 'page': page},
        options: Options(headers: await constructHeaders(userId: userId)),
      );

      final sources = (result.data as List)
          .map<Source>((source) => Source.fromMap(source))
          .toList();
      return sources;
    } on DioError catch (_) {
      print(_);
      return const <Source>[];
    }
  }
}
