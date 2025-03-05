import 'package:flutter/material.dart';
import 'package:payhive/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:payhive/modules/dashboard/view/screens/add_money.dart';
import 'package:payhive/modules/dashboard/view/screens/wallet.dart';
import 'package:payhive/modules/wallet_history/view/wallet_history.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  DashboardBloc? bloc = DashboardBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: appColors.bgColorHome,
      appBar: AppBar(backgroundColor: appColors.primaryColor,),
      body: body(),
      bottomNavigationBar: buildNavBar(),
    );
  }

  Widget body() {
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
        const WalletScreen(),

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
            bloc!.add(BottomNavPressed(index));
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
}

///        Positioned(
///           bottom: height / 9,
///           child: Image.asset(
///             "assets/icons/bottom_nav_selected.png",
///             width: 30,
///             height: 30,
///           ),
///         ),
