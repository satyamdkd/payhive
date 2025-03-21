import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/dashboard/controller/dashboard_controller.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/textfield.dart';

class Home extends GetView<DashBoardController> {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 1.78,
      width: width,
      padding: EdgeInsets.all(height / 30),
      child: Column(
        children: [
          rowWidgets(),
        ],
      ),
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
  rowWidgets() {
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
}
