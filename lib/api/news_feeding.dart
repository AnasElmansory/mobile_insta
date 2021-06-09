import 'package:dio/dio.dart';
import 'package:insta_news_mobile/utils/constants.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class FeedingService {
  final Dio _dio;

  const FeedingService(this._dio);

  Future<FeedingStatus> getFeedingState() async {
    final headers = await constructHeaders();
    try {
      final response = await _dio.get(
        baseUrl + '/control/feeding',
        options: Options(
          headers: headers,
        ),
      );
      if (response.data['feeding'] == true) {
        return FeedingStatus.enabled;
      } else {
        return FeedingStatus.disabled;
      }
    } on DioError catch (_) {
      return FeedingStatus.unknown;
    }
  }

  Future<FeedingStatus> enableFeeding() async {
    final headers = await constructHeaders();
    try {
      final response = await _dio.post(
        baseUrl + '/control/startfeeding',
        options: Options(
          headers: headers,
        ),
      );
      if (response.data['feeding'] == true) {
        return FeedingStatus.enabled;
      } else {
        return FeedingStatus.disabled;
      }
    } on DioError catch (_) {
      return FeedingStatus.unknown;
    }
  }

  Future<FeedingStatus> disableFeeding() async {
    final headers = await constructHeaders();
    try {
      final response = await _dio.post(
        baseUrl + '/control/stopfeeding',
        options: Options(
          headers: headers,
        ),
      );
      if (response.data['feeding'] == true) {
        return FeedingStatus.enabled;
      } else {
        return FeedingStatus.disabled;
      }
    } on DioError catch (_) {
      // await Fluttertoast.showToast(msg: '${error.message}');
      return FeedingStatus.unknown;
    }
  }
}

enum FeedingStatus { enabled, disabled, unknown }
