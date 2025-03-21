import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/camera/face_detector_view.dart';
import 'package:payhive/modules/auth/salary/view/annual_income.dart';
import 'package:payhive/routes/pages.dart';
import 'package:payhive/services/di/di.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  navigate() async {
    Timer(const Duration(milliseconds: 2800), () async {
      var userMap = await sharedPref.getUser();

      debugPrint(userMap.toString());
      if (userMap != null && userMap.toString() != "null") {
        if (jsonDecode(userMap)['id'] != null &&
            jsonDecode(userMap)['id'].toString() != "") {
          Get.offAllNamed(Routes.dashboard);
        }
      } else {
        if (await sharedPref.getTempMobile() == null) {
          Get.to(()=>SalariedAnnualIncome());
         /// Get.offAllNamed(Routes.salaryReg);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: appColors.white,
              borderRadius: BorderRadius.circular(1000.0),
            ),
            padding: const EdgeInsets.all(25),
            child: SizedBox(
              height: height / 3.2,
              width: height / 3.2,
              child: Image.asset(
                "assets/icons/logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ).animate().fade(duration: 500.ms).scale(delay: 600.ms),
      ),
    );
  }
}
