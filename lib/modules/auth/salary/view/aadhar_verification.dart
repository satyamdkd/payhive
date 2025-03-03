import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/view/aadhar_details.dart';
import 'package:payhive/modules/auth/salary/view/aadhar_otp.dart';
import 'package:payhive/modules/auth/salary/view/otp.dart';
import 'package:payhive/modules/auth/salary/view/pan_details.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

class AadharVerificationSalaried extends StatefulWidget {
  const AadharVerificationSalaried({super.key});

  @override
  State<AadharVerificationSalaried> createState() =>
      _AadharVerificationSalariedState();
}

class _AadharVerificationSalariedState
    extends State<AadharVerificationSalaried> {
  @override
  void initState() {
    super.initState();
  }

  bool isAadharOTPScreen = false;

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
                text(),
                spacer(),
                isAadharOTPScreen ? otpAadhar(context) : aadhar(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Spacer spacer() => const Spacer();

  bool isTermChecked = false;

  Container aadhar(BuildContext context) {
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
                customTextField(
                  textEditingController: TextEditingController(),
                  title: "",
                  fullTag: "Aadhar Number",
                  keyboardType: TextInputType.phone,
                ),
                spacing(passedHeight: height / 40),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "OTP will be sent to your Aadhaar-linked mobile",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: const Color(0xff222222),
                              fontSize: height / 30,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spacer(),
                customButton(
                    title: "Send OTP",
                    context: context,
                    onTap: () {
                      setState(() {
                        isAadharOTPScreen = true;
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

  Container text() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: width / 20,
        left: width / 20,
        right: width / 20,
      ),
      child: Text(
        "Enter Your\nAadhar Number",
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
