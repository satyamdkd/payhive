import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/binding/salary_binding.dart';
import 'package:payhive/modules/auth/salary/view/login_reg_phone.dart';
import 'package:payhive/modules/dashboard/binding/dashboard_binding.dart';
import 'package:payhive/modules/dashboard/view/dashboard.dart';
import 'package:payhive/modules/splash/binding/splash_binding.dart';
import 'package:payhive/modules/splash/view/splash.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const Splash(),
      binding: SplashBinding(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.salaryReg,
      page: () => LoginRegViaPhone(),
      binding: SalaryBinding(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const Dashboard(),
      binding: DashBoardBinding(),
      transition: Transition.leftToRight,
    ),
  ];
}
