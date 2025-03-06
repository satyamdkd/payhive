import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';

class VendorPaymentScreen extends StatefulWidget {
  const VendorPaymentScreen({super.key});

  @override
  State<VendorPaymentScreen> createState() => _VendorPaymentScreenState();
}

class _VendorPaymentScreenState extends State<VendorPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(height / 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height / 20),
          _buildHeader(),
          SizedBox(height: height / 20),
          _buildSearchBar(),
          SizedBox(height: height / 20),
          _buildActionButtons(),
          SizedBox(height: height / 30),
          Text(
            "Recipient List",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.black,
              fontWeight: FontWeight.bold,
              fontSize: height / 24,
            ),
          ),
          SizedBox(height: height / 40),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildRecipientItem();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(height / 30),
      decoration: BoxDecoration(
        color: const Color(0xffEAE0F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.people_alt_outlined, color: appColors.textDark),
          SizedBox(
            width: width / 30,
          ),
          Text(
            "Vendor Payment",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: height / 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 50),
        color: appColors.white,
      ),
      child: customTextField(
        textEditingController: TextEditingController(),
        border: false,
        prefixIcon: Container(
          padding: EdgeInsets.all(width / 26),
          child: Icon(
            CupertinoIcons.search,
            size: height / 18,
          ),
        ),
        fullTag: "Search beneficiary by name, account or bank",
        title: "",
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        customButton(
          passedHeight: height / 11,
          passedWidth: width / 2.4,
          title: "Add Beneficiary",
          context: context,
          onTap: () {},
        ),
        SizedBox(width: width / 30),
        SizedBox(
          height: height / 11,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.favorite_border, size: height / 20),
            label: Text(
              "Favorites",
              style: theme.textTheme.labelMedium?.copyWith(
                color: appColors.primaryLight,
                fontWeight: FontWeight.w400,
                fontSize: height / 28,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: appColors.primaryLight,
              side: BorderSide(color: appColors.primaryLight),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(height / 40)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientItem() {
    return Container(
      margin: EdgeInsets.only(top: height / 30),
      padding: EdgeInsets.all(height / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height / 30),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.receipt_long,
                    color: appColors.primaryLight,
                    size: height / 18,
                  ),
                  SizedBox(width: width / 40),
                  Text(
                    "Sunil Kumar",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: height / 28,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customButton(
                    passedHeight: height / 12,
                    passedWidth: width / 3.8,
                    title: "Transfer",
                    context: context,
                    onTap: () {},
                  ),
                  SizedBox(width: width / 60),
                  SizedBox(
                    height: height / 12,
                    width: width / 3.8,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.delete, size: height / 24),
                      label: Text(
                        "Delete",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: appColors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: height / 32,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: appColors.red,
                        side: BorderSide(color: appColors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(height / 40)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: height / 80),
          Padding(
            padding: EdgeInsets.only(
              left: height / 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "A/C: 765489753209",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    fontSize: height / 30,
                  ),
                ),
                Text(
                  "ICICI Bank Limited",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: appColors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    fontSize: height / 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
