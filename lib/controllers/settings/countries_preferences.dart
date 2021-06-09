import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/models/country.dart';

class CountriesController extends GetxController {
  final RxList<Country> countriesPreferences = <Country>[].obs;
  late Box<List<Country>> _box;
  bool selected(Country country) => countriesPreferences.contains(country);
  void handleThis(Country country) {
    if (selected(country)) {
      countriesPreferences.remove(country);
    } else {
      countriesPreferences.add(country);
    }
  }

  @override
  void onInit() async {
    _box = await Hive.openBox<List<Country>>('countries');
    countriesPreferences.addAll(
        _box.get('countriesPreference', defaultValue: const <Country>[])!);
    super.onInit();
  }

  @override
  void onClose() {
    _box.close();
    super.onClose();
  }
}
