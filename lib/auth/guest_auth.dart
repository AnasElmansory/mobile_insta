import 'package:hive/hive.dart';
import 'package:insta_news_mobile/auth/i_auth.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/api/users_service.dart';

class GuestAuth extends IAuth {
  final UsersService usersService;
  const GuestAuth(this.usersService);

  @override
  Future<User> getCurrentUser() async {
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId')!;
    final user = User.guest();
    return user.copyWith(id: userId);
  }

  @override
  Future<String?> getToken() async => '';

  @override
  Future<bool> isLoggedIn() async {
    final guestBox = await Hive.openBox('guest');
    final isLogged = guestBox.get('isLoggedIn', defaultValue: true) as bool;
    final userId = guestBox.get('userId');
    if (userId == null) {
      await guestBox.put('userId', User.guest().id);
    }
    return isLogged;
  }

  @override
  Future<User> signIn() async {
    //? assuming isloggedin is called first;
    final guestBox = Hive.box('guest');
    final userId = guestBox.get('userId');
    final user = User.guest();
    if (userId != null) {
      return user.copyWith(id: userId);
    } else {
      await guestBox.put('userId', user.id);
      return user;
    }
  }

  @override
  Future<void> signOut() async {
    final guestBox = Hive.box('guest');
    await guestBox.clear();
  }
}

Future<String?> guestUserId() async {
  final guestBox = await Hive.openBox('guest');
  final userId = guestBox.get('useId');
  return userId;
}
