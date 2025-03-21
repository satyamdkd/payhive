import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/controller/salaried_controller.dart';
import 'package:payhive/modules/auth/salary/view/account_type.dart';
import 'package:payhive/modules/auth/salary/view/email_verification.dart';
import 'package:payhive/modules/auth/salary/view/pan_verify_salary.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/snackbar.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SalariedAnnualIncome extends GetView<SalariedController> {
  const SalariedAnnualIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColors.primaryColor,
      body: body(context),
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
        "Select Your Annual Income",
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
            GetBuilder(
                init: controller,
                builder: (cxt) {
                  return Column(
                    children: [
                      spacing(passedHeight: height / 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                left: width / 20, top: width / 20),
                            child: Container(
                              height: height / 12,
                              width: height / 4,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(width / 100),
                                border: Border.all(
                                  color: appColors.primaryLight,
                                  width: 0.4,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.offAll(AccountType(),
                                      transition: Transition.leftToRight,
                                      duration:
                                          const Duration(milliseconds: 500));
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
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        color: appColors.primaryLight,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (controller.isAnnualIncomeDisabled.value)
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(
                                  right: width / 20, top: width / 20),
                              child: Container(
                                height: height / 12,
                                width: height / 4,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(width / 100),
                                  border: Border.all(
                                    color: appColors.primaryLight,
                                    width: 0.4,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.offAll(const PanVerifySalary(),
                                        transition: Transition.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 500));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        " Next ",
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
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
                        ignoring: controller.isAnnualIncomeDisabled.value,
                        child: Column(
                          children: [
                            text(),
                            spacing(passedHeight: height / 20),
                            annual(),
                            searchedVillageListWidget(),
                            spacing(passedHeight: height / 0.9),
                            controller.annualIncomeLoading.value
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
                                        left: width / 20.0,
                                        right: width / 20.0),
                                    child: customButton(
                                        title: "Continue",
                                        context: context,
                                        onTap: () {
                                          if (controller.annualIncomeController
                                              .text.isNotEmpty) {
                                            controller.salariedAPI(step: '6');
                                          } else {
                                            showSnackBar(
                                                message:
                                                    'Please select your annual income',
                                                title: 'Annual Income');
                                          }
                                        }),
                                  ),
                            spacing(passedHeight: height / 10),
                          ],
                        ),
                      )
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

  Widget searchedVillageListWidget() {
    if (controller.annualStringList != null &&
        controller.annualStringList!.isNotEmpty) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: !controller.hideSearchList.value ? height / 2 : 0,
        margin: EdgeInsets.only(
          left: width / 20.0,
          right: width / 20.0,
        ),
        padding: EdgeInsets.only(top: width / 30),
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
          itemCount: controller.annualStringList!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                controller.hideSearchList.value = true;
                controller.update();
                controller.annualIncomeController.text =
                    controller.annualStringList![index];
                controller.setAnnualIncomeValue(
                    controller.annualIncomeController.text);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width / 20.0,
                  vertical: width / 30.0,
                ),
                margin: EdgeInsets.only(
                  left: width / 30.0,
                  right: width / 30.0,
                ),
                decoration: controller.annualStringList![index] ==
                        controller.annualIncomeController.text
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
                  controller.annualStringList![index],
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: controller.annualStringList![index] ==
                            controller.annualIncomeController.text
                        ? appColors.white
                        : appColors.black,
                    fontSize: height / 36,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget annual() {
    return InkWell(
      onTap: () {
        controller.hideSearchList.value = !controller.hideSearchList.value;
        controller.update();
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: width / 20.0,
          right: width / 20.0,
        ),
        child: IgnorePointer(
          ignoring: true,
          child: customTextField(
            readOnly: true,
            textEditingController: controller.annualIncomeController,
            title: "",
            fullTag: "Annual Income",
            enabledBorder: OutlineInputBorder(
              borderRadius: controller.hideSearchList.value == false
                  ? BorderRadius.only(
                      topLeft: Radius.circular(width / 50),
                      topRight: Radius.circular(width / 50),
                    )
                  : BorderRadius.circular(width / 50),
              borderSide: BorderSide(
                color: appColors.black.withOpacity(0.35),
                width: 0.6,
              ),
            ),
            textColor: appColors.black,
            prefixIcon: Container(
              padding: EdgeInsets.all(width / 26),
              child: Image.asset(
                "assets/temp/annual_income.png",
                fit: BoxFit.contain,
                height: height / 90,
                width: height / 90,
              ),
            ),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: appColors.black.withOpacity(0.4),
              size: height / 14,
            ),
            keyboardType: TextInputType.phone,
          ),
        ),
      ),
    );
  }
}
