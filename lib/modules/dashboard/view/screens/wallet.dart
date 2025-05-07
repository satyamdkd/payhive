import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:payhive/modules/dashboard/controller/dashboard_controller.dart';
import 'package:payhive/routes/pages.dart';
import 'package:payhive/utils/helper/date_time.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/image_builder.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key, required this.controller});

  final DashBoardController controller;

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.controller.walletAmount.value.toString());

    return GetBuilder(
        init: widget.controller,
        builder: (ctx) {
          return RefreshIndicator(
            onRefresh: () async {
              widget.controller.dashboardApi();
              widget.controller.walletHistory();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                _buildBalanceCard(),
                _buildContactsList(),
                if (widget.controller.walletHistoryRes != null &&
                    widget.controller.walletHistoryRes?['data'] != [])
                  _buildTransactionsSection(),
              ],
            ),
          );
        });
  }

  Widget _buildContactsList() {
    List<Map<String, dynamic>> contacts = [
      {
        "name": "Ali",
        "icon":
            "https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg"
      },
      {
        "name": "Steve",
        "icon":
            "https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg"
      },
      {
        "name": "Ahmed",
        "icon":
            "https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg"
      },
      {
        "name": "Mark",
        "icon":
            "https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg"
      },
    ];
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          left: height / 30, right: height / 30, top: height / 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: height / 30, left: height / 30, bottom: height / 30),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: height / 15,
                      backgroundColor: appColors.primaryExtraLight,
                      child: Icon(
                        CupertinoIcons.add,
                        size: height / 16,
                        color: appColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: height / 40),
                    Text(
                      "Add",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: appColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: height / 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 10, bottom: 12),
              child: Row(
                children: contacts.map((contact) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: imageBuilder(
                            contact['icon'],
                            height: height / 7.6,
                            width: height / 7.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: height / 40),
                        Text(
                          contact['name'],
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: appColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: height / 32,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: width,
      height: height / 2.7,
      margin: EdgeInsets.only(
        left: height / 30,
        right: height / 30,
        top: height / 30,
      ),
      padding: EdgeInsets.all(height / 30),
      decoration: BoxDecoration(
        border: Border.all(color: appColors.white, width: 0.5),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.center,
          stops: [-2, 1],
          colors: [
            Color(0xffA903D2),
            Color(0xff5033A4),
          ],
        ),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        borderRadius: BorderRadius.circular(height / 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Main balance",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.primaryExtraLight,
              fontWeight: FontWeight.w300,
              fontSize: height / 30,
            ),
          ),
          widget.controller.dashboardLoading.value
              ? Lottie.asset('assets/lottie/wave_loading.json',
                  width: width / 2, height: height / 6.5)
              : Text(
                  "₹${widget.controller.walletAmount.value}",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: height / 12,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: height / 20),
      padding: EdgeInsets.all(height / 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latest Transactions",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.textLight,
                  fontWeight: FontWeight.w700,
                  fontSize: height / 28,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.walletHistory);
                },
                child: Text(
                  "View all",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.black.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w400,
                    fontSize: height / 30,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height / 30),
          ListView.builder(
            itemCount: widget.controller.walletHistoryRes?['data'].length > 4
                ? 4
                : widget.controller.walletHistoryRes?['data'].length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, ind) => Column(
              children: [
                _transactionItem(
                    "${widget.controller.walletHistoryRes?['data'][ind]['text']}",
                    formatTransactionDate(widget
                        .controller.walletHistoryRes?['data'][ind]['datetime']),
                    double.parse(widget.controller.walletHistoryRes?['data']
                        [ind]['balance_amt']),
                    Icons.wallet_outlined,
                    appColors.primaryColor,
                    widget.controller.walletHistoryRes?['data'][ind]['type']),
                Divider(
                  color: appColors.primaryColor.withValues(alpha: 0.25),
                  thickness: 0.25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(
    String title,
    String date,
    double amount,
    IconData icon,
    Color iconColor,
    String debitCredit,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withValues(alpha: 0.1),
                child: Icon(icon, color: iconColor),
              ),
              SizedBox(width: height / 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.textLight.withValues(alpha: 0.9),
                      fontWeight: FontWeight.bold,
                      fontSize: height / 30,
                    ),
                  ),
                  Text(
                    date,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.black.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w400,
                      fontSize: height / 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${debitCredit == 'Debit' ? '-' : "+"}₹${amount.toStringAsFixed(2)}",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: debitCredit == 'Debit' ? Colors.red : appColors.green,
                  fontWeight: FontWeight.w700,
                  fontSize: height / 28,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: height / 32,
                color: Colors.grey,
              )
            ],
          ),
        ],
      ),
    );
  }
}
