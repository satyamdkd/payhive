import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/camera/face_detector_view.dart';
import 'package:payhive/modules/auth/salary/view/success.dart';
import 'package:payhive/services/di/di.dart';
import 'package:payhive/trash_code/otp.dart';
import 'package:payhive/modules/dashboard/view/dashboard.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VerifyAndSubmit extends StatefulWidget {
  const VerifyAndSubmit({super.key, required this.imagePath});
  final String imagePath;
  @override
  State<VerifyAndSubmit> createState() => _VerifyAndSubmitState();
}

class _VerifyAndSubmitState extends State<VerifyAndSubmit> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (v, t) {
        Get.to(() => const FaceDetectorView());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appColors.primaryColor,
        body: body(),
      ),
    );
  }

  LinearPercentIndicator progress() {
    return LinearPercentIndicator(
      width: width,
      animation: true,
      animationDuration: 2000,
      padding: EdgeInsets.zero,
      lineHeight: height / 100,
      percent: 1,
      backgroundColor: appColors.primaryExtraLight,
      progressColor: appColors.green,
    );
  }

  Widget body() {
    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: const Color(0xffF8F2FF),
        child: Stack(
          children: [
            GetBuilder(
                init: salariedController,
                builder: (ctx) {
                  return Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: width / 20, top: height / 20),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Get.to(const FaceDetectorView());
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: height / 16,
                            color: appColors.primaryColor,
                          ),
                        ),
                      ),
                      spacing(passedHeight: height / 24),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: width / 16, right: width / 16),
                        child: Text(
                          "Lets Verify Your\nIdentity",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: appColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: height / 12,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: width / 16, right: width / 16),
                        child: Text(
                          "We’re required by law to verify your identity before we can use your money",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: appColors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w300,
                            fontSize: height / 30,
                          ),
                        ),
                      ),
                      spacing(passedHeight: height / 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(height / 20),
                        child: Image.file(
                          File(widget.imagePath),
                          fit: BoxFit.cover,
                          height: height / 1.2,
                          width: height / 1.5,
                        ),
                      ),
                      spacing(passedHeight: height / 10),
                      salariedController.isFaceLoading.value
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                vertical: height / 30,
                                horizontal: width / 30,
                              ),
                              child: CupertinoActivityIndicator(
                                color: appColors.primaryLight,
                                radius: height / 20,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: width / 20.0, right: width / 20.0),
                              child: customButton(
                                  title: "Submit",
                                  context: context,
                                  onTap: () {
                                    salariedController.profilePicture =
                                        File(widget.imagePath);
                                    debugPrint(salariedController
                                        .profilePicture!.path
                                        .toString());
                                    salariedController.salariedAPI(step: '9');
                                  }),
                            ),
                      spacing(passedHeight: height / 6),
                    ],
                  );
                }),
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
      ),
    );
  }
}
