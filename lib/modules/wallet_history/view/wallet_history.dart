import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/add_beneficiary/view/add_beneficiary.dart';
import 'package:payhive/modules/pay_vendor/view/vendor_pay.dart';
import 'package:payhive/utils/theme/apptheme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double height = 0;

  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: appColors.bgColorHome,
      body: Column(
        children: [
          _buildBalanceCard(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: height / 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(height / 60),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Column(
              children: [
                _buildTabBar(),
                _buildTransactionList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: EdgeInsets.all(height / 50),
      padding: EdgeInsets.all(height / 50),
      decoration: BoxDecoration(
        color: const Color(0xffDCFFE1),
        borderRadius: BorderRadius.circular(height / 40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/wallet.png",
            width: height / 20,
          ),
          const SizedBox(height: 10),
          Text(
            "Total Balance",
            
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.textDark,
              fontWeight: FontWeight.w700,
              fontSize: height / 46,
            ),
          ),
          Text(
            "₹0.00",
            
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.primaryLight,
              fontWeight: FontWeight.w700,
              fontSize: height / 32,
            ),
          ),
          SizedBox(height: height / 60),
          Image.asset(
            "assets/images/large_line.png",
            width: width / 2,
          ),
          SizedBox(height: height / 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _balanceColumn("₹0.00", "Main Balance"),
              Image.asset(
                "assets/images/small_line.png",
                height: height / 20,
              ),
              _balanceColumn("₹0.00", "Unsettled Balance"),
              Image.asset(
                "assets/images/small_line.png",
                height: height / 20,
              ),
              _balanceColumn("₹0.00", "Rewards/Cashback"),
            ],
          ),
          SizedBox(height: height / 60),
          Text(
            'For any refunds please email us on support @abc.com',
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w400,
              fontSize: height / 64,
            ),
          ),
          SizedBox(height: height / 60),
        ],
      ),
    );
  }

  Widget _balanceColumn(String amount, String label) {
    return Column(
      children: [
        Text(
          amount,
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontSize: height / 58,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.black.withOpacity(0.4),
            fontWeight: FontWeight.w300,
            fontSize: height / 70,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabButton("All Payment", true),
            _tabButton("Main Balance", false),
            _tabButton("Easy Cash", false),
            _tabButton("Cashback", false),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String title, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: width / 20, bottom: height / 80),
      child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? appColors.primaryLight : appColors.black,
                fontWeight: FontWeight.w700,
                fontSize: height / 64,
              ),
            ),
          ),
          if (isSelected)
            IntrinsicWidth(
              child: Container(
                height: 3,
                width: width / 4,
                color: appColors.primaryLight,
              ),
            )
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return SizedBox(
      height: height / 2.8,
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: (){
                Get.to(()=> VendorPaymentScreen());
              },
              child: _transactionItem());
        },
      ),
    );
  }

  Widget _transactionItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction ID: PL000005",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: height / 70,
                ),
              ),
              Text(
                "+36,000",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: height / 64,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallet Top Up Instant",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: height / 68,
                ),
              ),
              Text(
                "Final: ₹35,363.8",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontSize: height / 70,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Utilities ",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.primaryLight,
                      fontWeight: FontWeight.w400,
                      fontSize: height / 68,
                    ),
                  ),
                  Text(
                    " Instant",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.green,
                      fontWeight: FontWeight.w400,
                      fontSize: height / 68,
                    ),
                  ),
                ],
              ),
              Text(
                "Success",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: height / 68,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "23-Feb-2025  04:11:45 PM",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontSize: height / 68,
                ),
              ),
              Text(
                "More Information",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.green,
                  fontWeight: FontWeight.w400,
                  fontSize: height / 68,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
