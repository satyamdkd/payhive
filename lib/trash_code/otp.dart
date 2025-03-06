import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/view/user_type.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:pinput/pinput.dart';

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
Container otp(BuildContext context) {
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
              spacing(passedHeight: height / 20),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: width / 80),
                child: Text(
                  "OTP code has been sent to +9855665525\nenter the code below to continue.",
                  style: theme.textTheme.labelLarge?.copyWith(
                      color: appColors.textDark,
                      fontWeight: FontWeight.w400,
                      fontSize: height / 28),
                ),
              ),
              spacing(passedHeight: height / 20),
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
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  length: 6,
                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                    border:
                        Border.all(color: appColors.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration?.copyWith(
                      color: const Color.fromRGBO(234, 239, 243, 1),
                    ),
                  ),
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
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
              spacing(passedHeight: height / 60),
              spacer(),
              customButton(
                  title: "Continue",
                  context: context,
                  onTap: () {
                    Get.to(() => const UserType());
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
