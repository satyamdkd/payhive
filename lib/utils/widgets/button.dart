import 'package:flutter/material.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

Widget customButton(
    {required title,
    required context,
    bool loading = false,
    textColor,
    double? passedHeight,
    double? passedWidth,
    List<Color>? gradColor,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: passedHeight ?? MediaQuery.sizeOf(context).height / 15,
      width: passedWidth ?? MediaQuery.sizeOf(context).width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 40.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          stops: const [-1, 2.0],
          colors: gradColor ??
              [
                appColors.primaryLight,
                appColors.primaryColor,
              ],
        ),
      ),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: appColors.white,
          fontSize: passedHeight != null ? passedHeight / 2.8 : height / 28,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
  );
}
