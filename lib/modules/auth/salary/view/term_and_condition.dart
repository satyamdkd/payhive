import 'package:flutter/material.dart';
import 'package:payhive/services/di/di.dart';
import 'package:payhive/utils/theme/apptheme.dart';

class TermAndCondition extends ModalRoute<void> {
  TermAndCondition();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.2);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation animation,
    Animation secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  String termText =
      '''TERMS OF USE OF PLATFORM\nThis is a legal agreement (hereinafter referred to as “Terms of Use”) between you (the person accessing, viewing, or otherwise using the Platform (as defined hereinafter), and hereinafter referred to as “You”, “Your”, “Yourself” or “User” as per the context) and COST PRICE DISCOUNT STORES PVT LTD [PAYLIX] Limited, a company incorporated under the Companies Act, 1956 having its registered office located at [Address Removed as Requested], or any of its subsidiaries which term shall include its Affiliates, permitted assigns, and successors (hereinafter referred to as “COST PRICE DISCOUNT STORES PVT LTD [PAYLIX]”, “We”, “Our” or “Us”).These Terms of Use set forth the legally binding terms and conditions for Your use of the Platform. By accessing or using this Platform, You agree to be bound by these Terms of Use, Privacy Policy (as defined below), Terms of Sale for Sellers (as defined below), or Terms of Sale for Buyers (as defined below) as applicable, and such other agreements (hereinafter referred to as “Agreements”) as may be adopted by Us from time to time.

1. GENERAL
1.1 The Platform is owned and operated by COST PRICE DISCOUNT STORES PVT LTD [PAYLIX].
1.2 If You transact on the Platform, You shall be subject to the Agreements applicable to the Platform for such Transaction. By using the Platform, You shall be contracting with COST PRICE DISCOUNT STORES PVT LTD [PAYLIX], and these Terms of Use, including the Agreements, constitute Your binding obligations.''';

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
        child: Container(
      height: MediaQuery.of(context).size.height / 1.7,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.2,
        width: MediaQuery.of(context).size.width / 1.11,
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width / 20,
            left: MediaQuery.of(context).size.width / 20,
            right: MediaQuery.of(context).size.width / 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.width / 20),
            bottomRight:
                Radius.circular(MediaQuery.of(context).size.width / 20),
            bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 20),
            topRight: Radius.circular(MediaQuery.of(context).size.width / 20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\nTERM & CONDITION",
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: appColors.primaryColor,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 60),
              Text(
                termText,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: appColors.primaryColor,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 40),
              Align(
                alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: InkWell(
                    onTap: () async {
                      salariedController.isTermChecked.value = true;
                      salariedController.update();
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: appColors.primaryColor,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 60)),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 40,
                          vertical: MediaQuery.of(context).size.width / 120),
                      child: Text(
                        " DONE  ",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: appColors.white,
                            fontFamily: "Inter",
                            fontSize: MediaQuery.of(context).size.height / 58),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    /// const begin = Offset(0, -1.0);
    /// const end = Offset.zero;
    /// const curve = Curves.ease;
    /// final tween = Tween(begin: begin, end: end);
    /// final curvedAnimation = CurvedAnimation(
    ///   parent: animation,
    ///   curve: curve,
    /// );
    /// return FadeTransition(
    ///     opacity: animation,
    ///     child: SlideTransition(
    ///       position: tween.animate(curvedAnimation),
    ///       child: child,
    ///     )
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
