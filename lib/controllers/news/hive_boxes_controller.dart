import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HiveBoxes extends GetxController {
  //* utils box for settings
  Future<void> initHiveUtils() async => await Hive.openBox('utils');

  ///* unread box to indicated unread news
  Future<void> initHiveUnread() async => await Hive.openBox('unread');

  Box get utilBox => Hive.box('utils');
  Box get unreadBox => Hive.box('unread');

  final RxMap<String, String> _lastReadNews = <String, String>{}.obs;
  Map<String, String> get lastReadNews => _lastReadNews;

  Future<void> saveLastReadNews(String source, String newsId) async {
    _lastReadNews[source] = newsId;
    await unreadBox.put('lastReadNews', _lastReadNews);
  }

  void _getLastReadNews() {
    final result = Map<String, String>.from(
        unreadBox.get('lastReadNews', defaultValue: {})!);
    _lastReadNews.addAll(result);
  }

  bool isNewsUnread(String source, String newsId) =>
      _lastReadNews[source] != newsId;

  Future<void> close() async {
    await utilBox.close();
    await unreadBox.close();
  }

  @override
  void onInit() async {
    await initHiveUtils();
    await initHiveUnread();
    _getLastReadNews();
    super.onInit();
  }

  @override
  void onClose() async {
    await close();
    super.onClose();
  }
}
