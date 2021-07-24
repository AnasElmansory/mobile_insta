import 'package:hive/hive.dart';

abstract class IApiService<T> {
  Future<List<T>> getItems({int? page});
  Future<List<T>> searchItems({required String query, int page, int pageSize});

  static Future<String> getFollowSources(int page, int pageSize) async {
    final box = await Hive.openBox('followedSources');
    final skip = (page - 1) * (pageSize);
    final follows =
        List<String>.from(box.get('follows', defaultValue: const <String>[]))
            .skip(skip)
            .take(pageSize);
    if (follows.isNotEmpty) {
      return follows.reduce((value, element) => value + ',' + element);
    } else {
      return '';
    }
  }

  const IApiService();
}
