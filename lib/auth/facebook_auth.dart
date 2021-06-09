import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:insta_news_mobile/auth/admin_verification.dart';
import 'package:insta_news_mobile/auth/i_auth.dart';
import 'package:insta_news_mobile/models/user.dart';

class FaceAuth extends IAuth {
  final _facebookAuth = FacebookAuth.instance;
  final _adminVerification = AdminVerification();
  @override
  Future<User?> getCurrentUser() async {
    if (!await isLoggedIn()) return null;
    final facebookUser = await _facebookAuth.getUserData();
    final user = User(
      id: facebookUser['id'],
      name: facebookUser['name'],
      email: facebookUser['email'],
      avatar: facebookUser['picture']["data"]['url'],
      provider: 'facebook',
      permission: 'none',
    );
    final admin = await _adminVerification.getVerifiedAdmin(user);
    return user.copyWith(permission: admin?.permission);
  }

  @override
  Future<String?> getToken() async {
    final accessToken = await _facebookAuth.accessToken;
    return accessToken!.token;
  }

  @override
  Future<bool> isLoggedIn() async {
    final accessToken = await _facebookAuth.accessToken;
    return (accessToken == null) ? false : true;
  }

  @override
  Future<User?> signIn() async {
    final result = await _facebookAuth.login();
    if (result.status == LoginStatus.cancelled ||
        result.status == LoginStatus.failed) {
      await Fluttertoast.showToast(msg: result.message!);
      return null;
    }
    final facebookUser = await _facebookAuth.getUserData();

    final user = User(
      id: facebookUser['id'],
      name: facebookUser['name'],
      email: facebookUser['email'],
      avatar: facebookUser['picture']["data"]['url'],
      provider: 'facebook',
      permission: 'none',
    );
    final admin = await _adminVerification.getVerifiedAdmin(user);
    if (admin == null) {
      await Fluttertoast.showToast(msg: 'you don\'t have admin permission');
    }
    return user.copyWith(permission: admin?.permission);
  }

  @override
  Future<void> signOut() async => await _facebookAuth.logOut();
}
