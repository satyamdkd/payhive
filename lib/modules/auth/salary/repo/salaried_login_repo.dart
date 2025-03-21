import 'dart:io';

import 'package:dio/dio.dart';
import 'package:payhive/constants/urls.dart';
import 'package:payhive/services/network/api_result.dart';
import 'package:payhive/services/network/network.dart';

class SalariedLoginRepo {
  Network network = Network();

  Future<ApiResults> login({
    required String step,
    required File? profile,
    required String? mobile,
    required String? otp,
    required String? email,
    required String? emailotp,
    required String? accountType,
    required String? gstpan,
    required String? turnover,
    required String? aadhar,
    required String? fcmToken,
  }) async {
    FormData formData = FormData.fromMap(
      {
        "step": step,
        'mobile': mobile,
        'otp': otp,
        'email': email,
        'emailotp': emailotp,
        'account_type': accountType,
        'gstpan': gstpan,
        'turnover': turnover,
        'aadhar': aadhar,
        "profile": profile != null && profile.path != ''
            ? await MultipartFile.fromFile(
                profile.path,
                filename: 'profile${".${profile.path.split('.').last}"}',
              )
            : "",
        "fcm_token": fcmToken.toString()
      },
    );

    return await network.postDataWithFilesNew(
      endPoint: URLs.loginOrRegister,
      formData: formData,
    );
  }

  Future<ApiResults> userData({mobileNumber}) async {
    return await network.getData(
      endPoint: URLs.getUserData,
      queryParameters: {'mobileno': mobileNumber.toString()},
    );
  }

  Future<ApiResults> getAnnualIncome() async {
    return await network.getData(
      endPoint: URLs.getUserDropDown,
      queryParameters: {'type': 'salaried'},
    );
  }
}
