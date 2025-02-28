import 'package:flutter/material.dart';
import 'package:payhive/modules/auth/salary/view/otp.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserType extends StatefulWidget {
  const UserType({super.key});

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColors.primaryColor,
      body: body(),
    );
  }

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

  Container text() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: width / 20,
        left: width / 18,
        right: width / 20,
      ),
      child: Text(
        "Let’s set up your account",
        style: theme.textTheme.headlineSmall?.copyWith(
            color: appColors.primaryColor, fontWeight: FontWeight.w600),
      ),
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
              progress(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    spacing(passedHeight: height / 10),
                    text(),
                    spacing(passedHeight: height / 10),
                    ...List.generate(
                      list.length,
                      (ind) => Padding(
                        padding: EdgeInsets.only(
                            left: width / 20.0, right: width / 20.0),
                        child: item(
                          list[ind],
                          ind,
                          listTitle[ind],
                          listSubtitle[ind],
                        ),
                      ),
                    ),
                    spacing(passedHeight: height / 2),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width / 20.0, right: width / 20.0),
                      child: customButton(title: "Continue", context: context),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -height / 8,
                child: Image.asset(
                  "assets/images/home_flare.png",
                  width: width,
                  height: height / 1.75,
                ),
              ),
            ],
          )),
    );
  }

  List list = [
    "assets/temp/employee-benefit.png",
    "assets/temp/employment.png",
    "assets/temp/people.png",
  ];
  List listTitle = [
    "Salaried",
    "Self Employed",
    "Others",
  ];
  List listSubtitle = [
    "with salaried status",
    "with self employed status",
    "If you are not Salaried or Self employed.",
  ];

  Widget item(path, index, title, subtitle) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: width,
      margin: EdgeInsets.only(bottom: width / 40, left: 1, right: 1),
      padding:
          EdgeInsets.symmetric(vertical: width / 30, horizontal: width / 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appColors.white,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                index == 0
                    ? "assets/icons/checkbox.png"
                    : "assets/icons/blank_checkbox.png",
                height: height / 18,
                fit: BoxFit.contain,
              ),
              SizedBox(width: width / 40),
              Container(
                decoration: BoxDecoration(
                  color: appColors.primaryLight.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(1000.0),
                ),
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                  height: height / 14,
                  width: height / 14,
                  child: Image.asset(
                    path,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textScaler: TextScaler.noScaling,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: appColors.textDark,
                        fontWeight: FontWeight.w500,
                        fontSize: width / 26,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      subtitle,
                      textScaler: TextScaler.noScaling,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: appColors.textDark,
                        fontWeight: FontWeight.w400,
                        fontSize: width / 36,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
