import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/models/source.dart';

class SourceFollow extends GetxController {
  final RxList<Source> _followList = <Source>[].obs;
  late Box _box;

  Future<void> getFollowedSources() async {
    _box = await Hive.openBox('followedSources');
    final list = _box.get('sources', defaultValue: const [])!;
    final sources = List<Source>.from(list);
    _followList.clear();
    _followList.addAll(sources);
  }

  Future<void> followSource(Source source) async {
    _followList.addIf(!_followList.contains(source), source);
    await _box.put('sources', _followList);
  }

  Future<void> unfollowSource(Source source) async {
    _followList.remove(source);
    await _box.put('sources', _followList);
  }

  bool isFollowing(Source source) => _followList.contains(source);

  @override
  void onInit() async {
    getFollowedSources();
    super.onInit();
  }

  @override
  void onClose() {
    _box.close();
    super.onClose();
  }
}
