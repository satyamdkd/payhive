part of 'pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const splash = _Paths.splash;
  static const salaryReg = _Paths.salaryReg;
  static const dashboard = _Paths.dashboard;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const splash = '/splash';
  static const salaryReg = '/salaryReg';
  static const dashboard = '/dashboard';

}
