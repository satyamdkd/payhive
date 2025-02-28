import 'package:flutter/material.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

Widget customButton({
  required title,
  required context,
  bool loading = false,
  textColor,
  double? passedHeight,
  double? passedWidth,
  void Function()? onTap
}) {
  return GestureDetector(

    onTap: onTap,
    child: Container(
      height: passedHeight ?? MediaQuery.sizeOf(context).height / 15,
      width: passedWidth ?? MediaQuery.sizeOf(context).width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          stops: const [-1, 2.0],
          colors: [
            appColors.primaryLight,
            appColors.primaryColor,
          ],
        ),
      ),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: appColors.white,
          fontSize: height / 28,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
  );
}
