import 'package:dio/dio.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class UsersService {
  final Dio _dio;
  const UsersService(this._dio);

  Future<bool> saveUser(User user) async {
    try {
      final response = await _dio.post(
        baseUrl + '/users',
        data: user.toMap(),
        options: Options(headers: await constructHeaders()),
      );
      final result = response.statusCode == 200;
      return result;
    } on DioError catch (_) {
      return false;
    }
  }
}
