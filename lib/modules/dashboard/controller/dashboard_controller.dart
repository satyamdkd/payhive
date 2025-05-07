import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/constants/urls.dart';
import 'package:payhive/modules/dashboard/repo/dashboard_repo.dart';
import 'package:payhive/services/di/di.dart';
import 'package:payhive/services/network/api_result.dart';
import 'package:payhive/services/network/token.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/error.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DashBoardController extends GetxController {

  DashboardRepo? repo;

  RxDouble toolbarOpacity = 0.0.obs;

  void handleScroll() {
    final double offset = scrollController.offset;
    toolbarOpacity.value = offset;
    update();
  }

  onBackButton() async {
    if (bottomNavIndex.value != 0) {
      bottomNavIndex.value = 0;
    } else {
      exit(0);
    }
    update();
  }

  setToken() async {
    var tokenMap = await sharedPref.getToken();
    token = tokenMap.toString();
    debugPrint('USER TOKEN FROM DASHBOARD: $token');
    Future.delayed(const Duration(milliseconds: 500), () async {
      await UserToken.refreshToken();

      repo = DashboardRepo();

      await dashboardApi();
      await getUserData();
    });
  }

  @override
  void onInit() {
    super.onInit();
    setToken();

    scrollController.addListener(handleScroll);

    Future.delayed(const Duration(seconds: 1), () {
      Get.snackbar(
        "",
        "Please add your bank",
        borderRadius: 16,
        margin: EdgeInsets.only(
          bottom: width / 40,
          left: width / 40,
          right: width / 40,
        ),
        padding: EdgeInsets.only(bottom: height / 16),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3600),
        backgroundColor: appColors.primaryColor,
        titleText: null,
        isDismissible: false,
        messageText: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: height / 20.0,
                  right: height / 20.0,
                  bottom: height / 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Pending KYC",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: appColors.white,
                      fontSize: height / 32,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: width / 1.6,
                    child: Text(
                      "Your bank KYC & Address verification is pending, please verify to complete the account setup.",
                      maxLines: null,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: appColors.white,
                        fontSize: height / 40,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.closeAllSnackbars();
                },
                child: Container(
                  width: width / 7,
                  height: height / 16,
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
                    "Close",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: appColors.white,
                      fontSize: height / 36,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ))
          ],
        ),
      );
    });

    getHomePageData();
  }

  RxBool dashboardLoading = false.obs;
  RxBool isPosAssigned = false.obs;
  RxString walletAmount = "0.0".obs;

  dashboardApi() async {
    try {
      dashboardLoading.value = true;
      update();

      final response = await repo!.getDashboardData();

      if (response is ApiSuccess) {
        isPosAssigned.value = response.data['data']['posassignuser'];
        walletAmount.value = response.data['data']['userwallet'].toString();
        marginPerTransaction =
            response.data['data']['margin_per_trans'].toString();
      } else if (response is ApiFailure) {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      dashboardLoading.value = false;
      update();
    }
  }

  int count = 0;
  final ScrollController scrollController = ScrollController();

  getHomePageData() async {}
  RxBool hideTitle = true.obs;
  RxInt bottomNavIndex = 0.obs;

  bottomNavPressed(index) async {
    bottomNavIndex.value = index;
    dashboardApi();
    if (bottomNavIndex.value == 0) {}
    if (bottomNavIndex.value == 1) {
      walletHistory();
    }
    if (bottomNavIndex.value == 2) {}
    if (bottomNavIndex.value == 3) {}
    if (bottomNavIndex.value == 4) {}

    update();
  }

  Map<String, dynamic>? userDetails;

  List addressList = [];

  setAddress(list) async {
    debugPrint(list.toString());
    addressList = [];
    if (list != null && list != []) {
      addressList = list;
    }

    update();
  }

  RxBool isLoadingUserData = false.obs;
  String? phone;

  getUserData() async {
    try {
      if (await sharedPref.getTempMobile() != null) {
        phone = await sharedPref.getTempMobile();
      }

      isLoadingUserData.value = true;
      update();
      final response = await repo!.userData(mobileNumber: phone);

      if (response is ApiSuccess) {
        final data = response.data;
        userDetails = data;
        setAddress(data['data']['address']);
      } else if (response is ApiFailure) {
        debugPrint(response.message.toString());
      } else {
        debugPrint(response.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingUserData.value = false;
      update();

      if (userDetails != null) {
        userName = "${userDetails?['data']['name'] ?? ''}".split(' ').first;
        phoneNumber = "${userDetails?['data']['phone'] ?? ''}";
        userEmail = "${userDetails?['data']['email'] ?? ''}";
      }
    }
  }

  RxBool personalDetailsOpen = false.obs;
  RxBool personalDetailsOpenForChildWidget = false.obs;

  RxBool userAddressOpen = false.obs;
  RxBool userAddressForChildWidget = false.obs;

  RxBool aboutPayLixOpen = false.obs;
  RxBool aboutPayLixForChildWidget = false.obs;

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// ------------------------------- Wallet -----------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RxBool walletHistoryLoading = false.obs;

  Map<String, dynamic>? walletHistoryRes;

  walletHistory() async {
    try {
      walletHistoryLoading.value = true;
      update();

      final response = await repo!.getWalletHistory();

      if (response is ApiSuccess) {
        walletHistoryRes = response.data;
      } else if (response is ApiFailure) {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      walletHistoryLoading.value = false;
      update();
    }
  }

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// ------------------------------ ADD MONEY ---------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  String orderId = '';

  generateOrderId(context) async {
    try {
      isLoadingUserData.value = true;
      update();
      final response = await repo!.generateOrderId(addMoneyAmount.text);

      if (response is ApiSuccess) {
        final data = response.data;
        finalAmount =
            double.parse(data['data']['details']['amount'].toString());
        orderId = data['data']['order_id'];
        debugPrint(orderId.toString());
      } else if (response is ApiFailure) {
        debugPrint(response.message.toString());
      } else {
        debugPrint(response.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      initialisePaymentViaRazorPay(addMoneyAmount.text, context);
    }
  }

  int popUpCount = 0;

  var selectedCategory = 0.obs;
  var selectedSettlement = 1.obs;

  final FocusNode focusNode = FocusNode();

  void removeFocus() {
    focusNode.unfocus();
  }

  TextEditingController addMoneyAmount = TextEditingController();

  validateAddMoney(context) async {
    if (addMoneyAmount.text.isEmpty) {
      errorDialog(
        context: context,
        message: 'Please enter the amount to be added to your wallet.',
        title: 'Enter amount',
      );
    } else if (double.parse(addMoneyAmount.text.toString()) < 1000) {
      errorDialog(
        context: context,
        message:
            'Please enter an amount that is greater than or equal to 1000.',
        title: 'Add money',
      );
    } else {
      await generateOrderId(context);
    }
  }

  Razorpay razorpay = Razorpay();
  double finalAmount = 0;
  initialisePaymentViaRazorPay(amount, context) async {
    popUpCount = 0;

    var options = {
      'name': 'Paylix',
      'key': URLs.axisKeyTest,
      'amount': finalAmount,
      'order_id': orderId.toString(),
      'description': 'Add money to your paylix wallet.',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'readonly': {
        'contact': true,
        'email': true,
        'name': true,
      },
      'prefill': {
        'contact': phoneNumber.toString(),
        'email': userEmail.toString()
      },
      "checkout": {
        "method": {
          "card": "1",
          "upi": "0",
        }
      }
    };

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      handlePaymentErrorResponse(response, context);
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      handlePaymentSuccessResponse(response, context);
    });
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      handleExternalWallet(response, context);
    });
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(
      PaymentFailureResponse response, context) async {
    /*
    * Payment Failure Response contains three values:
    * 1. Code
    * 2. Message
    * 3. Error
    */

    debugPrint(response.code.toString());
    debugPrint(response.message.toString());
    debugPrint(response.error.toString());

    if (popUpCount == 0) {
      popUpCount++;

      errorDialog(
          context: context,
          message: 'Your payment is failed\n${response.message}',
          title: 'Payment failed',
          onTap: () {
            addMoneyAmount.clear();
            Get.back();
          });
      Future.delayed(const Duration(milliseconds: 500), () async {
        sendPaymentDetailToServer(context, 'failure');
      });
    }
  }

  String? orderIdReceivedFromRazor;
  String? paymentIDReceivedFromRazor;
  String? signatureReceivedFromRazor;

  void handlePaymentSuccessResponse(
      PaymentSuccessResponse response, context) async {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    */

    debugPrint(response.orderId.toString());
    debugPrint(response.paymentId.toString());
    debugPrint(response.signature.toString());
    debugPrint(response.data.toString());

    orderIdReceivedFromRazor = response.orderId.toString();
    paymentIDReceivedFromRazor = response.paymentId.toString();
    signatureReceivedFromRazor = response.signature.toString();
    if (popUpCount == 0) {
      popUpCount++;

      successDialog(
        context: context,
        message:
            'payment is successfully received. your order id is : $orderIdReceivedFromRazor',
        title: 'Payment Done',
        onTap: () {
          addMoneyAmount.clear();
          Get.back();
        },
      );
      Future.delayed(const Duration(milliseconds: 500), () async {
        sendPaymentDetailToServer(context, 'success');
      });
    }
  }

  void handleExternalWallet(ExternalWalletResponse response, context) {
    debugPrint('External Wallet is ${response.walletName.toString()}');
  }

  sendPaymentDetailToServer(context, status) async {
    try {
      final response = await repo!.sendPaymentDetails(
        amount: addMoneyAmount.text,
        orderId: orderId.toString(),
        paymentId: paymentIDReceivedFromRazor,
        paymentCat: selectedCategory.value == 1 ? 'Non-Utilities' : 'Utilities',
        settlementType: selectedSettlement.value == 0
            ? 'Instant'
            : selectedSettlement.value == 1
                ? 'T+1'
                : 'T+5',
        status: status,
      );

      if (response is ApiSuccess) {
        final data = response.data;
        if (data['data']['status'] == 1) {}
      } else if (response is ApiFailure) {
        debugPrint(response.message.toString());
      } else {
        debugPrint(response.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
