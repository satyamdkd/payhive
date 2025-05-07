import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/controller/salaried_controller.dart';
import 'package:payhive/utils/helper/shared_pref.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

setUpDi() async {
  locator.registerSingleton<SharedPref>(SharedPref());
  locator.registerSingleton<SalariedController>(Get.put(SalariedController()));
}

final sharedPref = locator.get<SharedPref>();
final salariedController = locator.get<SalariedController>();

String userName = '';
String phoneNumber = '';
String userEmail = '';
String token = '';
String fcmToken = '';
String marginPerTransaction = '15.0';

bool forIOS = false;
