import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/auth/facebook_auth.dart';
import 'package:insta_news_mobile/auth/google_auth.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Map<String, String>> constructHeaders() async {
  final shared = await SharedPreferences.getInstance();
  final provider = shared.getString('provider') ?? 'guest';
  String? token;
  if (provider == 'google') {
    token = await getIt<GoogleAuth>().getToken();
  } else if (provider == 'facebook') token = await getIt<FaceAuth>().getToken();

  return {
    'provider': provider,
    'Authorization': 'Bearer ' + (token ?? ''),
  };
}

Future<void> saveAuthProvider(String provider) async {
  final shared = await SharedPreferences.getInstance();
  await shared.setString('auth_provider', provider);
}

Future<void> htmlToast(String? msg) async {
  if (msg == null) return;
  await Fluttertoast.showToast(msg: msg);
}

Future<bool> isfirstTime() async {
  final shared = await SharedPreferences.getInstance();
  final result = shared.getBool('isFirstTime') ?? true;
  if (result) await shared.setBool('isFirstTime', false);
  return result;
}

//* caching
Future<Map<int, List<T>>> getCachedItems<T>() async {
  final box = await Hive.openBox(T.toString());
  final pageKey = (box.get('pageKey', defaultValue: 1) ?? 1) as int;
  final itemsList = box.get('cachedItems');
  final items = itemsList == null ? <T>[] : List<T>.from(itemsList);
  return {pageKey: items};
}

Future<void> setCachedItems<T>(int? pageKey, List<T> items) async {
  final isOpen = Hive.isBoxOpen(T.toString());
  if (!isOpen) return;
  final box = Hive.box(T.toString());
  final itemsList = box.get('cachedItems');
  final items = itemsList == null ? <T>[] : List<T>.from(itemsList);
  for (var item in items) {
    if (!itemsList.contains(item)) {
      itemsList.add(item);
    }
  }
  await box.put('pageKey', pageKey);
  await box.put('cachedItems', itemsList);
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
  if (await canLaunch(url)) {
    await launch(url);
  }
}
