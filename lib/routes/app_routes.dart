part of 'pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const splash = _Paths.splash;
  static const salaryReg = _Paths.salaryReg;
  static const dashboard = _Paths.dashboard;
  static const bankDetail = _Paths.bankDetail;
  static const addAddress = _Paths.addAddress;
  static const personalDetails = _Paths.personalDetails;
  static const posRequest = _Paths.posRequest;
  static const listPosRequest = _Paths.listPosRequest;
  static const vendorPay = _Paths.vendorPay;
  static const walletHistory = _Paths.walletHistory;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const splash = '/splash';
  static const salaryReg = '/salaryReg';
  static const dashboard = '/dashboard';
  static const bankDetail = '/bankDetail';
  static const addAddress = '/addAddress';
  static const personalDetails = '/personalDetails';
  static const posRequest = '/posRequest';
  static const listPosRequest = '/listPosRequest';
  static const vendorPay = '/vendorPay';
  static const walletHistory = '/walletHistory';
}
