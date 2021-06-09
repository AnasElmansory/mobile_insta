import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/cubits/auth/auth_cubit.dart';
import 'package:insta_news_mobile/pages/auth_page.dart';
import 'package:insta_news_mobile/controllers/settings/language_controller.dart';
import 'package:insta_news_mobile/controllers/settings/notification_controller.dart';
import 'package:insta_news_mobile/utils/translations.dart';

import 'controllers/settings/font_controller.dart';
import 'controllers/source_follow_controller.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final language = Get.put(LanguageController());
    Get.put(NotificationController());
    Get.put(FontController());
    Get.put(SourceFollow());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: GetMaterialApp(
        translations: InstaTranslation(),
        locale: language.locale.value,
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          fontFamily: 'Helvetica',
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.blue[800],
          ),
        ),
        home: const AuthPage(),
      ),
    );
  }
}
