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

class Profile extends GetView<DashBoardController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (ctx) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: controller.isLoadingUserData.value
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
                : Stack(
                    children: [
                      userInfo(),
                      Positioned(
                        top: height / 1.9,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(width / 30),
                          child: Column(
                            children: [
                              SizedBox(
                                width: width,
                                child: Card(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: width / 20,
                                        right: width / 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Profile',
                                            style: theme.textTheme.labelMedium
                                                ?.copyWith(
                                              color: appColors.primaryColor,
                                              letterSpacing: 2,
                                              fontWeight: FontWeight.w700,
                                              fontSize: height / 24,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: height / 30,
                                            ),
                                            child: customButton(
                                              passedHeight: height / 14,
                                              passedWidth: width / 6,
                                              title: "Edit",
                                              context: context,
                                              onTap: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color:
                                          appColors.grey.withValues(alpha: 0.5),
                                      thickness: 1,
                                    ),
                                    SizedBox(height: height / 40),
                                    buildRowText(
                                      title: 'Name',
                                      subTitle:
                                          '${controller.userDetails?['data']['name'] ?? ''}',
                                    ),
                                    buildRowText(
                                      title: 'Phone',
                                      subTitle:
                                          '${controller.userDetails?['data']['phone'] ?? ''}',
                                    ),
                                    buildRowText(
                                      title: 'Email',
                                      subTitle:
                                          '${controller.userDetails?['data']['email'] ?? ''}',
                                    ),
                                    SizedBox(height: height / 20),
                                  ],
                                )),
                              ),
                              SizedBox(height: height / 40),
                              _buildListTile(
                                'Personal Details',
                                CupertinoIcons.person_alt,
                                onTap: () {
                                  Get.toNamed(
                                    Routes.personalDetails,
                                    arguments: controller,
                                  );
                                },
                              ),
                              _buildListTile(
                                'Add Bank',
                                Icons.account_balance_outlined,
                                onTap: () {
                                  Get.toNamed(Routes.bankDetail)!.then((v) {
                                    controller.getUserData();
                                  });
                                },
                              ),
                              _buildListTile(
                                'Add Address',
                                Icons.home_outlined,
                                onTap: () {
                                  Get.put(AddressController());

                                  String myAddress = '';

                                  if (controller.userDetails!['data']
                                          ['address'] !=
                                      null) {
                                    myAddress = controller.userDetails!['data']
                                        ['address']['address'];
                                  }

                                  Get.to(
                                    () => LocationSelectionPage(
                                      myAddress,
                                      controller.userDetails!['data']['name'] ??
                                          "",
                                      controller.userDetails!['data']
                                              ['phone'] ??
                                          "",
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
                              if (controller.isPosAssigned.value)
                                _buildListTile(
                                  'POS Request',
                                  Icons.security,
                                  onTap: () {
                                    Get.toNamed(Routes.posRequest);
                                  },
                                ),
                              if (controller.isPosAssigned.value)
                                _buildListTile(
                                  'All POS Request',
                                  Icons.info_outline_rounded,
                                  onTap: () {
                                    Get.toNamed(Routes.listPosRequest);
                                  },
                                ),
                              SizedBox(height: height / 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }

  Widget _buildListTile(String title, IconData icon, {void Function()? onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: const Color(0xFF512DA8)),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        Padding(
          padding: EdgeInsets.only(right: width / 14),
          child: Divider(
            height: 1,
            indent: width / 7.5,
            color: appColors.black,
          ),
        ),
      ],
    );
  }

  Padding buildRowText({title, subTitle}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: width / 8,
            child: Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: appColors.black.withValues(alpha: 0.4),
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
                fontSize: height / 32,
              ),
            ),
          ),
          Text(
            ':  ',
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.black.withValues(alpha: 0.5),
              letterSpacing: 1,
              fontWeight: FontWeight.w400,
              fontSize: height / 30,
            ),
          ),
          Text(
            subTitle,
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.black.withValues(alpha: 0.4),
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              fontSize: height / 32,
            ),
          ),
        ],
      ),
    );
  }

  Container userInfo() {
    return Container(
      height: height / 1.45,
      padding: EdgeInsets.only(
        top: width / 18,

        /// left: width / 18,
      ),
      decoration: BoxDecoration(
        color: appColors.white,
        image: const DecorationImage(
          image: AssetImage("assets/images/splash_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   alignment: Alignment.center,
          //   child: CircleAvatar(
          //     radius: height / 7.5,
          //     foregroundImage: NetworkImage(
          //         '${controller.userDetails?['data']['profile'] ?? ''}'),
          //   ),
          // ),

          // SizedBox(width: width / 30),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       'Satyam patel',
          //       style: theme.textTheme.labelMedium?.copyWith(
          //         color: appColors.white,
          //         letterSpacing: 1,
          //         fontWeight: FontWeight.w700,
          //         fontSize: height / 26,
          //       ),
          //     ),
          //     Text(
          //       '+91 7011005499',
          //       style: theme.textTheme.labelMedium?.copyWith(
          //         color: appColors.white,
          //         letterSpacing: 1,
          //         fontWeight: FontWeight.w200,
          //         fontSize: height / 30,
          //       ),
          //     ),
          //     Text(
          //       'patelsatyam267@gmail.com',
          //       style: theme.textTheme.labelMedium?.copyWith(
          //         color: appColors.white,
          //         letterSpacing: 1,
          //         fontWeight: FontWeight.w200,
          //         fontSize: height / 30,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
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
}
