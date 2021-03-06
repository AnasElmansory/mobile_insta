import 'package:get/get.dart';
import 'package:insta_news_mobile/hooks/ads_hook.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/models/twitter_models/media.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/pages/country_sources_page.dart';
import 'package:insta_news_mobile/pages/home_page.dart';
import 'package:insta_news_mobile/pages/image_page.dart';
import 'package:insta_news_mobile/pages/one_source_page.dart';
import 'package:insta_news_mobile/pages/privacy_page.dart';
import 'package:insta_news_mobile/pages/settings_page.dart';
import 'package:insta_news_mobile/pages/sign_page.dart';
import 'package:insta_news_mobile/pages/terms_page.dart';
import 'package:insta_news_mobile/pages/web_view_page.dart';

final interAd = Get.find<InterAd>();

Future<void> navigateToHomePage({User? user}) async {
  await Get.off(() => const HomePage());
}

Future<void> navigateToSignPage() async {
  await Get.off(() => const SignPage.firstTime());
}

Future<void> navigateToSignPageUntil() async {
  interAd.navigationCounter++;
  await Get.to(() => const SignPage());
}

Future<void> navigateToSettingsPage() async {
  interAd.navigationCounter++;
  await Get.to(() => const SettingsPage());
}

Future<void> navigateToOneSourcePage(Source source) async {
  interAd.navigationCounter++;
  await Get.to(() => OneSourcePage(source: source));
}

Future<void> navigateToImagePage(Media media) async {
  interAd.navigationCounter++;
  await Get.to(() => ImagePage.oneImage(media));
}

Future<void> navigateToImagesPage(List<Media> mediaList, int imageIndex) async {
  interAd.navigationCounter++;
  await Get.to(() => ImagePage.manyImages(mediaList, imageIndex));
}

Future<void> navigateToWebViewPage(String url) async {
  interAd.navigationCounter++;
  await Get.to(() => WebViewPage(url: url));
}

Future<void> navigateToCountrySourcesPage(Country country) async {
  interAd.navigationCounter++;
  await Get.to(() => CountrySourcesPage(country: country));
}

Future<void> navigateToPrivacyPage() async {
  interAd.navigationCounter++;
  await Get.to(() => const PrivacyPage());
}

Future<void> navigateToTermsPage({bool firstTime = false}) async {
  interAd.navigationCounter++;
  (firstTime)
      ? await Get.off(() => const TermsPage.firstTime())
      : await Get.to(() => const TermsPage());
}
