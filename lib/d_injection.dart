import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
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

final getIt = GetIt.instance;

void initGet() {
  getIt.registerLazySingleton<FaceAuth>(() => FaceAuth());
  getIt.registerLazySingleton<GoogleAuth>(() => GoogleAuth());
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
  getIt.registerLazySingleton<Dio>(() => Dio());
}

Future<void> initHive() async {
  final dir = await getTemporaryDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(SourceAdapter());
  Hive.registerAdapter(CountryAdapter());
}
