import 'package:get/get.dart';

import '../modules/add_edit_chair/bindings/add_edit_chair_binding.dart';
import '../modules/add_edit_chair/views/add_edit_chair_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EDIT_CHAIR,
      page: () => AddEditChairView(),
      binding: AddEditChairBinding(),
    ),
  ];
}
