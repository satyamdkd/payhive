import 'package:payhive/utils/helper/shared_pref.dart';
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

setUpDi() async {
  locator.registerSingleton<SharedPref>(SharedPref());
}

final sharedPref = locator.get<SharedPref>();

String token = '';
String fcmToken = '';
int tempIosCheckForMakingItLiveGlobal = 1;
String myName = '';
String factoryAddress = '';
bool forIOS = false;
