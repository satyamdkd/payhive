import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/controller/salaried_controller.dart';
import 'package:payhive/modules/auth/salary/view/annual_income.dart';
import 'package:payhive/modules/auth/salary/view/email_verification.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/snackbar.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AccountType extends GetView<SalariedController> {
  AccountType({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (v, t) {
        Get.offAll(() => EmailVerification());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appColors.primaryColor,
        body: body(context),
      ),
    );
  }

  LinearPercentIndicator progress() {
    return LinearPercentIndicator(
      width: width,
      animation: true,
      animationDuration: 2500,
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
        left: width / 15,
        right: width / 20,
      ),
      child: Text(
        "Let’s set up your account",
        style: theme.textTheme.headlineSmall?.copyWith(
            color: appColors.primaryColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget body(BuildContext context) {
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
                  spacing(passedHeight: height / 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        margin:
                            EdgeInsets.only(left: width / 18, top: width / 20),
                        child: Container(
                          height: height / 12,
                          width: height / 4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width / 100),
                            border: Border.all(
                              color: appColors.primaryLight,
                              width: 0.4,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.offAll(EmailVerification(),
                                  transition: Transition.leftToRight,
                                  duration: const Duration(milliseconds: 500));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: height / 25,
                                  color: appColors.primaryLight,
                                ),
                                Text(
                                  " Back ",
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: appColors.primaryLight,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (controller.isAccountTypeScreenDisabled.value)
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(
                              right: width / 18, top: width / 20),
                          child: Container(
                            height: height / 12,
                            width: height / 4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width / 100),
                              border: Border.all(
                                color: appColors.primaryLight,
                                width: 0.4,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.offAll(const SalariedAnnualIncome(),
                                    transition: Transition.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 500));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " Next ",
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: appColors.primaryLight,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: height / 25,
                                    color: appColors.primaryLight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  IgnorePointer(
                      ignoring: controller.isAccountTypeScreenDisabled.value,
                      child: Column(children: [
                        text(),
                        spacing(passedHeight: height / 10),
                        ...List.generate(
                          list.length,
                          (ind) => Padding(
                            padding: EdgeInsets.only(
                                left: width / 20.0, right: width / 20.0),
                            child: InkWell(
                              onTap: () {
                                if (ind != 0) {
                                  showSnackBar(
                                    message: "Under process...",
                                    title: "PayHive",
                                  );
                                }
                              },
                              child: item(
                                list[ind],
                                ind,
                                listTitle[ind],
                                listSubtitle[ind],
                              ),
                            ),
                          ),
                        ),
                        spacing(passedHeight: height / 2.7),
                        Obx(
                          () => controller.isAccountTypeLoading.value
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
                                      title: "Continue",
                                      context: context,
                                      onTap: () {
                                        controller.salariedAPI(step: '5');
                                      }),
                                ),
                        )
                      ])),
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
          )),
    );
  }

  final List list = [
    "assets/temp/employee-benefit.png",
    "assets/temp/employment.png",
    "assets/temp/people.png",
  ];
  final List listTitle = [
    "Salaried",
    "Self Employed",
    "Others",
  ];
  final List listSubtitle = [
    "with salaried status",
    "with self employed status",
    "If you are not Salaried or Self employed.",
  ];

  Widget item(path, index, title, subtitle) {
    return Card(
      child: AnimatedContainer(
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
                    height: height / 12,
                    width: height / 12,
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
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: appColors.textDark,
                          fontWeight: FontWeight.w500,
                          fontSize: width / 26,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        subtitle,
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
      ),
    );
  }
}
