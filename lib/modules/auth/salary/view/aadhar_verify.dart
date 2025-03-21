import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/controller/salaried_controller.dart';
import 'package:flutter/material.dart';
import 'package:payhive/utils/helper/form_validation.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pinput/pinput.dart';

class AadharVerifySalaried extends GetView<SalariedController> {
  AadharVerifySalaried({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColors.primaryColor,
      body: body(context),
    );
  }

  SafeArea body(BuildContext context) {
    return SafeArea(
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
              aadhar(context)
            ],
          ),
        ),
      ),
    );
  }

  Spacer spacer() => const Spacer();

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
            child: Form(
              key: controller.formKeyAadhar,
              child: Column(
                children: [
                  spacing(),
                  customTextField(
                    textEditingController: controller.aadharController,
                    title: "",
                    validator: (value) => FormValidation.aadharValidator(
                      controller.aadharController.text,
                    ),
                    fullTag: "Please enter aadhar number",
                    keyboardType: TextInputType.number,
                    suffixIcon: controller.isOTPShotAadhar.value
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
                              onTap: () {},
                            ),
                          )
                        : null,
                  ),
                  spacing(passedHeight: height / 80),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: width / 80),
                    child: Text(
                      "OTP will be sent to your Aadhaar-linked mobile",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: appColors.textDark,
                        fontSize: height / 36,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  spacing(passedHeight: height / 20),
                  SizedBox(height: height / 100),
                  if (controller.isOTPShotAadhar.value)
                    Column(
                      children: [
                        spacing(passedHeight: height / 80),
                        Center(
                          child: Pinput(
                            controller: controller.aadharOTP,
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
                                color: appColors.primaryColor,
                                width: 1.0,
                              ),
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

                        /// Text(
                        ///   "00:53",
                        ///   style: theme.textTheme.labelLarge?.copyWith(
                        ///     color: appColors.textLight,
                        ///     fontWeight: FontWeight.w400,
                        ///     fontSize: height / 20,
                        ///   ),
                        /// ),

                        spacing(passedHeight: height / 60),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Resend code",
                            style: theme.textTheme.labelLarge?.copyWith(
                                color: appColors.textLight,
                                fontWeight: FontWeight.w300,
                                fontSize: height / 32,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  spacer(),
                  customButton(
                      title: "Continue",
                      context: context,
                      onTap: () {
                        controller.validateAadharForm();
                      }),
                  spacing(passedHeight: height / 8),
                ],
              ),
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

  Container aadharDetails(BuildContext context) {
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
                spacing(passedHeight: height / 9),
                Image.asset(
                  "assets/icons/successmark.png",
                  height: height / 8,
                ),
                spacing(passedHeight: height / 90),
                Text(
                  "Aadhar Verified",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: appColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: height / 22,
                  ),
                ),
                spacing(passedHeight: height / 20),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width / 2.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: appColors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w200,
                                fontSize: height / 26,
                              ),
                            ),
                            Text(
                              controller.aadharDetails!['name'] ?? '',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: appColors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w300,
                                fontSize: height / 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                spacing(passedHeight: height / 20),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width / 2.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: appColors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w200,
                                fontSize: height / 26,
                              ),
                            ),
                            Text(
                              controller.aadharDetails!['gender'] ?? '',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: appColors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w300,
                                fontSize: height / 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width / 2.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date Of Birth",
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: appColors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w200,
                                fontSize: height / 26,
                              ),
                            ),
                            Text(
                              controller.aadharDetails!['dateOfBirth'] ?? '',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: appColors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w300,
                                fontSize: height / 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                spacing(passedHeight: height / 20),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width / 1.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address",
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: appColors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w200,
                                fontSize: height / 26,
                              ),
                            ),
                            Text(
                              controller.aadharDetails!['address'] ?? '',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: appColors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w300,
                                fontSize: height / 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                spacer(),
                customButton(title: "Continue", context: context, onTap: () {}),
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
