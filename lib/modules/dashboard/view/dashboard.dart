import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/dashboard/controller/dashboard_controller.dart';
import 'package:payhive/modules/dashboard/view/screens/wallet.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/image_builder.dart';

import 'screens/home.dart';

class Dashboard extends GetView<DashBoardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: appColors.bgColorHome,
      body: GetBuilder(
          init: controller,
          builder: (ctx) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (controller.scrollController.position.pixels > 0) {
                  controller.hideTitle.value = false;
                } else {
                  controller.hideTitle.value = true;
                }

                return true;
              },
              child: CustomScrollView(
                controller: controller.scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  appBar(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => body(context),
                        childCount: 1),
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: buildNavBar(),
    );
  }

  Widget body(context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: IgnorePointer(
            ignoring: true,
            child: Image.asset(
              "assets/images/home_flare.png",
              width: width,
              height: height / 1.75,
            ),
          ),
        ),

        Container(
          height: MediaQuery.sizeOf(context).height - height / 2.84,
          alignment: Alignment.center,
          child: Text(
            "Account Set-up Completed\n\n",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.textDark.withOpacity(0.4),
              fontWeight: FontWeight.w300,
              fontSize: height / 20,
            ),
          ),
        ),

        /// Home(),
      ],
    );
  }

  buildNavBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          stops: const [-1, 2.0],
          colors: [
            appColors.primaryColor,
            appColors.primaryLight,
          ],
        ),
      ),
      padding: EdgeInsets.only(top: height / 82),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          elevation: 10,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: appColors.textExtraLight,
            fontSize: height / 80,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
              color: appColors.textExtraLight,
              fontSize: height / 80,
              fontWeight: FontWeight.w500),
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: appColors.black,
          selectedItemColor: appColors.black,
          onTap: (index) {
            controller.bottomNavPressed(index);
          },
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                "assets/icons/home_grey.png",
                height: height / 19,
                color: appColors.black.withOpacity(0.5),
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                "assets/icons/wallet_grey.png",
                height: height / 19,
                color: appColors.black.withOpacity(0.5),
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                "assets/icons/add_button.png",
                height: height / 19,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                "assets/icons/msg_grey.png",
                height: height / 19,
                color: appColors.black.withOpacity(0.5),
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                "assets/icons/profile_grey.png",
                height: height / 19,
                color: appColors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: appColors.primaryColor,
      expandedHeight: height / 4.6,
      floating: false,
      pinned: true,
      forceElevated: true,
      stretch: true,
      title: Obx(
        () => !controller.hideTitle.value
            ? Padding(
                padding: EdgeInsets.only(
                  bottom: width / 30,
                  right: width / 30,
                ),
                child: Row(
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: appColors.white,
                          borderRadius: BorderRadius.circular(1000.0),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          height: height / 14,
                          width: height / 14,
                          child: Image.asset(
                            "assets/icons/logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ).animate().fade(duration: 200.ms).scale(delay: 200.ms),
                    SizedBox(width: width / 60),
                    Text(
                      "Pay Hive",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: appColors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: height / 22,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: appColors.primaryColor),
            Image.asset(
              'assets/images/flare_two.png',
              fit: BoxFit.fitHeight,
            ),
            Container(
              margin: EdgeInsets.only(
                left: width / 30,
                bottom: width / 30,
                right: width / 30,
              ),
              alignment: Alignment.bottomLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: imageBuilder(
                          'https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg',
                          height: height / 8,
                          width: height / 8,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: width / 30),
                      Text(
                        "Hi, Neeraj Kumar",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: appColors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: height / 24,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/wallet.png',
                        scale: 4,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Image.asset(
                        'assets/images/notification.png',
                        scale: 3.6,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Image.asset(
                        'assets/images/support.png',
                        scale: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///        Positioned(
///           bottom: height / 9,
///           child: Image.asset(
///             "assets/icons/bottom_nav_selected.png",
///             width: 30,
///             height: 30,
///           ),
///         ),
