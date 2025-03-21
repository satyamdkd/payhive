import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/controller/salaried_controller.dart';
import 'package:payhive/modules/auth/salary/view/email_verification.dart';
import 'package:payhive/utils/helper/form_validation.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/snackbar.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pinput/pinput.dart';

class LoginRegViaPhone extends GetView<SalariedController> {
  LoginRegViaPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appColors.primaryColor,
        body: body(context));
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
              if (controller.isLoginScreenDisabled.value)
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: width / 20, top: width / 20),
                  child: Container(
                    height: height / 12,
                    width: height / 4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width / 100),
                      border: Border.all(
                        color: appColors.white,
                        width: 0.4,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.offAll(EmailVerification(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Next ",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: appColors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: height / 25,
                            color: appColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              IgnorePointer(
                ignoring: controller.isLoginScreenDisabled.value,
                child: Column(
                  children: [
                    spacing(
                        passedHeight: controller.isLoginScreenDisabled.value
                            ? height / 24
                            : height / 5.7),
                    welcomeText(),
                    mobile(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Spacer spacer() => const Spacer();

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
            child: GetBuilder<SalariedController>(
                init: controller,
                builder: (cxt) {
                  return Form(
                    key: controller.formKeyLogin,
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
                          textEditingController: controller.mobileController,
                          title: "phone number",
                          validator: (value) => FormValidation.phoneValidator(
                            controller.mobileController.text,
                          ),
                          readOnly: !controller.isEditingPhone.value,
                          keyboardType: TextInputType.phone,
                          suffixIcon: controller.isPhoneLoading.value
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: height / 30,
                                    horizontal: width / 30,
                                  ),
                                  child: CupertinoActivityIndicator(
                                    color: appColors.primaryLight,
                                  ),
                                )
                              : controller.isOTPShotPhone.value
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
                                          controller.isOTPShotPhone.value =
                                              false;
                                          controller.isEditingPhone.value =
                                              true;
                                          controller.update();
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
                        if (controller.isOTPShotPhone.value &&
                            !controller.isPhoneLoading.value &&
                            !controller.isEditingPhone.value)
                          Column(
                            children: [
                              spacing(passedHeight: height / 20),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: width / 80),
                                child: Text(
                                  "OTP code has been sent to +91 ${controller.mobileController.text} enter the code below to continue.",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: appColors.textDark,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              spacing(passedHeight: height / 60),
                              Center(
                                child: Pinput(
                                  controller: controller.otpControllerPhone,
                                  defaultPinTheme: PinTheme(
                                    width: height / 7.5,
                                    height: height / 7.5,
                                    textStyle: TextStyle(
                                        fontSize: height / 16,
                                        color:
                                            const Color.fromRGBO(30, 60, 87, 1),
                                        fontWeight: FontWeight.w600),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  length: 6,
                                  focusedPinTheme:
                                      defaultPinTheme.copyDecorationWith(
                                    border: Border.all(
                                        color: appColors.primaryColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration?.copyWith(
                                      color: const Color.fromRGBO(
                                          234, 239, 243, 1),
                                    ),
                                  ),
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  showCursor: true,
                                  onChanged: (pin) {},
                                  onCompleted: (pin) {},
                                ),
                              ),

                              /// spacing(passedHeight: height / 40),
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
                                onTap: () {
                                  controller.otpControllerPhone.clear();
                                  controller.update();
                                  controller.salariedAPI(step: '1');
                                },
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

                        /// Padding(
                        ///   padding: const EdgeInsets.only(left: 3.0),
                        ///   child: Container(
                        ///     alignment: Alignment.centerLeft,
                        ///     child: Text(
                        ///       "Use a Referral Code",
                        ///       style: theme.textTheme.labelLarge?.copyWith(
                        ///         color: appColors.textDark,
                        ///         fontWeight: FontWeight.w400,
                        ///         fontSize: height / 36,
                        ///       ),
                        ///     ),
                        ///   ),
                        /// ),
                        /// spacing(passedHeight: height / 36),

                        if (!controller.isPhoneOTPSubmitLoading.value)
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: InkWell(
                              onTap: () {
                                controller.termChecked();
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    controller.isTermChecked.value
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
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
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
                        spacing(passedHeight: height / 50),

                        !controller.isPhoneOTPSubmitLoading.value
                            ? customButton(
                                title: controller.isOTPShotPhone.value
                                    ? "Submit"
                                    : "Verify",
                                context: context,
                                onTap: () {
                                  if (controller.isOTPShotPhone.value) {
                                    if (controller
                                            .otpControllerPhone.text.length <
                                        6) {
                                      showSnackBar(
                                          message: "OTP must be of 6 digits",
                                          title: "PayHive");
                                    } else {
                                      controller.salariedAPI(step: '2');
                                    }
                                  } else {
                                    controller.validatePhoneForm();
                                  }
                                },
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: height / 30,
                                  horizontal: width / 30,
                                ),
                                child: CupertinoActivityIndicator(
                                  color: appColors.primaryLight,
                                  radius: height / 20,
                                ),
                              ),
                        spacing(passedHeight: height / 8),
                      ],
                    ),
                  );
                }),
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
        "Welcome to Pay Hive.\nLet’s get started",
        style: theme.textTheme.headlineSmall?.copyWith(
          color: appColors.white,
          fontWeight: FontWeight.w600,
        ),
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
