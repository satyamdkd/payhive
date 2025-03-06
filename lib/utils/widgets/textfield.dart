import 'package:flutter/material.dart';
import 'package:payhive/utils/helper/form_validation.dart';
import 'package:payhive/utils/helper/text_capitalization.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

SizedBox spacing({passedHeight}) =>
    SizedBox(height: passedHeight ?? height / 50);

Widget customTextField({
  required textEditingController,
  required title,
  fullTag,
  icon,
  suffixIcon,
  obscureText = false,
  TextInputType? keyboardType,
  bool readOnly = false,
  void Function()? onTap,
  bool isCheckBox = false,
  final String? Function(Object?)? validator,
  suffix,
  prefixIcon,
  prefix,
  inputFormatter,
  onChanged,
  textColor,
  bool border = true,
}) {
  return FormField(
    validator: validator ??
        (value) => FormValidation.nameValidator(textEditingController!.text,
            tag: title, fullTag: fullTag),
    builder: (FormFieldState<Object> field) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            obscureText: obscureText,
            textAlign: TextAlign.justify,
            controller: textEditingController,
            readOnly: readOnly,
            onChanged: onChanged,
            inputFormatters: inputFormatter,
            style: TextStyle(
              decorationThickness: 0.0,
              color: textColor ?? appColors.textDark,
              fontWeight: FontWeight.w400,
              fontSize: height / 28,
            ),
            cursorColor: appColors.primaryColor,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: width / 30),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: theme.textTheme.bodySmall?.copyWith(
                color: appColors.textDark,
                fontSize: height / 54,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width / 50),
                borderSide: border
                    ? BorderSide(
                        color: appColors.black.withOpacity(0.35),
                        width: 0.6,
                      )
                    : BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width / 50),
                borderSide: border
                    ? BorderSide(
                        color: appColors.black.withOpacity(0.35),
                        width: 0.6,
                      )
                    : BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderSide: border
                    ? BorderSide(
                        color: appColors.black.withOpacity(0.35),
                        width: 0.6,
                      )
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(width / 50),
              ),
              hintText: capitalizeFirstCharacter(fullTag ??
                  "Please ${title.toString().contains('Upload') ? "upload" : "enter"} your ${title.toString().split(" ").first}"),
              hintStyle: theme.textTheme.bodySmall?.copyWith(
                color: appColors.textDark.withOpacity(0.5),
                fontSize: height / 28,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: suffixIcon,
              suffix: suffix,
              prefixIcon: prefixIcon,
              prefix: prefix,
            ),
          ),
          if (field.hasError) SizedBox(height: height / 80),
          if (field.hasError)
            Text(
              capitalizeFirstCharacter(field.errorText!),
              textScaler: TextScaler.noScaling,
              style: theme.textTheme.bodySmall?.copyWith(
                color: appColors.red,
              ),
            ),
        ],
      );
    },
  );
}
