import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/view/otp.dart';
import 'package:payhive/modules/auth/salary/view/success.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LetsVerifyYourIdentity extends StatefulWidget {
  const LetsVerifyYourIdentity({super.key});

  @override
  State<LetsVerifyYourIdentity> createState() => _LetsVerifyYourIdentityState();
}

class _LetsVerifyYourIdentityState extends State<LetsVerifyYourIdentity> {
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
        "Lets Verify Your\nIdentity",
        style: theme.textTheme.headlineSmall?.copyWith(
            color: appColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: height / 12),
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
            Column(
              children: [
                spacing(passedHeight: height / 10),
                text(),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: width / 16, right: width / 16),
                  child: Text(
                    "We’re required by law to verify your identity ",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.textDark,
                      fontWeight: FontWeight.w300,
                      fontSize: height / 24,
                    ),
                  ),
                ),
                spacing(passedHeight: height / 10),
                SizedBox(
                  height: height / 1.4,
                  width: width,
                  child: Image.asset(
                    "assets/images/face_scan.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                spacer(),
                Padding(
                  padding:
                      EdgeInsets.only(left: width / 20.0, right: width / 20.0),
                  child: customButton(
                    title: "Verify Identity",
                    context: context,
                    onTap: (){
                      Get.to(()=> const Success());
                    }
                  ),
                ),
                spacing(passedHeight: height / 10),
              ],
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
      ),
    );
  }

  Widget searchedVillageListWidget() {
    return Container(
      height: 150,
      margin: EdgeInsets.only(
        left: width / 20.0,
        right: width / 20.0,
      ),
      padding: EdgeInsets.only(
        top: width / 30,
      ),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: width / 20.0,
              vertical: width / 30.0,
            ),
            margin: EdgeInsets.only(
              left: width / 30.0,
              right: width / 30.0,
            ),
            decoration: index == 0
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      stops: const [-1, 2.0],
                      colors: [
                        appColors.primaryColor,
                        appColors.primaryColor,
                      ],
                    ),
                  )
                : null,
            child: Text(
              "5 to 10 Lakh",
              style: theme.textTheme.labelMedium?.copyWith(
                color: index == 0 ? appColors.white : appColors.black,
                fontSize: height / 36,
                fontWeight: FontWeight.w300,
              ),
            ),
          );
        },
      ),
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
