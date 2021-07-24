import 'package:get/get.dart';

class SourceTabController extends GetxController {
  final RxInt _index = 1.obs;
  int get index => _index.value;
  set index(int value) => _index.value = value;
}
