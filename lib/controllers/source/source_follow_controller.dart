import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/api/sources_service.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/utils/helper.dart';

class SourceFollowController extends GetxController {
  final sourcesService = getIt<SourcesService>();
  final RxList<String> _follows = <String>[].obs;
  List<String> get follows => _follows;
  late Box _box;

  Future<void> getFollowedSources({
    List<String> sources = const <String>[],
  }) async {
    if (!await isConnected()) {
      _follows.addAll(_box.get('follows', defaultValue: const <String>[]));
      _follows.value = [..._follows.toSet()]..shuffle();
    } else {
      if (sources.isNotEmpty) {
        for (final source in sources) {
          if (!_follows.contains(source)) {
            _follows.add(source);
          }
        }
      }
      await _box.put('follows', _follows);
    }
  }

  Future<void> getCachedFollowSources() async {
    _box = await Hive.openBox('followedSources');
    final cachedItems = _box.get('follows', defaultValue: const <String>[]);
    _follows.addAll(cachedItems);
    _follows.value = [..._follows.toSet()]..shuffle();
  }

  Future<void> manageFollowSource(String sourceId) async {
    final result = await sourcesService.manageFollowSources(sourceId);
    if (result.isEmpty) {
      return;
    } else {
      if (!_follows.contains(sourceId)) {
        _follows.add(sourceId);
      } else {
        _follows.remove(sourceId);
      }
      await _box.put('follows', _follows);
    }
  }

  bool isFollowing(String sourceId) => _follows.contains(sourceId);

  @override
  void onInit() async {
    await getCachedFollowSources();
    super.onInit();
  }

  @override
  void onClose() {
    _box.close();
    super.onClose();
  }
}
