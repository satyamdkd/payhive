import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/utils/helper/text_capitalization.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

String removeWord(String input, String wordToRemove) {
  return input.replaceAll(wordToRemove, '').trim();
}

showSnackBar(
    {title, required message, color, Duration? duration, double? bottom}) {
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
    borderRadius: 16,
    margin: EdgeInsets.only(
      top: bottom ?? height / 1.2,
      left: width / 40,
      right: width / 40,
    ),
    padding: EdgeInsets.only(bottom: height / 16),
    snackPosition: SnackPosition.TOP,
    duration: duration ?? const Duration(seconds: 1),
    backgroundColor: color ?? appColors.primaryColor,
    titleText: null,
    messageText: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: height / 20.0, right: height / 20.0, bottom: height / 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title ?? "PayLix",
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
                  "$mes",
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
        ),
      ],
    ),
  );
}
