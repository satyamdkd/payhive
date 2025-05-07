import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/modules/auth/camera/face_detector_view.dart';
import 'package:payhive/modules/auth/salary/model/annual_income.dart';
import 'package:payhive/modules/auth/salary/repo/salaried_login_repo.dart';
import 'package:payhive/modules/auth/salary/view/account_type.dart';
import 'package:payhive/modules/auth/salary/view/complete_your_kyc.dart';
import 'package:payhive/modules/auth/salary/view/digilocker_aadhar.dart';
import 'package:payhive/modules/auth/salary/view/email_verification.dart';
import 'package:payhive/modules/auth/salary/view/success.dart';
import 'package:payhive/routes/pages.dart';
import 'package:payhive/services/di/di.dart';
import 'package:payhive/services/network/api_result.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/snackbar.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
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
        mobileController.clear();
        debugPrint(response.message.toString());
      } else {
        mobileController.clear();

        debugPrint(response.toString());
      }
    } catch (e) {
      mobileController.clear();

      debugPrint(e.toString());
    }
  }

  setUserFilledData(ApiSuccess response) async {
    emailController.text = response.data['data']['email'] ?? "";
    annualIncomeController.text = response.data['data']['turnover'] ?? "";
    businessTypeController.text = response.data['data']['bussiness_type'] ?? "";
    formOfBusinessController.text =
        response.data['data']['form_bussiness'] ?? "";

    if (response.data['data']['panno'] != null) {
      panController.text = response.data['data']['panno']['pan_number'];
      panDetails = response.data['data']['panno'];
      gstDetails = null;
    }
    if (response.data['data']['gst'] != null) {
      panController.text = response.data['data']['gst']['gst_number'];
      gstDetails = response.data['data']['gst'];
      panDetails = null;
    }
    if (response.data['data']['aadhar'] != null) {
      aadharDetails = response.data['data']['aadhar'];
      aadharController.text = response.data['data']['aadhar']['aadhar'] ?? '';
      aadharMaskedController.text =
          response.data['data']['aadhar']['maskedNumber'] ?? '';
      aadharBase64Image = aadharDetails!['photo'];
      base64ToBytes();
    }
    if (response.data['data']['account_type'] != null) {
      firstTapped.value = true;
      accountTypeIndex = response.data['data']['account_type'] == 'salaried'
          ? 0
          : response.data['data']['account_type'] == 'selfemployed'
              ? 1
              : 2;
    }
    update();
    await navigateToScreen(response.data['data']);
  }

  navigateToScreen(response) async {
    await getAnnualIncome();

    if (response['step'] == 2 || response['step'] == 3) {
      isLoginScreenDisabled.value = true;
      update();
      Get.to(() => EmailVerification());
    }
    if (response['step'] == 4) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      update();

      Get.to(() => AccountType());
    }
    if (response['step'] == 5) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;

      /// isAccountTypeScreenDisabled.value = true;
      update();
      Get.to(() => AccountType());

      /// Get.to(() => const SalariedAnnualIncome());
    }
    if (response['step'] == 6) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      isAccountTypeScreenDisabled.value = true;

      isAnnualIncomeDisabled.value = true;
      update();

      Get.to(() => const PanVerifySalary());
    }
    if (response['step'] == 7) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      isAccountTypeScreenDisabled.value = true;
      isAnnualIncomeDisabled.value = true;
      isPanScreenDisabled.value = true;
      update();

      aadharStep = '1';
      salariedAPI(step: '8');
    }
    if (response['step'] == 8) {
      isLoginScreenDisabled.value = true;
      isEmailScreenDisabled.value = true;
      isAccountTypeScreenDisabled.value = true;
      isAnnualIncomeDisabled.value = true;
      isPanScreenDisabled.value = true;
      isAadharScreenDisabled.value = true;
      update();

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

  RxBool isPhonePermissionGranted = false.obs;
  bool isPermissionGranted = false;

  List<String> fetchedMobileNumbers = [];

  RxBool isIgnoringMobile = true.obs;

  termChecked() {
    isTermChecked.value = !isTermChecked.value;
    update();
  }

  RxString appSignature = "".obs;

  var formKeyLogin = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpControllerPhone = TextEditingController();

  RxBool isTermChecked = false.obs;
  RxBool isOTPShotPhone = false.obs;
  RxBool isEditingPhone = true.obs;
  RxBool isPhoneLoading = false.obs;
  RxBool isPhoneOTPSubmitLoading = false.obs;

  getAppSignature() async {
    if (Platform.isAndroid) {
      appSignature.value = await SmsAutoFill().getAppSignature;
    }
  }

  validatePhoneForm() async {
    final isValid = formKeyLogin.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      if (isTermChecked.value) {
        isEditingPhone.value = false;
        otpControllerPhone.clear();
        update();
        await getAppSignature();
        salariedAPI(step: '1');
      } else {
        showSnackBar(
          message: "Term & Condition must be tick",
          title: "PayLix",
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
        appSignature: appSignature.value,
        otp: otpControllerPhone.text.toString(),
        email: emailController.text.toString(),
        emailotp: otpControllerEmail.text.toString(),
        accountType: accountTypeIndex == 0
            ? 'salaried'
            : accountTypeIndex == 1
                ? 'selfemployed'
                : 'others',
        gstpan: panController.text,
        aadhar: aadharController.text,
        turnover: annualIncomeController.text,
        businessType: businessTypeController.text,
        formOfBusiness: formOfBusinessController.text,
        aadharstep: aadharStep,
        requestId: aadharRequestId,
        profile: profilePicture,
        fcmToken: fcmToken,
      );

      if (response is ApiSuccess) {

        final data = response.data;

        if (step.toString() != '5' &&
            step.toString() != '7' &&
            step.toString() != '8' &&
            step.toString() != '9') {

          showSnackBar(
            message: "${data['msg']}",
            title: "PayLix",
            bottom: step == '1' || step == '2' || step == '3' || step == '4'
                ? height / 1.8
                : height / 1.2,
          );

        }

        if (data['status'] == 1) {
          if (step == '1') {

            await SmsAutoFill().listenForCode();

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

            Future.delayed(const Duration(milliseconds: 1500), () {
              Get.to(() => AccountType());
            });

          } else if (step.toString() == '5') {

            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;

            /// isAccountTypeScreenDisabled.value = true;

            await getAnnualIncome();

            /// Future.delayed(const Duration(milliseconds: 1509), () {
            ///   Get.to(() => const SalariedAnnualIncome());
            /// });

          } else if (step.toString() == '6') {
            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;
            isAccountTypeScreenDisabled.value = true;
            isAnnualIncomeDisabled.value = true;
            Future.delayed(const Duration(milliseconds: 2000), () {
              Get.to(const CompleteYourKYC());
            });
          } else if (step.toString() == '7') {
            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;
            isAccountTypeScreenDisabled.value = true;
            isAnnualIncomeDisabled.value = true;

            setPanGSTDetails(response.data);
          } else if (step.toString() == '8') {
            isLoginScreenDisabled.value = true;
            isEmailScreenDisabled.value = true;
            isAccountTypeScreenDisabled.value = true;
            isAnnualIncomeDisabled.value = true;
            isPanScreenDisabled.value = true;

            if (aadharStep == '2') {
              isAadharScreenDisabled.value = true;
              aadharDetails = data['data']['aadhar'];
              aadharMaskedController.text = aadharDetails!['maskedNumber'];
              aadharBase64Image = aadharDetails!['photo'];

              base64ToBytes();
              update();
              Future.delayed(const Duration(milliseconds: 1500), () {
                Get.offAll(AadharVerifySalaried(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500));
              });
            } else {
              if (data['data']['url'] != null) {
                aadharRequestId = data['data']['id'];
                digiLockerUrl = data['data']['url'];
                update();
                loadAadharUrl(digiLockerUrl);

                /// Future.delayed(const Duration(milliseconds: 1500), () {
                ///   Get.to(() => const DigiLockerAadhar());
                /// });

                Get.offAll(AadharVerifySalaried(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500));
              }
            }
          } else if (step.toString() == '9') {
            debugPrint(
                'USER TOKEN WHEN REGISTER : ${response.data['data']['access_token']}');
            sharedPref.saveTempMobile(mobile: mobileController.text);
            sharedPref.saveUser(userData: response.data['data']['user']);
            sharedPref.saveToken(
                myToken: response.data['data']['access_token']);

            Future.delayed(const Duration(milliseconds: 1500), () {
              Get.offAll(() => const Success());
            });
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

      isFaceLoading.value = false;

      update();
    }
  }

  /// IF STEPS REMAINING THEN AFTER OTP MOVE TO NEXT STEP OTHERWISE
  /// LOG IN THE USER AND SEND IT TO DASHBOARD.

  checkWhetherVerificationStepsRemaining(ApiSuccess response) async {
    debugPrint(
        'USER TOKEN WHEN LOGIN : ${response.data['data']['access_token']}');

    if (response.data['data']['step'] != 9) {
      sharedPref.saveTempMobile(mobile: mobileController.text);
      setUserFilledData(response);
    } else {
      sharedPref.saveTempMobile(mobile: mobileController.text);
      sharedPref.saveUser(userData: response.data['data']['user']);
      sharedPref.saveToken(myToken: response.data['data']['access_token']);
      Get.offAllNamed(Routes.dashboard);
    }
  }

  _showError(String message, step) {
    showSnackBar(
      message: message,
      title: "PayLix",
      color: appColors.red,
    );

    if (step == '1') {
      isEditingPhone.value = true;
    }
    if (step == '2') {
      otpControllerPhone.clear();
    }
    if (step == '8') {
      Get.offAll(AadharVerifySalaried(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500));
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
  Map<String, dynamic>? gstDetails;

  setPanGSTDetails(response) async {
    if (response['data']['gst'] != null) {
      gstDetails = response['data']['gst'];
      panDetails = null;
    } else if (response['data']['panno'] != null) {
      panDetails = response['data']['panno'];
      gstDetails = null;
    }
    update();
  }

  validatePanForm() {
    final isValid = formKeyPan.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      if (isPanTermChecked.value) {
        salariedAPI(step: '7');
      } else {
        showSnackBar(
            message: 'Please tick the above term',
            title: 'PayLix',
            color: appColors.red);
      }
    }

    update();
  }

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// ------------------------------- AADHAR -----------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Uint8List? aadharImageBytes;
  base64ToBytes() {
    final cleanBase64 = aadharBase64Image.contains(',')
        ? aadharBase64Image.split(',').last
        : aadharBase64Image;

    aadharImageBytes = base64.decode(cleanBase64);
    update();
  }

  bool compareWhetherAadharIsSame() {
    String first = aadharController.text;
    String second = aadharMaskedController.text;

    String lastFourFirst = first.length >= 4 ? first.substring(first.length - 4) : first;
    String lastFourSecond = second.length >= 4 ? second.substring(second.length - 4) : second;

    return lastFourFirst == lastFourSecond;
  }

  RxBool aadharReadOnly = false.obs;
  WebViewController? webViewController;

  loadAadharUrl(String url) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (urlChanged) {
          isAadharLoading.value = true;
          update();
        },
        onProgress: (int progress) {
          if (progress == 100) {
            isAadharLoading.value = false;
            update();
          }
        },
        onPageStarted: (String url) {
          isAadharLoading.value = true;
          update();
          debugPrint("url ${url.toString()}");

          if (url
              .toString()
              .contains('https://paylix.in/api/auth/aadhaar?success=True')) {
            aadharStep = '2';
            update();
            salariedAPI(step: '8');
          } else if (url
              .toString()
              .contains('https://paylix.in/api/auth/aadhaar?success=False')) {
            showSnackBar(
              message: 'Aadhar verification failed, please try again.',
              title: 'Aadhar Verification',
            );

            Get.offAll(() => const PanVerifySalary());
          }
        },
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {
          debugPrint("error ${error.toString()}");
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint("web res ${error.url.toString()}");
        },
      ))
      ..loadRequest(Uri.parse(url));
  }

  navigateToPanPageWhenError() {
    Get.offAll(() => const PanVerifySalary());
  }

  Map<String, dynamic>? aadharDetails;

  String aadharBase64Image = '';

  RxBool isOTPShotAadhar = false.obs;
  TextEditingController aadharOTP = TextEditingController();
  RxBool isAadharLoading = false.obs;

  String aadharStep = '1';
  String aadharRequestId = '';
  String digiLockerUrl = '';
  TextEditingController aadharController = TextEditingController();
  TextEditingController aadharMaskedController = TextEditingController();
  var formKeyAadhar = GlobalKey<FormState>();

  validateAadharForm() async {
    final isValid = formKeyAadhar.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      loadAadharUrl(digiLockerUrl);
      Get.offAll(() => const DigiLockerAadhar(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500));
    }
  }

  RxBool isAccountTypeLoading = false.obs;

  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /// --------------------------- ANNUAL INCOME --------------------------------
  /// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RxBool hideSearchListAnnualIncome = true.obs;
  RxBool hideSearchListBusinessType = true.obs;
  RxBool hideSearchListFormOfBusiness = true.obs;
  RxBool annualIncomeDataLoading = false.obs;
  RxBool annualIncomeLoading = false.obs;

  AnnualIncomeModel? annualIncomeModel;
  List<AnnualTurnover>? annualDataList = [];
  List<AnnualTurnover>? businessTypeList = [];
  List<AnnualTurnover>? formOfBusinessList = [];
  List<String>? annualStringList = [];
  List<String>? businessTypeStringList = [];
  List<String>? formOfBusinessStringList = [];
  String annualIncomeId = "";
  String businessTypeId = "";
  String formOfBusinessId = "";

  TextEditingController annualIncomeController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController formOfBusinessController = TextEditingController();

  setAnnualIncomeValue(textString) {
    var data =
        annualDataList!.firstWhere((element) => element.value == textString);
    annualIncomeId = data.id.toString();
    update();
  }

  setBusinessTypeValue(textString) {
    var data =
        businessTypeList!.firstWhere((element) => element.value == textString);
    businessTypeId = data.id.toString();
    update();
  }

  setFormOfBusinessValue(textString) {
    var data = formOfBusinessList!
        .firstWhere((element) => element.value == textString);
    formOfBusinessId = data.id.toString();
    update();
  }

  int accountTypeIndex = -1;
  var accountTypeSetAndHidden = false.obs;
  var firstTapped = false.obs;

  getAnnualIncome() async {
    annualIncomeModel = null;
    annualDataList!.clear();
    annualStringList!.clear();
    businessTypeList!.clear();
    businessTypeStringList!.clear();
    formOfBusinessList!.clear();
    formOfBusinessStringList!.clear();
    annualIncomeDataLoading.value = true;
    update();

    try {
      final response = await repo.getAnnualIncome(
        accountTypeIndex == 0
            ? 'salaried'
            : accountTypeIndex == 1
                ? 'selfemployed'
                : 'others',
      );
      if (response is ApiSuccess) {
        annualIncomeModel = AnnualIncomeModel.fromJson(response.data);
        if (response.data['data']['annual_turnover'] != null &&
            response.data['data']['annual_turnover'] != []) {
          for (int i = 0;
              i < response.data['data']['annual_turnover'].length;
              i++) {
            annualDataList!.add(AnnualTurnover.fromJson(
                response.data['data']['annual_turnover'][i]));
            annualStringList
                ?.add(response.data['data']['annual_turnover'][i]['value']);
          }
        }

        if (response.data['data']['business_type'] != null &&
            response.data['data']['business_type'] != []) {
          for (int i = 0;
              i < response.data['data']['business_type'].length;
              i++) {
            businessTypeList!.add(AnnualTurnover.fromJson(
                response.data['data']['business_type'][i]));
            businessTypeStringList
                ?.add(response.data['data']['business_type'][i]['value']);
          }
        }
        if (response.data['data']['form_of_business'] != null &&
            response.data['data']['form_of_business'] != []) {
          for (int i = 0;
              i < response.data['data']['form_of_business'].length;
              i++) {
            formOfBusinessList!.add(AnnualTurnover.fromJson(
                response.data['data']['form_of_business'][i]));
            formOfBusinessStringList
                ?.add(response.data['data']['form_of_business'][i]['value']);
          }
        }

        debugPrint(annualStringList?.length.toString());
        debugPrint(businessTypeStringList?.length.toString());
        debugPrint(formOfBusinessStringList?.length.toString());
      } else if (response is ApiFailure) {
        showSnackBar(
          message: response.message.toString(),
          title: "PayLix",
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
