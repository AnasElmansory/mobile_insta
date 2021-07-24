import 'package:insta_news_mobile/models/user.dart';

abstract class IAuth {
  Future<User> signIn();
  Future<void> signOut();
  Future<String?> getToken();
  Future<User> getCurrentUser();
  Future<bool> isLoggedIn();
  const IAuth();
}
