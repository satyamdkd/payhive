import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/dashboard/controller/dashboard_controller.dart';
import 'package:payhive/routes/pages.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/textfield.dart';

class Home extends GetView<DashBoardController> {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(height / 30),
      child: GetBuilder<DashBoardController>(
          init: controller,
          builder: (ctx) {
            return Column(
              children: [
                spacing(passedHeight: height / 70),
                Container(
                    padding: EdgeInsets.symmetric(vertical: width / 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Image.asset('assets/home/banner.png')),
                spacing(passedHeight: height / 30),
                transfer(),
                spacing(passedHeight: height / 30),
                recharge(),
                spacing(passedHeight: height / 30),
                insurance(),
                if (controller.isPosAssigned.value)
                  spacing(passedHeight: height / 30),
                if (controller.isPosAssigned.value) pos(),
                spacing(passedHeight: height / 5),
              ],
            );
          }),
    );
  }

  final List<Map<String, dynamic>> insuranceCategories = [
    {
      "title": "Car\nInsurance",
      "icon": 'assets/home/car1.png',
      "color": Colors.orange
    },
    {
      "title": "Bike\nInsurance",
      "icon": 'assets/home/Bike_Insurance 1.png',
      "color": Colors.purple
    },
    {
      "title": "Life\nInsurance",
      "icon": 'assets/home/life_ins.png',
      "color": Colors.orange
    },
    {
      "title": "Business\nInsurance",
      "icon": 'assets/home/business_insurance.png',
      "color": Colors.purple
    },
    {
      "title": "Family\nInsurance",
      "icon": 'assets/home/family_ins.png',
      "color": Colors.purple
    },
    {
      "title": "Health\nInsurance",
      "icon": 'assets/home/health_insurance 1.png',
      "color": Colors.orange
    },
    {
      "title": "Term\nInsurance",
      "icon": 'assets/home/term_life_nsurance 1.png',
      "color": Colors.purple
    },
    {
      "title": "Business\nInsurance",
      "icon": 'assets/home/business_insurance.png',
      "color": Colors.orange
    },
  ];

  final List<Map<String, dynamic>> rechargeCategories = [
    {
      "title": "Mobile\nRecharge",
      "icon": 'assets/home/mobile.png',
      "color": Colors.orange
    },
    {
      "title": "FastTag\nRecharge",
      "icon": 'assets/home/fasttag.png',
      "color": Colors.purple
    },
    {
      "title": "DTH\nRecharge",
      "icon": 'assets/home/dth.png',
      "color": Colors.orange
    },
    {
      "title": "Broadband\nRecharge",
      "icon": 'assets/home/broadband.png',
      "color": Colors.purple
    },
  ];
  final List<Map<dynamic, dynamic>> posCategories = [
    {
      "title": "New POS\nRequest",
      "icon": Icons.mobile_screen_share_rounded,
    },
    {
      "title": "All POS\nRequest",
      "icon": Icons.mobile_friendly_rounded,
    },
  ];
  final List<Map<String, dynamic>> transferCategories = [
    {
      "title": "Vendor\nPayment",
      "icon": 'assets/home/vendor_pay.png',
      "color": Colors.orange
    },
    {
      "title": "Business\nPayment",
      "icon": 'assets/home/business_pay.png',
      "color": Colors.purple
    },
    {
      "title": "Rent\nPayment",
      "icon": 'assets/home/rent_pay.png',
      "color": Colors.orange
    },
    {
      "title": "Education\nPayment",
      "icon": 'assets/home/education_pay.png',
      "color": Colors.purple
    },
  ];

  insurance() {
    return Container(
      padding: EdgeInsets.all(width / 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Insurance",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: height / 24,
                  ),
                ),
                Text(
                  "View All",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: height / 32,
                  ),
                ),
              ],
            ),
          ),
          spacing(passedHeight: height / 24),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            mainAxisSpacing: height / 40,
            crossAxisCount: 4,
            children: insuranceCategories
                .map(
                  (item) => Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        item["icon"],
                        fit: BoxFit.contain,
                        scale: 3.6,
                      ),
                      Text(
                        item["title"],
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: appColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: height / 36,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          spacing(passedHeight: height / 32),
        ],
      ),
    );
  }

  recharge() {
    return Container(
      padding: EdgeInsets.all(width / 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recharges",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: height / 24,
                  ),
                ),
                Text(
                  "View All",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: height / 32,
                  ),
                ),
              ],
            ),
          ),
          spacing(passedHeight: height / 24),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            mainAxisSpacing: height / 40,
            crossAxisCount: 4,
            children: rechargeCategories
                .map(
                  (item) => Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        item["icon"],
                        fit: BoxFit.contain,
                        scale: 3.6,
                      ),
                      Text(
                        item["title"],
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: appColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: height / 36,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          spacing(passedHeight: height / 32),
        ],
      ),
    );
  }

  pos() {
    return Container(
      padding: EdgeInsets.all(width / 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "POS Request",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: height / 24,
                  ),
                ),
              ],
            ),
          ),
          spacing(passedHeight: height / 24),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            mainAxisSpacing: height / 40,
            crossAxisCount: 4,
            children: posCategories
                .map(
                  (item) => InkWell(
                    onTap: () {
                      if (item["title"] == 'New POS\nRequest') {
                        Get.toNamed(Routes.posRequest);
                      } else {
                        Get.toNamed(Routes.listPosRequest);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          item["icon"],
                          size: height / 10,
                          color: appColors.primaryColor,
                        ),
                        Text(
                          item["title"],
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: appColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: height / 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          spacing(passedHeight: height / 32),
        ],
      ),
    );
  }

  transfer() {
    return Container(
      padding: EdgeInsets.all(width / 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transfers",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: height / 24,
                  ),
                ),
                Text(
                  "View All",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: height / 32,
                  ),
                ),
              ],
            ),
          ),
          spacing(passedHeight: height / 24),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            mainAxisSpacing: height / 40,
            crossAxisCount: 4,
            children: transferCategories
                .map(
                  (item) => InkWell(
                    onTap: () {
                      if (item["title"] == 'Vendor\nPayment') {
                        Get.toNamed(Routes.vendorPay);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          item["icon"],
                          fit: BoxFit.contain,
                          scale: 3.6,
                        ),
                        Text(
                          item["title"],
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: appColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: height / 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          spacing(passedHeight: height / 32),
        ],
      ),
    );
  }
}
