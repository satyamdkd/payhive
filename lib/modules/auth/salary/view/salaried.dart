import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/view/user_type.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:pinput/pinput.dart';

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
                mobile(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Spacer spacer() => const Spacer();

  bool isOTPScreen = false;
  bool isTermChecked = false;
  bool editNumber = false;

  final defaultPinTheme = PinTheme(
    width: height / 7.5,
    height: height / 7.5,
    textStyle: TextStyle(
        fontSize: height / 16,
        color: const Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  TextEditingController phoneNumber = TextEditingController();
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
                  textEditingController: phoneNumber,
                  title: "phone",
                  readOnly: isOTPScreen,
                  keyboardType: TextInputType.phone,
                  suffixIcon: isOTPScreen
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            vertical: height / 30,
                            horizontal: width / 30,
                          ),
                          child: customButton(
                            passedHeight: height / 14,
                            passedWidth: width / 5.8,
                            title: "Change",
                            context: context,
                            onTap: () {
                              setState(() {
                                isOTPScreen = false;
                              });
                            },
                          ),
                        )
                      : null,
                ),
                spacing(passedHeight: height / 20),
                Image.asset(
                  "assets/images/payments_icons.png",
                  width: width / 1.2,
                ),
                if (isOTPScreen)
                  Column(
                    children: [
                      spacing(passedHeight: height / 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: width / 80),
                        child: Text(
                          "OTP code has been sent to +91 8556655255 enter the code below to continue.",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: appColors.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      spacing(passedHeight: height / 60),
                      Center(
                        child: Pinput(
                          controller: TextEditingController(),
                          defaultPinTheme: PinTheme(
                            width: height / 7.5,
                            height: height / 7.5,
                            textStyle: TextStyle(
                                fontSize: height / 16,
                                color: const Color.fromRGBO(30, 60, 87, 1),
                                fontWeight: FontWeight.w600),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1.0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          length: 6,
                          focusedPinTheme: defaultPinTheme.copyDecorationWith(
                            border: Border.all(
                                color: appColors.primaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration?.copyWith(
                              color: const Color.fromRGBO(234, 239, 243, 1),
                            ),
                          ),
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onChanged: (pin) {},
                          onCompleted: (pin) {},
                        ),
                      ),
                      spacing(passedHeight: height / 40),
                      Text(
                        "00:53",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: appColors.textLight,
                          fontWeight: FontWeight.w400,
                          fontSize: height / 20,
                        ),
                      ),
                      spacing(passedHeight: height / 60),
                      Text(
                        "Resend code",
                        style: theme.textTheme.labelLarge?.copyWith(
                            color: appColors.textLight,
                            fontWeight: FontWeight.w300,
                            fontSize: height / 32,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
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
                  title: isOTPScreen ? "Next" : "Verify",
                  context: context,
                  onTap: () {
                    if (isOTPScreen) {
                      Get.to(() => const UserType());
                    } else {
                      setState(() {
                        isOTPScreen = true;
                      });
                    }
                  },
                ),
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
        "Welcome to Pay Hive.\nLet’s get you started",
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
