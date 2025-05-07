import 'package:get/get.dart';
import 'package:payhive/modules/address/binding/address_binding.dart';
import 'package:payhive/modules/address/view/address_details.dart';
import 'package:payhive/modules/auth/salary/binding/salary_binding.dart';
import 'package:payhive/modules/auth/salary/view/login_reg_phone.dart';
import 'package:payhive/modules/bank/binding/bank_binding.dart';
import 'package:payhive/modules/bank/view/bank_details.dart';
import 'package:payhive/modules/dashboard/binding/dashboard_binding.dart';
import 'package:payhive/modules/dashboard/view/dashboard.dart';
import 'package:payhive/modules/list_pos_req/binding/binding.dart';
import 'package:payhive/modules/list_pos_req/view/list_pos_request.dart';
import 'package:payhive/modules/pay_vendor/binding/vendor_pay_binding.dart';
import 'package:payhive/modules/pay_vendor/view/vendor_pay.dart';
import 'package:payhive/modules/personal_details/binding/personal_detail_binding.dart';
import 'package:payhive/modules/personal_details/view/personal_details.dart';
import 'package:payhive/modules/pos/binding/binding.dart';
import 'package:payhive/modules/pos/view/pos_request.dart';
import 'package:payhive/modules/splash/binding/splash_binding.dart';
import 'package:payhive/modules/splash/view/splash.dart';
import 'package:payhive/modules/wallet_history/binding/wallet_history_binding.dart';
import 'package:payhive/modules/wallet_history/view/wallet_history.dart';

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
      page: () => const LoginRegViaPhone(),
      binding: SalaryBinding(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const Dashboard(),
      binding: DashBoardBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.bankDetail,
      page: () => const BankDetailsPage(),
      binding: BankBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.addAddress,
      page: () => const AddressPage(),
      binding: AddressBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.personalDetails,
      page: () => const PersonalDetails(),
      binding: PersonalDetailBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.posRequest,
      page: () => const PosRequest(),
      binding: PosBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.listPosRequest,
      page: () => const ListPosRequest(),
      binding: ListPosBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.vendorPay,
      page: () => const VendorPaymentScreen(),
      binding: VendorPayBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.walletHistory,
      page: () => const WalletHistoryScreen(),
      binding: WalletHistoryBinding(),
      transition: Transition.leftToRight,
    ),
  ];
}
