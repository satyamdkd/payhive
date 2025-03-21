import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/wallet_history/view/wallet_history.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({super.key});

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: appColors.bgColorHome,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBalanceSection(),
            _buildSettlementTypeSelection(
              "Choose the category of payment",
              ["Utilities", "Non-Utilities"],
              isFirst: true,
            ),
            _buildSettlementTypeSelection(
              "Select Settlement Type",
              ["Instant Settlement"],
              isFirst: false,
            ),
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width / 30.0, right: width / 30.0, bottom: height / 30),
              child: customButton(
                  title: "Add Money", context: context, onTap: () {
                    Get.to(()=> WalletScreen());
              }),
            ),
            SizedBox(height: height / 8),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Add Money",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: height / 22,
            ),
          ),
          Text(
            "₹ 999",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: height / 10,
            ),
          ),
          Image.asset(
            "assets/images/large_line.png",
            width: width / 3,
          ),
          SizedBox(height: height / 30),
          Text(
            "Minimum amount ₹ 1,000 to Maximum amount ₹ 2lakh",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w400,
              fontSize: height / 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettlementTypeSelection(
    String title,
    List<String> options, {
    required bool isFirst,
  }) {
    return Container(
      margin: EdgeInsets.all(height / 30),
      padding: EdgeInsets.all(height / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Settlement Type",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.primaryLight,
              fontWeight: FontWeight.w600,
              fontSize: height / 24,
            ),
          ),
          SizedBox(height: height / 30),
          Container(
            padding: EdgeInsets.all(height / 30),
            width: width,
            decoration: BoxDecoration(
              color: appColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height / 40),
                topRight: Radius.circular(height / 40),
              ),
            ),
            child: Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: appColors.white,
                fontWeight: FontWeight.w500,
                fontSize: height / 30,
              ),
            ),
          ),
          SizedBox(height: height / 30),
          Column(
            children: options.asMap().entries.map((entry) {
              int idx = entry.key;
              String option = entry.value;
              bool isLast = idx == options.length - 1;
              return _dropdownItem(option, isLast);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _dropdownItem(String text, bool isLast) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(height / 30),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        borderRadius: isLast
            ? BorderRadius.only(
                bottomLeft: Radius.circular(height / 40),
                bottomRight: Radius.circular(height / 40),
              )
            : BorderRadius.zero,
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: appColors.black,
          fontWeight: FontWeight.w400,
          fontSize: height / 28,
        ),
      ),
    );
  }
}
