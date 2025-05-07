import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/address/controller/address_controller.dart';
import 'package:payhive/modules/address/view/new_address.dart';
import 'package:payhive/modules/dashboard/controller/dashboard_controller.dart';
import 'package:payhive/routes/pages.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';

class NewProfile extends GetView<DashBoardController> {
  const NewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Color cardColor = appColors.primaryColor;
    const Color changeColor = Color(0xFF8A4DFF);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GetBuilder(
            init: controller,
            builder: (ctx) {
              return controller.isLoadingUserData.value
                  ? Container(
                      height: height / 0.6,
                      width: width,
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 30,
                      ),
                      child: CupertinoActivityIndicator(
                        color: appColors.white,
                        radius: height / 10,
                      ),
                    )
                  : Column(
                      children: [
                        _userDetails(cardColor),
                        _spacing(),
                        _personalDetails(cardColor, changeColor, context),
                        _spacing(),
                        _userAddress(cardColor, changeColor, context),
                        _spacing(),
                        _aboutPayLix(cardColor, changeColor),
                      ],
                    );
            }),
      ),
    );
  }

  _spacing({passedHeight}) => SizedBox(height: passedHeight ?? height / 30);

  _userDetails(Color cardColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          stops: const [-1, 2.0],
          colors: [
            appColors.primaryLight.withOpacity(0.8),
            appColors.primaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: .35, color: appColors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: height / 30, right: height / 30, top: height / 30),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.userDetails?['data']['name'] ?? ''}',
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: appColors.white,
                          fontSize: height / 24,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "ID: PLXID${controller.userDetails?['data']['id'] ?? ''}",
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: appColors.white,
                          fontSize: height / 32,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "v1.0.0",
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: appColors.white.withOpacity(0.7),
                          fontSize: height / 34,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height / 30),
          Padding(
            padding: EdgeInsets.only(
              left: height / 30,
              right: height / 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.white70, size: height / 20),
                    SizedBox(width: width / 50),
                    Text(
                      "+91 ${controller.userDetails?['data']['phone'] ?? ''}",
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: appColors.white,
                        fontSize: height / 28,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const VerifiedChip(),
              ],
            ),
          ),
          _spacing(passedHeight: height / 40),
          Padding(
            padding: EdgeInsets.only(
              left: height / 30,
              right: height / 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.mail_solid,
                        color: Colors.white70, size: height / 20),
                    SizedBox(width: width / 50),
                    Text(
                      '${controller.userDetails?['data']['email'] ?? ''}',
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: appColors.white,
                        fontSize: height / 28,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const VerifiedChip(),
              ],
            ),
          ),
          _spacing(passedHeight: height / 30),
          Divider(
            color: appColors.white,
            thickness: 0.35,
          ),
          _spacing(passedHeight: height / 40),
          Padding(
            padding: EdgeInsets.only(
              left: height / 30,
              right: height / 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "KYC Status",
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: appColors.white,
                    fontSize: height / 28,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const VerifiedChip(),
              ],
            ),
          ),
          _spacing(passedHeight: height / 30),
        ],
      ),
    );
  }

  _personalDetails(Color cardColor, Color changeColor, context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: controller.personalDetailsOpen.value ? height / 1.11 : height / 7,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: .35, color: appColors.white),
      ),
      padding: EdgeInsets.symmetric(vertical: height / 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _spacing(passedHeight: height / 120),
          InkWell(
            onTap: () {
              controller.userAddressOpen.value = false;
              controller.userAddressForChildWidget.value = false;

              controller.aboutPayLixOpen.value = false;
              controller.aboutPayLixForChildWidget.value = false;

              controller.personalDetailsOpen.value =
                  !controller.personalDetailsOpen.value;

              if (controller.personalDetailsOpen.value == false) {
                controller.personalDetailsOpenForChildWidget.value =
                    !controller.personalDetailsOpenForChildWidget.value;
              } else {
                Future.delayed(const Duration(milliseconds: 400), () {
                  controller.personalDetailsOpenForChildWidget.value =
                      !controller.personalDetailsOpenForChildWidget.value;
                  controller.update();
                });
              }

              controller.update();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: height / 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: height / 16,
                  ),
                  SizedBox(
                    width: width / 36,
                  ),
                  Text(
                    'Personal Details',
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: appColors.white,
                      fontSize: height / 25,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    controller.personalDetailsOpen.value
                        ? Icons.expand_less
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: height / 16,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: controller.personalDetailsOpenForChildWidget.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _spacing(passedHeight: height / 30),
                  Divider(
                    color: appColors.white.withOpacity(0.35),
                    thickness: 0.35,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _spacing(passedHeight: height / 20),
                      kycInfo(
                          title: 'Pan Number',
                          subTitle:
                              '${controller.userDetails?['data']['panno']['pan_number'] ?? ''}',
                          letterSpacing: 2),
                      _spacing(passedHeight: height / 50),
                      kycInfo(
                          title: 'Aadhar Number',
                          subTitle:
                              '${controller.userDetails?['data']['aadhar']['aadhar'] ?? ''}',
                          letterSpacing: 1),
                      _spacing(passedHeight: height / 20),
                      Divider(
                        color: appColors.white.withOpacity(0.35),
                        thickness: 0.35,
                      ),
                      _spacing(passedHeight: height / 20),
                      Padding(
                        padding: EdgeInsets.only(
                          left: height / 40,
                          right: height / 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Bank Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height / 28,
                                )),
                            const VerifiedChip(),
                          ],
                        ),
                      ),
                      if (controller.userDetails?['data']['bank'] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height / 40),
                            InfoRow(
                              title: "Account Holder",
                              value:
                                  '${controller.userDetails?['data']['bank']['name'] ?? '--'}',
                            ),

                            /// InfoRow(
                            ///     title: "Bank Name",
                            ///     value:
                            ///         '${controller.userDetails?['data']['bank']['accountnumber'] ?? ''}'),
                            InfoRow(
                                title: "Account Number",
                                value:
                                    '${controller.userDetails?['data']['bank']['accountnumber'] ?? ''}'),
                            InfoRow(
                                title: "IFSC Code",
                                value:
                                    '${controller.userDetails?['data']['bank']['ifsc'] ?? ''}'),

                            Padding(
                              padding: EdgeInsets.only(
                                left: height / 40,
                                top: height / 40,
                              ),
                              child: customButton(
                                passedHeight: height / 14,
                                passedWidth: width / 4,
                                title: controller.userDetails?['data']
                                            ['bank'] !=
                                        null
                                    ? "Change"
                                    : "Add Bank",
                                border: Border.all(
                                    color: appColors.white, width: 0.35),
                                context: context,
                                onTap: () {
                                  Get.toNamed(Routes.bankDetail)!.then((v) {
                                    controller.getUserData();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _userAddress(Color cardColor, Color changeColor, context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: controller.userAddressOpen.value ? height / 1.88 : height / 7,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: .35, color: appColors.white),
      ),
      padding: EdgeInsets.symmetric(vertical: height / 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _spacing(passedHeight: height / 120),
          InkWell(
            onTap: () {
              controller.personalDetailsOpen.value = false;
              controller.personalDetailsOpenForChildWidget.value = false;

              controller.aboutPayLixOpen.value = false;
              controller.aboutPayLixForChildWidget.value = false;

              controller.userAddressOpen.value =
                  !controller.userAddressOpen.value;

              if (controller.userAddressOpen.value == false) {
                controller.userAddressForChildWidget.value =
                    !controller.userAddressForChildWidget.value;
              } else {
                Future.delayed(const Duration(milliseconds: 400), () {
                  controller.userAddressForChildWidget.value =
                      !controller.userAddressForChildWidget.value;
                  controller.update();
                });
              }

              controller.update();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: height / 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.home_rounded,
                    color: Colors.white,
                    size: height / 16,
                  ),
                  SizedBox(
                    width: width / 36,
                  ),
                  Text(
                    'Address Information',
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: appColors.white,
                      fontSize: height / 25,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    controller.userAddressOpen.value
                        ? Icons.expand_less
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: height / 16,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: controller.userAddressForChildWidget.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _spacing(passedHeight: height / 30),
                  Divider(
                    color: appColors.white.withOpacity(0.35),
                    thickness: 0.35,
                  ),
                  _spacing(passedHeight: height / 30),
                  if (controller.addressList.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                        left: height / 40,
                        right: height / 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Address",
                                style: theme.textTheme.labelLarge!.copyWith(
                                  color: appColors.white,
                                  fontSize: height / 26,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: width / 1.6,
                                child: Text(
                                  "${controller.addressList[0]['address']}",
                                  style: theme.textTheme.labelLarge!.copyWith(
                                    color: appColors.white,
                                    fontSize: height / 30,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const VerifiedChip(),
                        ],
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: height / 40,
                      top: height / 40,
                    ),
                    child: customButton(
                      passedHeight: height / 14,
                      passedWidth: width / 4,
                      title: 'Add Address',
                      border: Border.all(color: appColors.white, width: 0.35),
                      context: context,
                      onTap: () {
                        Get.put(AddressController());
                        String myAddress = '';
                        if (controller.addressList.isNotEmpty) {
                          if (controller.userDetails!['data']['address'] !=
                              null) {
                            myAddress = controller.addressList[0]['address'];
                          }
                        }

                        Get.to(
                          () => LocationSelectionPage(
                            myAddress,
                            controller.userDetails!['data']['name'] ?? "",
                            controller.userDetails!['data']['phone'] ?? "",
                            controller.addressList,
                          ),
                          transition: Transition.downToUp,
                          duration: const Duration(microseconds: 500),
                        )!
                            .then((v) {
                          controller.getUserData();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  kycInfo(
      {required String title,
      required String subTitle,
      double? letterSpacing}) {
    return Padding(
      padding: EdgeInsets.only(
        left: height / 40,
        right: height / 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: appColors.white,
                  fontSize: height / 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                subTitle,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: appColors.white,
                  fontSize: height / 28,
                  letterSpacing: letterSpacing,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const VerifiedChip(),
        ],
      ),
    );
  }

  _aboutPayLix(Color cardColor, Color changeColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: controller.aboutPayLixOpen.value ? height / 1.9 : height / 7,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0.25, color: appColors.white),
      ),
      padding: EdgeInsets.symmetric(vertical: height / 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              controller.personalDetailsOpen.value = false;
              controller.personalDetailsOpenForChildWidget.value = false;

              controller.userAddressOpen.value = false;
              controller.userAddressForChildWidget.value = false;

              controller.aboutPayLixOpen.value =
                  !controller.aboutPayLixOpen.value;

              if (controller.aboutPayLixOpen.value == false) {
                controller.aboutPayLixForChildWidget.value =
                    !controller.aboutPayLixForChildWidget.value;
              } else {
                Future.delayed(const Duration(milliseconds: 400), () {
                  controller.aboutPayLixForChildWidget.value =
                      !controller.aboutPayLixForChildWidget.value;
                  controller.update();
                });
              }

              controller.update();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: height / 26),
              child: Column(
                children: [
                  _spacing(passedHeight: height / 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.white,
                        size: height / 16,
                      ),
                      SizedBox(
                        width: width / 36,
                      ),
                      Text(
                        'About Paylix',
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: appColors.white,
                          fontSize: height / 25,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        controller.aboutPayLixOpen.value
                            ? Icons.expand_less
                            : Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: height / 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: controller.aboutPayLixForChildWidget.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _spacing(passedHeight: height / 30),
                  Divider(
                    color: appColors.white.withOpacity(0.35),
                    thickness: 0.35,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: height / 40,
                      right: height / 40,
                    ),
                    child: Column(
                      children: [
                        _spacing(passedHeight: height / 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.description_rounded,
                              color: Colors.white,
                              size: height / 16,
                            ),
                            SizedBox(
                              width: width / 40,
                            ),
                            Text(
                              'Term & Conditions',
                              style: theme.textTheme.labelLarge!.copyWith(
                                color: appColors.white,
                                fontSize: height / 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: height / 36,
                            ),
                          ],
                        ),
                        _spacing(passedHeight: height / 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.privacy_tip_rounded,
                              color: Colors.white,
                              size: height / 16,
                            ),
                            SizedBox(
                              width: width / 40,
                            ),
                            Text(
                              'Privacy Policy',
                              style: theme.textTheme.labelLarge!.copyWith(
                                color: appColors.white,
                                fontSize: height / 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: height / 36,
                            ),
                          ],
                        ),
                        _spacing(passedHeight: height / 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.contact_support_rounded,
                              color: Colors.white,
                              size: height / 16,
                            ),
                            SizedBox(
                              width: width / 40,
                            ),
                            Text(
                              'Contact Us',
                              style: theme.textTheme.labelLarge!.copyWith(
                                color: appColors.white,
                                fontSize: height / 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: height / 36,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Container completeYourKYC() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: appColors.primaryColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complete your profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Get a personalised experience and easy setup across PayLix\'s offerings',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: width / 2.8,
          height: height / 12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 60.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: const [-1, 2.0],
              colors: [
                appColors.primaryExtraLight,
                appColors.primaryLight,
              ],
            ),
          ),
          child: Text(
            "COMPLETE NOW",
            style: theme.textTheme.labelLarge?.copyWith(
              color: appColors.white,
              fontSize: height / 36,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

class VerifiedChip extends StatelessWidget {
  const VerifiedChip({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Verified",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const StatusChip(
      {required this.text, required this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: height / 38,
        right: height / 40,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: height / 30,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.labelLarge!.copyWith(
                color: appColors.white,
                fontSize: height / 30,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
