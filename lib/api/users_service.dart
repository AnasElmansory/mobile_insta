import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class UsersService {
  final Dio _dio;
  const UsersService(this._dio);

  Future<List<User>> getUsers({int? page, int? pageSize}) async {
    try {
      final result = await _dio.get(
        baseUrl + '/control/users',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final users = (result.data as List)
          .map<User>((news) => User.fromMap(news))
          .toList();
      return users;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return const <User>[];
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      final result = await _dio.get(
        baseUrl + '/control/users/$id',
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final user = User.fromMap(result.data);
      return user;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return null;
    }
  }

  Future<User?> deleteUser(String id) async {
    try {
      final result = await _dio.delete(
        baseUrl + '/control/users/$id',
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final user = User.fromMap(result.data);
      return user;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return null;
    }
  }

  Future<List<User>> searchUser(String query) async {
    try {
      final result = await _dio.get(
        baseUrl + '/control/search/users/$query',
        options: Options(
          headers: await constructHeaders(),
        ),
      );
      final users = (result.data as List)
          .map<User>((news) => User.fromMap(news))
          .toList();
      return users;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return const <User>[];
    }
  }
}
