import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payhive/constants/string_constants.dart';
import 'package:payhive/modules/splash/cubit/splash_cubit.dart';
import 'package:payhive/modules/splash/view/splash.dart';
import 'package:payhive/utils/helper/hide_status_bar.dart';
import 'package:payhive/utils/helper/key_board_utils.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:get/get.dart';

class PayHive extends StatefulWidget {
  const PayHive({super.key});

  @override
  State<PayHive> createState() => _PayHiveState();
}

class _PayHiveState extends State<PayHive> {
  setHeightAndWidth(BuildContext context) {
    height = MediaQuery.sizeOf(context).width;
    width = MediaQuery.sizeOf(context).width;
  }

  @override
  Widget build(BuildContext context) {
    setHeightAndWidth(context);
    hideStatusBar();
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: theme,
        title: StringConstants.appName,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SplashCubit()),
          ],
          child: const Splash(),
        ),
      ),
    );
  }
}
