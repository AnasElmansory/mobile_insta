import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insta_news_mobile/api/user_prefernces_service.dart';
import 'package:insta_news_mobile/api/users_service.dart';
import 'package:insta_news_mobile/auth/facebook_auth.dart';
import 'package:insta_news_mobile/auth/google_auth.dart';
import 'package:insta_news_mobile/auth/guest_auth.dart';
import 'package:insta_news_mobile/auth/i_auth.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/extentions.dart';

import '../d_injection.dart';

class AuthController extends GetxController {
  final Rx<User> _user = User.guest().obs;
  final _usersService = getIt<UsersService>();
  final _userPreferencesService = getIt<UserPreferencesService>();
  late IAuth _iAuth;

  User get user => _user.value;

  Future<void> signInWithGoogle() async {
    _iAuth = getIt<GoogleAuth>();
    final user = await _iAuth.signIn();
    if (!user.isGuest) await saveAuthProvider('google');
    _user.value = user;
    await saveUserData(user);
    await _userPreferencesService.saveUserFavorites();
    await _userPreferencesService.saveUserFollow();
  }

  Future<void> signInWithFacebook() async {
    _iAuth = getIt<FaceAuth>();
    final user = await _iAuth.signIn();
    if (!user.isGuest) await saveAuthProvider('facebook');
    _user.value = user;
    await saveUserData(user);
    await _userPreferencesService.saveUserFavorites();
    await _userPreferencesService.saveUserFollow();
  }

  Future<void> getUser() async {
    final authBox = await Hive.openBox('auth_box');
    final provider =
        authBox.get('auth_provider', defaultValue: 'guest') as String;
    if (provider == 'google') {
      _iAuth = getIt<GoogleAuth>();
    } else if (provider == 'facebook') {
      _iAuth = getIt<FaceAuth>();
    } else {
      _iAuth = getIt<GuestAuth>();
    }
    _user.value = await _iAuth.getCurrentUser();
  }

  Future<bool> isLoggedIn() async {
    final authBox = await Hive.openBox('auth_box');
    final provider =
        authBox.get('auth_provider', defaultValue: 'guest') as String;
    if (provider == 'google') {
      _iAuth = getIt<GoogleAuth>();
    } else if (provider == 'facebook') {
      _iAuth = getIt<FaceAuth>();
    } else {
      _iAuth = getIt<GuestAuth>();
    }
    return await _iAuth.isLoggedIn();
  }

  Future<void> signOut() async {
    await saveAuthProvider('guest');
    await _iAuth.signOut();
    final userId = await guestUserId();
    _user.value = User.guest().copyWith(id: userId);
  }

  Future<void> saveUserData(User user) async =>
      await _usersService.saveUser(user);
}
