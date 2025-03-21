
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/utils/helper/text_capitalization.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

String removeWord(String input, String wordToRemove) {
  return input.replaceAll(wordToRemove, '').trim();
}

showSnackBar({title, required message, color, Duration? duration}) {
  var mes = message.toString().toUpperCase().contains("STATUS 0,")
      ? message.toString().toUpperCase().split("STATUS 0,")[1].trim()
      : message;

  debugPrint(mes.toString());
  mes = mes.toString().trim();
  mes = mes.toString().replaceAll("STATUS 0,", "");
  mes = mes.toString().replaceAll("Validation failed.,", "");
  mes = mes.toString().replaceAll("STATUS 1,", "");
  mes = mes.toString().replaceAll("{status: 0,", "");
  mes = mes.toString().replaceAll("{status: 1,", "");
  mes = mes.toString().replaceAll("data: ", "");
  mes = mes.toString().replaceAll("data", "");
  mes = mes.toString().replaceAll(":", "");
  mes = mes.toString().replaceAll("}", "");
  mes = mes.toString().replaceAll("{", "");

  if (mes.toString().toLowerCase().contains("msg")) {
    String result = removeWord(mes.toString().toLowerCase(), "msg");
    mes = capitalizeFirstCharacter(result.trim());
  } else if (mes.toString().toLowerCase().contains("message")) {
    String result = removeWord(mes.toString().toLowerCase(), "message");
    mes = capitalizeFirstCharacter(result.trim());
  }

  return Get.snackbar(
    "",
    capitalizeFirstCharacter(mes),
    borderRadius: 4,
    margin: EdgeInsets.only(
      bottom: width / 20,
      left: width / 40,
      right: width / 40,
    ),
    borderColor: appColors.white,
    borderWidth: 1,
    padding: EdgeInsets.only(bottom: height / 16),
    snackPosition: SnackPosition.BOTTOM,
    duration: duration ?? const Duration(seconds: 4),
    backgroundColor: color ?? appColors.primaryColor.withOpacity(0.7),
    titleText: null,
    messageText: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: width / 80, vertical: width / 120),
          margin: EdgeInsets.symmetric(horizontal: width / 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: appColors.white,
          ),
          child: Image.asset(
            "assets/icons/logo.png",
            height: height / 20,
            width: height / 20,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title ?? "PayHive",
              
              style: theme.textTheme.bodyLarge?.copyWith(
                color: appColors.white,
                fontSize: height / 32,
                fontFamily: "Inter",
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              width: width / 1.4,
              child: Text(
                "${capitalizeFirstCharacter(mes)}",
                
                maxLines: null,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: appColors.white,
                  fontSize: height / 40,
                  fontFamily: "Inter",
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
