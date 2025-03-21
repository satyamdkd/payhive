import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/salary/controller/salaried_controller.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PanVerifySalary extends GetView<SalariedController> {
  const PanVerifySalary({super.key});

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
              pan(context)
            ],
          ),
        ),
      ),
    );
  }

  Spacer spacer() => const Spacer();

  Container pan(BuildContext context) {
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
      child: GetBuilder<SalariedController>(
          init: controller,
          builder: (cxt) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width / 20, right: width / 20),
                  child: Form(
                    key: controller.formKeyPan,
                    child: Column(
                      children: [
                        spacing(),
                        customTextField(
                          textEditingController: controller.panController,
                          title: "Pan Number",
                          keyboardType: TextInputType.text,
                          onChanged: (val) {
                            controller.panController.value = TextEditingValue(
                              text: val.toUpperCase(),
                              selection: controller.panController.selection,
                            );

                            controller.update();
                          },
                        ),
                        spacing(passedHeight: height / 40),
                        if (controller.panDetails == null)
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: InkWell(
                              onTap: () {
                                controller.isPanTermChecked.value =
                                    !controller.isPanTermChecked.value;
                                controller.update();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    controller.isPanTermChecked.value
                                        ? "assets/icons/checkbox.png"
                                        : "assets/icons/blank_checkbox.png",
                                    height: height / 24,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: width / 60),
                                  Expanded(
                                    child: Text(
                                      "I am aware that my details will be submitted to NSDL to verify my PAN. I have read and understood all terms.",
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
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
                        if (controller.panDetails != null) panDetails(context),
                        spacer(),
                        controller.isPanLoading.value
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
                            : customButton(
                                title: "Verify",
                                context: context,
                                onTap: () {
                                  controller.validatePanForm();
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
            );
          }),
    );
  }

  Widget panDetails(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 2.7,
      width: width,
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(height / 16),
          topLeft: Radius.circular(height / 16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width / 20, right: width / 20),
        child: Column(
          children: [
            spacing(passedHeight: height / 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Pan Verified ",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: appColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: height / 18,
                  ),
                ),
                Image.asset(
                  "assets/icons/successmark.png",
                  height: height / 18,
                ),
              ],
            ),
            spacing(passedHeight: height / 20),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width / 2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PAN Number",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: appColors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w200,
                            fontSize: height / 26,
                          ),
                        ),
                        Text(
                          "${controller.panDetails!['pan_number']}",
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
                    width: width / 2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: appColors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w200,
                            fontSize: height / 26,
                          ),
                        ),
                        Text(
                          "${controller.panDetails!['status']}",
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
                          "Name",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: appColors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w200,
                            fontSize: height / 26,
                          ),
                        ),
                        Text(
                          "${controller.panDetails!['name_on_card']}",
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
          ],
        ),
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
        "Enter Your\nPAN Number",
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
