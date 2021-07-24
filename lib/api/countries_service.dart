import 'package:dio/dio.dart';
import 'package:insta_news_mobile/api/i_api_service.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class CountriesService extends IApiService<Country> {
  final Dio _dio;
  const CountriesService(this._dio);

  @override
  Future<List<Country>> getItems({int? page, int? pageSize}) async {
    try {
      final result = await _dio.get(
        baseUrl.replaceAll('api', 'control/countries'),
        queryParameters: {'page': page, 'pageSize': pageSize},
        options: Options(headers: await constructHeaders()),
      );
      final countries = (result.data as List)
          .map<Country>((country) => Country.fromMap(country))
          .toList();
      return countries;
    } on DioError catch (_) {
      return const <Country>[];
    }
  }

  @override
  Future<List<Country>> searchItems({
    required String query,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final result = await _dio.get(
        baseUrl.replaceAll('/api', '/control/countries/search/$query'),
        options: Options(headers: await constructHeaders()),
      );
      final countries = (result.data as List)
          .map<Country>((country) => Country.fromMap(country))
          .toList();
      return countries;
    } on DioError catch (_) {
      return const <Country>[];
    }
  }
}
