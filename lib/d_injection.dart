import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/api/user_prefernces_service.dart';
import 'package:insta_news_mobile/auth/admin_verification.dart';
import 'package:insta_news_mobile/auth/guest_auth.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:path_provider/path_provider.dart';

import 'api/admin_service.dart';
import 'api/countries_service.dart';
import 'api/favourite_service.dart';
import 'api/news_feeding.dart';
import 'api/news_service.dart';
import 'api/sources_service.dart';
import 'api/users_service.dart';
import 'auth/facebook_auth.dart';
import 'auth/google_auth.dart';
import 'controllers/news/hive_boxes_controller.dart';
import 'models/news.dart';
import 'models/twitter_models/attachments.dart';
import 'models/twitter_models/duration_adapter.dart';
import 'models/twitter_models/entities.dart';
import 'models/twitter_models/entity_url.dart';
import 'models/twitter_models/hashtag.dart';
import 'models/twitter_models/media.dart';
import 'models/twitter_models/mention.dart';
import 'models/twitter_models/public_metric.dart';
import 'models/twitter_models/referenced_tweets.dart';

final getIt = GetIt.instance;

void initGet() {
  getIt.registerLazySingleton<GuestAuth>(() => GuestAuth(
        getIt<UsersService>(),
      ));
  getIt.registerLazySingleton<FaceAuth>(() => FaceAuth(
        getIt<FacebookAuth>(),
        getIt<AdminVerification>(),
      ));
  getIt.registerLazySingleton<GoogleAuth>(() => GoogleAuth(
        getIt<GoogleSignIn>(),
        getIt<AdminVerification>(),
      ));
  getIt.registerLazySingleton<AdminVerification>(
      () => AdminVerification(getIt<AdminService>()));
  getIt.registerLazySingleton<AdminService>(() => AdminService(getIt<Dio>()));
  getIt.registerLazySingleton<FavouriteService>(
      () => FavouriteService(getIt<Dio>()));
  getIt.registerLazySingleton<UsersService>(() => UsersService(getIt<Dio>()));
  getIt.registerLazySingleton<NewsService>(() => NewsService(getIt<Dio>()));
  getIt.registerLazySingleton<CountriesService>(
      () => CountriesService(getIt<Dio>()));
  getIt.registerLazySingleton<FeedingService>(
      () => FeedingService(getIt<Dio>()));
  getIt.registerLazySingleton<SourcesService>(
      () => SourcesService(getIt<Dio>()));
  getIt.registerLazySingleton<UserPreferencesService>(
      () => UserPreferencesService(getIt<Dio>()));

  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<GoogleSignIn>(
      () => GoogleSignIn.standard(scopes: ['email', 'profile']));
  getIt.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);
}

Future<void> initHive() async {
  final dir = await getTemporaryDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(SourceAdapter());
  Hive.registerAdapter(CountryAdapter());
  Hive.registerAdapter(AttachmentsAdapter());
  Hive.registerAdapter(EntityAdapter());
  Hive.registerAdapter(EntityUrlAdapter());
  Hive.registerAdapter(MentionAdapter());
  Hive.registerAdapter(HashtagAdapter());
  Hive.registerAdapter(PublicMetricsAdapter());
  Hive.registerAdapter(ReferencedTweetAdapter());
  Hive.registerAdapter(DurationAdapter());
  Hive.registerAdapter(MediaTypeAdapter());
  Hive.registerAdapter(MediaAdapter());
  Hive.registerAdapter(NewsAdapter());
  final hiveboxes = HiveBoxes();
  await hiveboxes.initHiveUtils();
  await hiveboxes.initHiveUnread();
  Get.put(hiveboxes);
}
