import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:insta_news_mobile/d_injection.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

import 'app.dart';
import 'hooks/ads_hook.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.initialize();
  await initHive();
  initGet();
  runApp(const App());
}
