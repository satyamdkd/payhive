import 'package:flutter/material.dart';
import 'package:payhive/modules/auth/salary/view/otp.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

class Salaried extends StatefulWidget {
  const Salaried({super.key});

  @override
  State<Salaried> createState() => _SalariedState();
}

class _SalariedState extends State<Salaried> {
  @override
  void initState() {
    super.initState();
  }

  bool isOTPScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColors.primaryColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: height / 100),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                progress(),
                spacing(passedHeight: height / 7),
                welcomeText(),
                spacer(),
                isOTPScreen ? otp(context) : mobile(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Spacer spacer() => const Spacer();

  bool isTermChecked = false;

  Container mobile(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 1.35,
      width: width,
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(height / 16),
          topLeft: Radius.circular(height / 16),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width / 20, right: width / 20),
            child: Column(
              children: [
                spacing(),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: width / 80),
                  child: Text(
                    "Enter your aadhar linked mobile number.",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: appColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                spacing(passedHeight: height / 60),
                customTextField(
                  textEditingController: TextEditingController(),
                  title: "phone",
                  keyboardType: TextInputType.phone,
                ),
                spacing(passedHeight: height / 60),
                spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Use a Referral Code",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: appColors.textDark,
                        fontWeight: FontWeight.w400,
                        fontSize: height / 36,
                      ),
                    ),
                  ),
                ),
                spacing(passedHeight: height / 36),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Image.asset(
                          isTermChecked
                              ? "assets/icons/checkbox.png"
                              : "assets/icons/blank_checkbox.png",
                          height: height / 22,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: width / 60),
                        Row(
                          children: [
                            Text(
                              "I accept the terms & conditions and privacy policy",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: const Color(0xff222222),
                                fontSize: height / 40,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                spacing(passedHeight: height / 60),
                customButton(
                    title: "Next",
                    context: context,
                    onTap: () {
                      setState(() {
                        isOTPScreen = true;
                      });
                    }),
                spacing(passedHeight: height / 8),
              ],
            ),
          ),
          Positioned(
            bottom: -height / 8,
            child: IgnorePointer(
              ignoring: true,
              child: Image.asset(
                "assets/images/home_flare.png",
                width: width,
                height: height / 1.75,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container welcomeText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: width / 20,
        left: width / 20,
        right: width / 20,
      ),
      child: Text(
        isOTPScreen
            ? "Enter the OTP"
            : "Welcome to Pay Hive.\nLet’s get you started",
        style: theme.textTheme.headlineSmall
            ?.copyWith(color: appColors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  SizedBox spacing({passedHeight}) =>
      SizedBox(height: passedHeight ?? height / 20);

  LinearPercentIndicator progress() {
    return LinearPercentIndicator(
      width: width,
      animation: true,
      animationDuration: 2000,
      padding: EdgeInsets.zero,
      lineHeight: height / 100,
      percent: 0.5,
      backgroundColor: appColors.primaryExtraLight,
      progressColor: appColors.green,
    );
  }
}
