import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        baseUrl + '/control/countries',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
        options: Options(
          headers: await constructHeaders(),
        ),
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
  Future<List<Country>> searchItems(String query) async {
    try {
      final result = await _dio.get(
        baseUrl + '/control/search-countries/$query',
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final countries = (result.data as List)
          .map<Country>((country) => Country.fromMap(country))
          .toList();
      return countries;
    } on DioError catch (_) {
      return const <Country>[];
    }
  }

  Future<Country?> addCountry(Country country) async {
    final data = country.toJson();
    try {
      final result = await _dio.post(
        baseUrl + '/control/countries',
        data: data,
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final country = Country.fromMap(result.data);
      return country;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return null;
    }
  }
  // Future<Country?> editCountry(Country country) async {
  //   final data = country.toJson();
  //   try {
  //     final result = await _dio.post(
  //       baseUrl + '/control/countries',
  //       data: data,
  //       options: Options(
  //         headers: await constructHeaders(),
  //       ),
  //     );
  //     final country = Country.fromMap(result.data);
  //     return country;
  //   } on DioError catch (error) {
  //     await FluttertoastWebPlugin()
  //         .addHtmlToast(msg: '${error.response?.data}');
  //     return null;
  //   }
  // }

  Future<Country?> deleteCountry(String countryName) async {
    try {
      final result = await _dio.delete(
        baseUrl + '/control/countries/$countryName',
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final country = Country.fromMap(result.data);
      return country;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return null;
    }
  }
}
