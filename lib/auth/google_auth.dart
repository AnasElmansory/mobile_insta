import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_news_mobile/auth/admin_verification.dart';
import 'package:insta_news_mobile/auth/guest_auth.dart';
import 'package:insta_news_mobile/auth/i_auth.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/utils/constants.dart';

class GoogleAuth extends IAuth {
  final GoogleSignIn _googleSignIn;
  final AdminVerification _adminVerification;

  const GoogleAuth(this._googleSignIn, this._adminVerification);

  @override
  Future<User> getCurrentUser() async {
    GoogleSignInAccount? account = _googleSignIn.currentUser;
    if (account == null) {
      account = await _googleSignIn.signInSilently();
      if (account == null) return User.guest();
    }

    final userId = await guestUserId();

    final user = User(
      id: userId ?? account.id,
      email: account.email,
      name: account.displayName,
      avatar: account.photoUrl,
      provider: 'google',
      permission: permissions.first,
    );
    final admin = await _adminVerification.getVerifiedAdmin(user);
    return user.copyWith(permission: admin?.permission);
  }

  @override
  Future<String?> getToken() async {
    late GoogleSignInAuthentication auth;
    final account = await _googleSignIn.signInSilently();
    if (account == null) return null;
    auth = await account.authentication;
    return auth.accessToken;
  }

  @override
  Future<User> signIn({bool? silently}) async {
    GoogleSignInAccount? account;
    account = await _googleSignIn.signIn();
    if (account == null) {
      await Fluttertoast.showToast(msg: GoogleSignIn.kSignInCanceledError);
      return User.guest();
    }
    final user = User(
      id: account.id,
      email: account.email,
      name: account.displayName,
      avatar: account.photoUrl,
      provider: 'google',
      permission: 'none',
    );
    final admin = await _adminVerification.getVerifiedAdmin(user);
    if (admin == null) {
      await Fluttertoast.showToast(msg: 'you don\'t have admin permission');
    }

    return user.copyWith(permission: admin?.permission);
  }

  @override
  Future<void> signOut() async => await _googleSignIn.signOut();

  @override
  Future<bool> isLoggedIn() async => await _googleSignIn.isSignedIn();
}
