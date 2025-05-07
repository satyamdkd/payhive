import 'package:flutter/material.dart';
import 'package:payhive/constants/urls.dart';
import 'package:payhive/services/network/api_result.dart';
import 'package:payhive/services/network/network.dart';

import '../di/di.dart';

class UserToken {
  static refreshToken() async {
    try {
      final response = await Network().getData(endPoint: URLs.token);

      switch (response) {
        case ApiSuccess():
          final newToken = response.data['access_token'];
          sharedPref.saveToken(myToken: newToken);
          debugPrint('TOKEN REFRESHED SUCCESSFULLY');
          break;

        case ApiFailure():
          debugPrint('TOKEN REFRESHED FAILED ${response.message}');
          break;

        default:
          debugPrint('UNEXPECTED RESPONSE');
      }
    } catch (e) {
      debugPrint('Error during token refresh: $e');
    } finally {
      final tokenMap = await sharedPref.getToken();
      token = tokenMap.toString();
      debugPrint('USER TOKEN FROM REFRESH API : $token');
    }
  }
}
