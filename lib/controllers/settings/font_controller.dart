import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontController extends GetxController {
  final Rx<InstaFontSize> _instaFontSize = InstaFontSize.medium.obs;
  InstaFontSize get instaSize => _instaFontSize.value;

  Future<void> changeFontSize(InstaFontSize size) async {
    _instaFontSize.value = size;
  }

  Future<void> getFontSize() async {
    final shared = await SharedPreferences.getInstance();
    final index = shared.getInt('font_size') ?? 1;
    _instaFontSize.value = InstaFontSize.values[index];
  }

  @override
  void onInit() async {
    await getFontSize();
    super.onInit();
  }

  @override
  void onClose() async {
    final shared = await SharedPreferences.getInstance();
    await shared.setInt('font_size', _instaFontSize.value.index);
    super.onClose();
  }
}

enum InstaFontSize {
  small,
  medium,
  large,
}
