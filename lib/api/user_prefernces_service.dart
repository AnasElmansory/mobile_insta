import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class UserPreferencesService {
  final Dio dio;
  const UserPreferencesService(this.dio);

  Future<bool> saveUserFavorites() async {
    final guestBox = await Hive.openBox('guest');
    final userId = guestBox.get('userId');
    try {
      final response = await dio.post(
        baseUrl + '/save/favorite',
        queryParameters: {'guestId': userId},
        options: Options(headers: await constructHeaders()),
      );
      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> saveUserFollow() async {
    final guestBox = await Hive.openBox('guest');
    final userId = guestBox.get('userId');
    try {
      final response = await dio.post(
        baseUrl + '/save/follows',
        queryParameters: {'guestId': userId},
        options: Options(headers: await constructHeaders()),
      );
      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }
}
