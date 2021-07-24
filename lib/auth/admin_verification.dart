import 'package:insta_news_mobile/api/admin_service.dart';
import 'package:insta_news_mobile/models/user.dart';

class AdminVerification {
  final AdminService _adminService;
  // final _adminService = getIt<AdminService>();
  const AdminVerification(this._adminService);
  Future<bool> verifyAdmin(User user) async {
    final isAdmin = await _adminService.checkAdminPermission(user.id);
    return isAdmin;
  }

  Future<User?> getVerifiedAdmin(User user) async {
    final admin = await _adminService.getAdmin(user.id);
    return admin;
  }
}
