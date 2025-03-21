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

String token = '';
String fcmToken = '';
int tempIosCheckForMakingItLiveGlobal = 1;
String myName = '';
String factoryAddress = '';
bool forIOS = false;
