import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhive/utils/helper/text_capitalization.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/snackbar.dart';
import 'package:quickalert/quickalert.dart';

successDialog({required context, title, message, void Function()? onTap}) {
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

  return QuickAlert.show(
    context: context,
    title: title ?? 'Congrats!',
    borderRadius: height / 20,
    confirmBtnColor: appColors.primaryColor,
    confirmBtnText: "Done",
    text: mes,
    type: QuickAlertType.success,
    onConfirmBtnTap: onTap ??
        () {
          Get.back();
        },
    barrierDismissible: false,
  );
}

errorDialog({required context, title, message, void Function()? onTap}) {
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

  return QuickAlert.show(
    context: context,
    title: title ?? 'Oops!',
    borderRadius: height / 20,
    confirmBtnColor: appColors.red,
    confirmBtnText: "Close",
    text: mes,
    type: QuickAlertType.error,
    onConfirmBtnTap: onTap ??
        () {
          Get.back();
        },
    barrierDismissible: false,
  );
}

warningDialog({required context, title, message, void Function()? onTap}) {
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

  return QuickAlert.show(
    context: context,
    title: title ?? 'Waring!',
    borderRadius: height / 20,
    confirmBtnColor: Colors.orange,
    confirmBtnText: "Close",
    text: mes,
    type: QuickAlertType.warning,
    onConfirmBtnTap: onTap ??
        () {
          Get.back();
        },
    barrierDismissible: false,
  );
}
