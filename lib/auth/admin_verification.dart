import 'package:insta_news_mobile/api/admin_service.dart';
import 'package:insta_news_mobile/models/user.dart';

import '../d_injection.dart';

class AdminVerification {
  final _adminService = getIt<AdminService>();
  Future<bool> verifyAdmin(User user) async {
    final isAdmin = await _adminService.checkAdminPermission(user.id);
    return isAdmin;
  }

  Future<User?> getVerifiedAdmin(User user) async {
    final admin = await _adminService.getAdmin(user.id);
    return admin;
  }
}
