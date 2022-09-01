import 'package:get/get.dart';

import 'package:cog_x_r/app/modules/add/bindings/add_binding.dart';
import 'package:cog_x_r/app/modules/add/views/add_view.dart';
import 'package:cog_x_r/app/modules/home/bindings/home_binding.dart';
import 'package:cog_x_r/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD,
      page: () => AddView(),
      binding: AddBinding(),
    ),
  ];
}
