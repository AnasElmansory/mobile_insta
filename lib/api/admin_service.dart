import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class AdminService {
  final Dio _dio;

  const AdminService(this._dio);

  Future<User?> getAdmin(String userId) async {
    final headers = await constructHeaders();
    try {
      final result = await _dio.get(
        baseUrl + '/admin/$userId',
        options: Options(
          headers: headers,
        ),
      );
      if (result.data == null || result.data.isEmpty) return null;
      final admin = User.fromMap(result.data);
      return admin;
    } on DioError catch (_) {
      // await Fluttertoast.showToast(msg: '');
      return null;
    }
  }

  Future<bool> checkAdminPermission(String userId) async {
    try {
      final result = await _dio.get(
        baseUrl + '/is-admin/$userId',
        options: Options(headers: await constructHeaders()),
      );
      final isAdmin = result.data as bool;
      return isAdmin;
    } on DioError catch (error) {
      await Fluttertoast.showToast(msg: '${error.response?.data}');
      return false;
    }
  }
}
