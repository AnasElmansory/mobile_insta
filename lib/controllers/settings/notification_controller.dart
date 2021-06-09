import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  Rx<NotificationStatus> notificationStatus = NotificationStatus.active.obs;

  Future<void> setNotificitionStatus(NotificationStatus status) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setInt('notification', notificationStatus.value.index);
    notificationStatus.value = status;
    // todo: toggle off notification from api
  }

  Future<void> getNotifciationStatus() async {
    final shared = await SharedPreferences.getInstance();
    final index = shared.getInt('notification') ?? 1;
    notificationStatus.value = NotificationStatus.values[index];
  }

  @override
  void onInit() async {
    super.onInit();
    await getNotifciationStatus();
  }
}

enum NotificationStatus {
  active,
  inActive,
}
