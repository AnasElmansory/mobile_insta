import "package:flutter/material.dart";
import 'package:insta_news_mobile/d_injection.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  initGet();
  runApp(const App());
}
