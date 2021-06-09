import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class VersionController extends GetxController {
  RxString version = ''.obs;

  Future<void> getApplicationVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  @override
  void onInit() async {
    super.onInit();
    await getApplicationVersion();
  }
}
