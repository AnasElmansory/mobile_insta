import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/auth/facebook_auth.dart';
import 'package:insta_news_mobile/auth/google_auth.dart';
import 'package:insta_news_mobile/controllers/news/hive_boxes_controller.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

Future<Map<String, String>> constructHeaders({String? userId}) async {
  final authBox = await Hive.openBox('auth_box');
  final provider = authBox.get('auth_provider', defaultValue: 'guest');
  String? token;
  if (provider == 'google') {
    token = await getIt<GoogleAuth>().getToken();
  } else if (provider == 'facebook') token = await getIt<FaceAuth>().getToken();
  return {
    'provider': provider,
    'Authorization': 'Bearer ' + (token ?? userId ?? provider),
  };
}

Future<void> saveAuthProvider(String provider) async {
  final authBox = await Hive.openBox('auth_box');
  await authBox.put('auth_provider', provider);
}

Future<bool> isfirstTime() async {
  final utilBox = Get.find<HiveBoxes>().utilBox;
  final result = utilBox.get('isFirstTime', defaultValue: true) as bool;
  if (result) await utilBox.put('isFirstTime', false);
  return result;
}

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

Future<void> openUrl(String url) async {
  if (await makeSureConnected()) {
    await navigateToWebViewPage(url);
  } else {
    return;
  }
}

Future<bool> makeSureConnected() async {
  if (!await isConnected()) {
    await Get.showSnackbar(GetBar(
      message: 'please, Check Your Internet Connection!',
    ));
    return false;
  } else {
    return true;
  }
}
