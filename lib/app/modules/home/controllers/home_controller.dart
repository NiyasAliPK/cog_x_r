import 'package:get/get.dart';

class HomeController extends GetxController {
  int pageIndex = 0;
  changeIndex(value) {
    pageIndex = value;
    update();
  }
}
