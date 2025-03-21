import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/camera/face_detector_view.dart';
import 'package:payhive/modules/auth/salary/model/annual_income.dart';
import 'package:payhive/modules/auth/salary/repo/salaried_login_repo.dart';
import 'package:payhive/modules/auth/salary/view/account_type.dart';
import 'package:payhive/modules/auth/salary/view/annual_income.dart';
import 'package:payhive/modules/auth/salary/view/complete_your_kyc.dart';
import 'package:payhive/modules/auth/salary/view/email_verification.dart';
import 'package:payhive/modules/auth/salary/view/success.dart';
import 'package:payhive/routes/pages.dart';
import 'package:payhive/services/di/di.dart';
import 'package:payhive/services/network/api_result.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/snackbar.dart';

import '../view/aadhar_verify.dart';
import '../view/pan_verify_salary.dart';

class SalariedController extends GetxController {
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// ------------------- DISABLE CLICK ON EVERY SCREEN ------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RxBool isLoginScreenDisabled = false.obs;
  RxBool isEmailScreenDisabled = false.obs;
  RxBool isAccountTypeScreenDisabled = false.obs;
  RxBool isAnnualIncomeDisabled = false.obs;
  RxBool isPanScreenDisabled = false.obs;
  RxBool isAadharScreenDisabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  SalariedLoginRepo repo = SalariedLoginRepo();
  getUserData() async {
    if (await sharedPref.getTempMobile() != null) {
      var phone = await sharedPref.getTempMobile();
      mobileController.text = phone!;
      callGetUserDataApi();
    }
  }

  callGetUserDataApi() async {
    try {
      final response = await repo.userData(mobileNumber: mobileController.text);
      if (response is ApiSuccess) {
        final data = response.data;
        if (data['status'] == 1) {
          setUserFilledData(response);
        }
      } else if (response is ApiFailure) {
        debugPrint(response.message.toString());
      } else {
        debugPrint(response.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  setUserFilledData(ApiSuccess response) async {
    emailController.text = response.data['data']['email'] ?? "";
    annualIncomeController.text = response.data['data']['turnover'] ?? "";

    if (response.data['data']['panno'] != null) {
      panController.text = response.data['data']['panno']['pan_number'];
      panDetails = response.data['data']['panno'];
    }
    if (response.data['data']['aadhar'] != null) {}
    navigateToScreen(response.data['data']);
  }

  navigateToScreen(response) async {
    showSnackBar(
      message: "Your verification is pending please complete KYC",
      title: "PayHive",
    );
    await getAnnualIncome();

    if (response['step'] == 2 || response['step'] == 3) {
      isLoginScreenDisabled.value = true;
      Get.to(() => EmailVerification());
    }
    if (response['step'] == 4) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      Get.to(() => AccountType());
    }
    if (response['step'] == 5) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      isAccountTypeScreenDisabled.value = true;
      Get.to(() => const SalariedAnnualIncome());
    }
    if (response['step'] == 6) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      isAccountTypeScreenDisabled.value = true;
      isAnnualIncomeDisabled.value = true;
      Get.to(() => const PanVerifySalary());
    }
    if (response['step'] == 7) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      isAccountTypeScreenDisabled.value = true;
      isAnnualIncomeDisabled.value = true;
      isPanScreenDisabled.value = true;
      Get.to(() => AadharVerifySalaried());
    }
    if (response['step'] == 8) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      isAccountTypeScreenDisabled.value = true;
      isAnnualIncomeDisabled.value = true;
      isPanScreenDisabled.value = true;
      isAadharScreenDisabled.value = true;

      Get.to(() => const FaceDetectorView());
    }
  }

  var formKeyEmail = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController otpControllerEmail = TextEditingController();

  RxBool isOTPShotEmail = false.obs;
  RxBool isEditingEmail = false.obs;
  RxBool isEmailLoading = false.obs;
  RxBool isEmailOTPSubmitLoading = false.obs;

  validateEmailForm() {
    final isValid = formKeyEmail.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      isEditingEmail.value = false;
      otpControllerEmail.clear();
      update();
      salariedAPI(step: '3');
    }

    update();
  }

  verifyEmail() async {}

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// -------------------------------- LOGIN -----------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  termChecked() {
    isTermChecked.value = !isTermChecked.value;
    update();
  }

  var formKeyLogin = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpControllerPhone = TextEditingController();

  RxBool isTermChecked = false.obs;
  RxBool isOTPShotPhone = false.obs;
  RxBool isEditingPhone = true.obs;
  RxBool isPhoneLoading = false.obs;
  RxBool isPhoneOTPSubmitLoading = false.obs;

  validatePhoneForm() {
    final isValid = formKeyLogin.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      if (isTermChecked.value) {
        isEditingPhone.value = false;
        otpControllerPhone.clear();
        update();
        salariedAPI(step: '1');
      } else {
        showSnackBar(
          message: "Term & Condition must be tick",
          title: "PayHive",
          color: appColors.red,
        );
      }
    }

    update();
  }

  File? profilePicture;

  salariedAPI({step}) async {
    if (step == '1') {
      isPhoneLoading.value = true;
      update();
    } else if (step == '2') {
      isPhoneOTPSubmitLoading.value = true;
      update();
    } else if (step == '3') {
      isEmailLoading.value = true;
      update();
    } else if (step == '4') {
      isEmailOTPSubmitLoading.value = true;
      update();
    } else if (step == '5') {
      isAccountTypeLoading.value = true;
      update();
    } else if (step == '6') {
      annualIncomeLoading.value = true;
      update();
    } else if (step == '7') {
      isPanLoading.value = true;
      update();
    } else if (step == '8') {
      isAadharLoading.value = true;
      update();
    } else if (step == '9') {
      isFaceLoading.value = true;
      update();
    }

    try {
      final response = await repo.login(
        step: step,
        mobile: mobileController.text.toString(),
        otp: otpControllerPhone.text.toString(),
        email: emailController.text.toString(),
        emailotp: otpControllerEmail.text.toString(),
        accountType: 'salaried',
        gstpan: panController.text,
        turnover: annualIncomeController.text,
        aadhar: aadharController.text,
        profile: profilePicture,
        fcmToken: fcmToken,
      );

      if (response is ApiSuccess) {
        final data = response.data;
        if (data['status'] == 1) {
          if (step == '1') {
            isOTPShotPhone.value = true;
            update();
          } else if (step == '2') {
            isLoginScreenDisabled.value = true;
            checkWhetherVerificationStepsRemaining(response);
          } else if (step == '3') {
            isLoginScreenDisabled.value = true;
            isOTPShotEmail.value = true;
            update();
          } else if (step == '4') {
            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;
            Get.to(() => AccountType());
          } else if (step.toString() == '5') {
            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;
            isAccountTypeScreenDisabled.value = true;

            await getAnnualIncome();
            Get.to(() => const SalariedAnnualIncome());
          } else if (step.toString() == '6') {
            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;
            isAccountTypeScreenDisabled.value = true;
            isAnnualIncomeDisabled.value = true;

            Get.to(const CompleteYourKYC());
          } else if (step.toString() == '7') {
            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;
            isAccountTypeScreenDisabled.value = true;
            isAnnualIncomeDisabled.value = true;
            setPanDetails(response.data);
          } else if (step.toString() == '8') {
            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;
            isAccountTypeScreenDisabled.value = true;
            isAnnualIncomeDisabled.value = true;
            isPanScreenDisabled.value = true;
          } else if (step.toString() == '9') {
            sharedPref.saveUser(userData: response.data['data']['user']);
            sharedPref.saveToken(myToken: response.data['access_token']);
            sharedPref.clearTempMobile();
            Get.offAll(() => const Success());
          }
        } else {
          _showError(data['msg'], step);
        }
      } else if (response is ApiFailure) {
        _showError(response.message, step);
      }
    } catch (e) {
      _showError("Something went wrong.", step);
    } finally {
      isPhoneLoading.value = false;
      isEmailLoading.value = false;
      isPhoneOTPSubmitLoading.value = false;
      isEmailOTPSubmitLoading.value = false;
      isAccountTypeLoading.value = false;
      annualIncomeLoading.value = false;
      isPanLoading.value = false;
      isAadharLoading.value = false;
      isFaceLoading.value = false;
      update();
    }
  }

  /// IF STEPS REMAINING THEN AFTER OTP MOVE TO NEXT STEP OTHERWISE
  /// LOG IN THE USER AND SEND IT TO DASHBOARD.

  checkWhetherVerificationStepsRemaining(ApiSuccess response) async {
    if (response.data['data']['step'] != 9) {
      sharedPref.saveTempMobile(mobile: mobileController.text);
      setUserFilledData(response);
    } else {
      sharedPref.saveUser(userData: response.data['data']['user']);
      sharedPref.saveToken(myToken: response.data['data']['access_token']);
      sharedPref.clearTempMobile();
      Get.offAllNamed(Routes.dashboard);
    }
  }

  _showError(String message, step) {
    showSnackBar(
      message: message,
      title: "PayHive",
      color: appColors.red,
    );

    if (step == '1') {
      isEditingPhone.value = true;
    }
    if (step == '2') {
      otpControllerPhone.clear();
    }
  }

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// --------------------------------- PAN ------------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RxBool isPanTermChecked = false.obs;
  RxBool isPanLoading = false.obs;

  TextEditingController panController = TextEditingController();
  var formKeyPan = GlobalKey<FormState>();
  Map<String, dynamic>? panDetails;

  setPanDetails(response) async {
    panDetails = response['data']['panno'];
    update();
  }

  validatePanForm() {
    final isValid = formKeyPan.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      if (isPanTermChecked.value) {
        if (panDetails != null) {
          Get.to(() => AadharVerifySalaried());
        } else {
          salariedAPI(step: '7');
        }
      } else if (panDetails != null) {
        Get.to(() => AadharVerifySalaried());
      } else {
        showSnackBar(
            message: 'Please tick the above term',
            title: 'PayHive',
            color: appColors.red);
      }
    }

    update();
  }

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// ------------------------------- AADHAR -----------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Map<String, dynamic>? aadharDetails;
  RxBool isOTPShotAadhar = false.obs;
  TextEditingController aadharOTP = TextEditingController();
  RxBool isAadharLoading = false.obs;
  TextEditingController aadharController = TextEditingController();
  var formKeyAadhar = GlobalKey<FormState>();

  validateAadharForm() {
    final isValid = formKeyAadhar.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      if (aadharDetails != null) {
      } else {
        Get.to(() => const FaceDetectorView());
      }
    }
  }

  RxBool isAccountTypeLoading = false.obs;

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// --------------------------- ANNUAL INCOME --------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RxBool hideSearchList = true.obs;
  RxBool annualIncomeDataLoading = false.obs;
  RxBool annualIncomeLoading = false.obs;

  AnnualIncomeModel? annualIncomeModel;
  List<AnnualTurnover>? annualDataList = [];
  List<String>? annualStringList = [];
  String annualIncomeId = "";

  TextEditingController annualIncomeController = TextEditingController();

  setAnnualIncomeValue(textString) {
    var data =
        annualDataList!.firstWhere((element) => element.value == textString);
    annualIncomeId = data.id.toString();
    update();
  }

  getAnnualIncome() async {
    annualDataList!.clear();
    annualStringList!.clear();
    annualIncomeDataLoading.value = true;
    update();

    try {
      final response = await repo.getAnnualIncome();
      if (response is ApiSuccess) {
        annualIncomeModel = AnnualIncomeModel.fromJson(response.data);
        if (response.data['data']['annual_turnover'] != [] ||
            response.data['data']['annual_turnover'] != null) {
          for (int i = 0;
              i < response.data['data']['annual_turnover'].length;
              i++) {
            annualDataList!.add(AnnualTurnover.fromJson(
                response.data['data']['annual_turnover'][i]));
            annualStringList
                ?.add(response.data['data']['annual_turnover'][i]['value']);
          }
        }

        debugPrint(annualStringList?.length.toString());
      } else if (response is ApiFailure) {
        showSnackBar(
          message: response.message.toString(),
          title: "PayHive",
          color: appColors.red,
        );
      } else {
        error();
      }
    } catch (e) {
      debugPrint(e.toString());
      error();
    } finally {
      annualIncomeDataLoading.value = false;
      update();
    }
  }

  error() {
    showSnackBar(
      message: "Something went wrong!",
      title: "Error",
      color: appColors.red,
    );
  }

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// ------------------------- FACE RECOGNITION -------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RxBool isFaceLoading = false.obs;
}
