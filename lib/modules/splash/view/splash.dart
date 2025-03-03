import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/view/aadhar_details.dart';
import 'package:payhive/modules/auth/salary/view/complete_your_kyc.dart';
import 'package:payhive/modules/auth/salary/view/lets_verify_id.dart';
import 'package:payhive/modules/auth/salary/view/pan_details.dart';
import 'package:payhive/modules/auth/salary/view/pan_verification.dart';
import 'package:payhive/modules/auth/salary/view/salaried.dart';
import 'package:payhive/modules/auth/salary/view/salaried_annual_income.dart';
import 'package:payhive/modules/auth/salary/view/user_type.dart';
import 'package:payhive/modules/dashboard/view/dashboard.dart';
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

      if (userMap != null && userMap.toString() != "null") {
        if (jsonDecode(userMap)['user']['id'] != null &&
            jsonDecode(userMap)['user']['id'].toString() != "") {
          Get.off(() => const Salaried());
        }
      } else {
        Get.off(() => const Salaried());
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
