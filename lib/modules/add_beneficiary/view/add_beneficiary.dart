import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';
import 'package:payhive/utils/widgets/textfield.dart';

class AddBeneficiary extends StatefulWidget {
  const AddBeneficiary({super.key});

  @override
  State<AddBeneficiary> createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: appColors.bgColorHome,
      body: Padding(
        padding: EdgeInsets.all(height / 30),
        child: SingleChildScrollView(
          child: fillBankDetails(context),
        ),
      ),
    );
  }

  Column fillBankDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height / 20),
        _buildHeader(),
        SizedBox(height: height / 16),
        Text(
          " Select Bank",
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.textDark.withOpacity(0.7),
            fontWeight: FontWeight.w500,
            fontSize: height / 32,
          ),
        ),
        SizedBox(height: height / 100),
        _buildSearchBar("Search for banks...", TextEditingController(), false),
        SizedBox(height: height / 30),
        Wrap(
          spacing: width / 30,
          children: [
            ...List.generate(
              4,
              (index) => Container(
                width: width / 2.5,
                height: height / 10,
                margin: EdgeInsets.only(bottom: height / 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 40.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    stops: const [-1, 2.0],
                    colors: index != 0
                        ? [
                            appColors.white,
                            appColors.white,
                          ]
                        : [
                            appColors.primaryLight,
                            appColors.primaryColor,
                          ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      index != 0
                          ? CupertinoIcons.app
                          : CupertinoIcons.checkmark_square,
                      size: height / 20,
                      color: index != 0 ? appColors.black : appColors.white,
                    ),
                    SizedBox(width: width / 50),
                    Text(
                      "ICICI",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: index != 0
                            ? appColors.black.withOpacity(0.5)
                            : appColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: height / 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              " View All Banks ",
              style: theme.textTheme.labelMedium?.copyWith(
                color: appColors.primaryLight,
                fontWeight: FontWeight.w500,
                fontSize: height / 34,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: height / 34,
              color: appColors.primaryLight,
            ),
          ],
        ),
        SizedBox(height: height / 16),
        Text(
          " Account Number",
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.textDark.withOpacity(0.7),
            fontWeight: FontWeight.w500,
            fontSize: height / 32,
          ),
        ),
        SizedBox(height: height / 100),
        _buildSearchBar(
            "Enter 12-digit account number", TextEditingController(), true),
        SizedBox(height: height / 16),
        Text(
          " IFSC Code",
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.textDark.withOpacity(0.7),
            fontWeight: FontWeight.w500,
            fontSize: height / 32,
          ),
        ),
        SizedBox(height: height / 100),
        _buildSearchBar("ICIC0001234", TextEditingController(), true),
        SizedBox(height: height / 8),
        customButton(
          title: "Verify Account",
          context: context,
          onTap: () {},
        ),
        SizedBox(height: height / 6),
      ],
    );
  }

  Column addBeneficiary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height / 20),
        _buildHeader(shouldPop: true),
        SizedBox(height: height / 8),
        customButton(
          title: "Verify Account",
          context: context,
          onTap: () {},
        ),
        SizedBox(height: height / 6),
      ],
    );
  }

  Widget _buildHeader({bool shouldPop = false}) {
    return Container(
      padding: EdgeInsets.all(height / 30),
      decoration: BoxDecoration(
        color: const Color(0xffEAE0F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long, color: appColors.primaryLight),
              SizedBox(width: width / 30),
              Text(
                "Add Beneficiary",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.textDark,
                  fontWeight: FontWeight.w700,
                  fontSize: height / 28,
                ),
              ),
            ],
          ),
          if (shouldPop)
            Icon(
              Icons.clear_rounded,
              size: height / 18,
              color: appColors.primaryColor,
            )
        ],
      ),
    );
  }

  Widget _buildSearchBar(title, controller, prefix) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 50),
        color: appColors.white,
      ),
      child: customTextField(
        textEditingController: controller,
        border: false,
        prefixIcon: prefix
            ? null
            : Container(
                padding: EdgeInsets.all(width / 26),
                child: Icon(
                  CupertinoIcons.search,
                  size: height / 18,
                ),
              ),
        fullTag: title,
        title: "",
        keyboardType: TextInputType.text,
      ),
    );
  }
}
