import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/pay_vendor/model/beneficiary_list.dart';
import 'package:payhive/modules/pay_vendor/repo/vendor_pay_repo.dart';
import 'package:payhive/modules/pay_vendor/view/add_beneficiary.dart';
import 'package:payhive/modules/pin/pin.dart';
import 'package:payhive/services/di/di.dart';
import 'package:payhive/services/network/api_result.dart';
import 'package:payhive/utils/helper/text_capitalization.dart';
import 'package:payhive/utils/widgets/error.dart';
import 'package:payhive/utils/widgets/snackbar.dart';

class VendorPaymentController extends GetxController {
  VendorPayRepo repo = VendorPayRepo();

  @override
  void onInit() {
    super.onInit();
    getAllBeneficiaryList();
  }

  RxBool isLoadingBeneficiaries = false.obs;

  BeneficiaryListModel? beneficiaryListModel;
  List<Item> beneficiaryList = [];

  getAllBeneficiaryList() async {
    beneficiaryListModel = null;
    beneficiaryList = [];
    tempList = [];
    isLoadingBeneficiaries.value = true;
    update();

    try {
      final response = await repo.getBeneficiaryList();

      if (response is ApiSuccess) {
        final data = response.data;
        beneficiaryListModel = BeneficiaryListModel.fromJson(data);

        if (data['status'] == 1) {
          if (response.data['data'] != null && response.data['data'] != []) {
            for (int i = 0; i < response.data['data'].length; i++) {
              beneficiaryList.add(beneficiaryListModel!.item![i]);
              tempList.add(beneficiaryListModel!.item![i]);
            }
          }
        } else {}
      } else if (response is ApiFailure) {
        showSnackBar(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(message: 'Something went wrong');
    } finally {
      isLoadingBeneficiaries.value = false;
      update();
    }
  }

  List<Item> tempList = [];

  TextEditingController searchedText = TextEditingController();

  onSearchTextChanged(String text) async {
    beneficiaryList.clear();
    if (text.isEmpty) {
      beneficiaryList.addAll(tempList);

      update();
      return;
    }

    for (var userDetail in tempList) {
      if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
        beneficiaryList.add(userDetail);
      }
    }

    if (kDebugMode) {
      print(beneficiaryList);
    }

    update();
  }

  deleteBeneficiary(context, id) async {
    isLoadingBeneficiaries.value = true;
    update();

    try {
      final response = await repo.deleteBeneficiary(id);

      if (response is ApiSuccess) {
        final data = response.data;

        isLoadingBeneficiaries.value = false;
        update();

        if (data['status'] == 1) {
          successDialog(
            context: context,
            message: data['msg'],
            title: 'Delete Beneficiary',
            onTap: () {
              Get.back();
              getAllBeneficiaryList();
            },
          );
        } else {
          _showError(context: context, message: data['msg']);
        }
      } else if (response is ApiFailure) {
        _showError(context: context, message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
      _showError(context: context, message: 'Something went wrong');
    }
  }

  RxBool confirmBankVisible = false.obs;

  TextEditingController ifsc = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController reason = TextEditingController();

  validateBeneficiaryForm({context}) {
    if (accountNumber.text.trim().isEmpty) {
      errorDialog(
        context: context,
        message: 'Kindly enter your bank account number',
        title: 'Bank account',
      );
    } else if (ifsc.text.isEmpty) {
      errorDialog(
        context: context,
        message: 'Kindly enter IFSC code.',
        title: 'IFSC code',
      );
    } else if (phone.text.trim().isEmpty) {
      errorDialog(
        context: context,
        message: 'Kindly enter your phone number',
        title: 'Phone number',
      );
    } else if (phone.text.trim().length != 10) {
      errorDialog(
        context: context,
        message: 'Kindly enter valid phone number',
        title: 'Phone number',
      );
    } else {
      addBeneficiary(context: context);
    }
  }

  RxBool isAddingBeneficiary = false.obs;

  Map<String, dynamic>? responseOfAddBeneficiary;
  addBeneficiary({context, bool isReasonAvailable = false, id}) async {
    isAddingBeneficiary.value = true;
    update();
    try {
      final response = await repo.addBeneficiary(
          ifsc: ifsc.text,
          accountNumber: accountNumber.text,
          phone: phone.text,
          reason: reason.text,
          id: id);

      if (response is ApiSuccess) {
        final data = response.data;

        if (data['status'] == 1) {
          isAddingBeneficiary.value = false;
          update();

          if (isReasonAvailable == true) {
            successDialog(
              context: context,
              message:
                  "${capitalizeFirstCharacter(responseOfAddBeneficiary?['data']['name'])} has been successfully added as beneficiary.",
              title: "Add Beneficiary",
              onTap: () {
                Get.back();
                Get.back();
              },
            );
          } else {
            responseOfAddBeneficiary = data;
            confirmBankVisible.value = true;
            update();
          }
        } else {
          _showError(context: context, message: data['msg']);
        }
      } else if (response is ApiFailure) {
        _showError(context: context, message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
      _showError(context: context, message: 'Something went wrong');
    } finally {
      isAddingBeneficiary.value = false;
      update();
    }
  }

  _showError({required context, required String message}) {
    errorDialog(context: context, message: message);
  }

  onTapAddBeneficiaryButton() {
    confirmBankVisible.value = false;
    accountNumber.clear();
    ifsc.clear();
    phone.clear();
    reason.clear();

    Get.to(
      () => const AddBeneficiary(),
      transition: Transition.downToUp,
      duration: const Duration(seconds: 1),
    )!
        .then((v) {
      getAllBeneficiaryList();
    });
  }

  Item? payeeDetails;

  TextEditingController amount = TextEditingController();

  validateTransfer(context) async {
    if (amount.text.isEmpty) {
      errorDialog(
        context: context,
        message: 'Please enter amount',
        title: 'Transfer amount',
      );
    } else {
      pinController.clear();
      pinBottomSheet(context);
    }
  }

  TextEditingController pinController = TextEditingController();

  RxBool isLoadingTransfer = false.obs;

  validatePIN() {
    String first = pinController.text;
    String second = phoneNumber;

    String lastFourFirst =
        first.length >= 4 ? first.substring(first.length - 4) : first;
    String lastFourSecond =
        second.length >= 4 ? second.substring(second.length - 4) : second;

    return lastFourFirst == lastFourSecond;
  }

  transferMoney(context) async {
    if (validatePIN()) {
      isLoadingTransfer.value = true;
      update();

      try {
        final response = await repo.transferMoneyToVendor(
          amount:
              '${double.parse(amount.text.toString()) + double.parse(marginPerTransaction)}',
          id: payeeDetails!.fundAccountId.toString(),
        );

        if (response is ApiSuccess) {
          final data = response.data;

          if (data['status'] == 1) {
            successDialog(
                context: context,
                message: data['msg'],
                onTap: () {
                  Get.back();
                  Get.back();
                  Get.back();
                });
          } else {
            _showError(context: context, message: data['msg']);
          }
        } else if (response is ApiFailure) {
          _showError(context: context, message: response.message);
        }
      } catch (e) {
        debugPrint(e.toString());
        _showError(context: context, message: 'Something went wrong');
      } finally {
        isLoadingTransfer.value = false;
        update();
      }
    } else {
      errorDialog(
          context: context,
          message: "Please enter correct PIN",
          title: "Incorrect PIN");
    }
  }
}
