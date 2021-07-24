import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:insta_news_mobile/d_injection.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initHive();
  initGet();
  runApp(const App());
}
