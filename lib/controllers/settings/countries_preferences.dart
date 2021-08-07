import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/controllers/source/source_follow_controller.dart';
import 'package:insta_news_mobile/models/country.dart';

class CountriesController extends GetxController {
  final RxList<Country> countriesPreferences = <Country>[].obs;
  final followController = Get.find<SourceFollowController>();
  late Box<List<Country>> _box;

  bool selected(Country country) {
    for (final source in country.sources) {
      if (followController.follows.contains(source.id)) return true;
    }
    return false;
  }

  @override
  void onInit() async {
    _box = await Hive.openBox<List<Country>>('countries');
    countriesPreferences.addAll(List<Country>.from(
        _box.get('countriesPreference', defaultValue: const <Country>[])!));
    super.onInit();
  }

  @override
  void onClose() {
    _box.close();
    super.onClose();
  }
}
