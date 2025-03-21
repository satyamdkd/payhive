import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/dashboard/view/screens/add_money.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/image_builder.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBalanceCard(),
        _buildContactsList(),
        _buildTransactionsSection(),
      ],
    );
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
      {
        "name": "Mark",
        "icon":
            "https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg"
      },
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height / 30),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
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
                      radius: height / 13,
                      backgroundColor: appColors.primaryExtraLight,
                      child: Icon(
                        Icons.add,
                        size: height / 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height / 40),
                    Text(
                      "Add",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: appColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height / 30,
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
                            height: height / 6.6,
                            width: height / 6.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: height / 40),
                        Text(
                          contact['name'],
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: appColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: height / 30,
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
      margin: EdgeInsets.only(
          left: height / 30, right: height / 30, top: height / 30),
      padding: EdgeInsets.all(height / 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
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
        children: [
          const SizedBox(height: 10),
          Text(
            "Main balance",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.primaryExtraLight,
              fontWeight: FontWeight.w300,
              fontSize: height / 30,
            ),
          ),
          Text(
            "₹0.00",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.white,
              fontWeight: FontWeight.w500,
              fontSize: height / 10,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _balanceColumn(Icons.file_upload_outlined, "Top up"),
              Container(
                height: height / 20,
                color: appColors.white,
                width: 1,
              ),
              _balanceColumn(Icons.file_download_outlined, "Withdraw"),
              Container(
                height: height / 20,
                color: appColors.white,
                width: 1,
              ),
              _balanceColumn(Icons.transfer_within_a_station, "Transfer"),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _balanceColumn(IconData icon, String label) {
    return InkWell(
      onTap: () {
        Get.to(() => const AddMoney());
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: appColors.white,
            size: height / 20,
          ),
          SizedBox(height: height / 40),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.white,
              fontWeight: FontWeight.w300,
              fontSize: height / 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection() {
    return Container(
      margin: EdgeInsets.all(height / 30),
      padding: EdgeInsets.all(height / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: height / 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latest Transactions",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: height / 24,
                ),
              ),
              Text(
                "View all",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.black.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                  fontSize: height / 30,
                ),
              ),
            ],
          ),
          SizedBox(height: height / 20),
          _transactionItem(
              "Walmart", "Today 12:32", -35.23, Icons.store, Colors.blue),
          _transactionItem(
              "Top up", "Yesterday 02:12", 430.00, Icons.upload, Colors.purple),
          _transactionItem(
              "Netflix", "Dec 24 13:53", -13.00, Icons.movie, Colors.red),
        ],
      ),
    );
  }

  Widget _transactionItem(String title, String date, double amount,
      IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor),
              ),
              SizedBox(width: height / 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: height / 28,
                    ),
                  ),
                  Text(
                    date,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.black.withOpacity(0.4),
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
                "${amount > 0 ? '+' : ''}\$${amount.toStringAsFixed(2)}",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: amount > 0 ? appColors.green : Colors.red,
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
