import 'package:get/get.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/pages/home_page.dart';
import 'package:insta_news_mobile/pages/image_page.dart';
import 'package:insta_news_mobile/pages/one_source_page.dart';
import 'package:insta_news_mobile/pages/pick_country_page.dart';
import 'package:insta_news_mobile/pages/settings_page.dart';
import 'package:insta_news_mobile/pages/sign_page.dart';

Future<void> navigateToHomePage({User? user}) async {
  await Get.off(() => const HomePage());
}

Future<void> navigateToSignPage() async {
  await Get.off(() => const SignPage());
}

Future<void> navigateToCountryPage() async {
  await Get.off(() => const PickCountryPage());
}

Future<void> navigateToSettingsPage() async {
  await Get.to(() => const SettingsPage());
}

Future<void> navigateToOneSourcePage(Source source) async {
  await Get.to(OneSourcePage(source: source));
}

Future<void> navigateToImagePage(String image) async {
  await Get.to(ImagePage(image: image));
}
