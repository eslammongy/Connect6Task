import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:restaurants/core/theme/app_text_style.dart';

/// Returns the style data for a button with specific decoration, padding, and height.
ButtonStyleData buttonStyleData() => ButtonStyleData(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lightGray, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.only(left: 5),
      height: 50,
    );

/// Returns the style data for a dropdown with the specified maximum height, width, padding, decoration, and color.
dropdownStyleData() => const DropdownStyleData(
      maxHeight: 210,
      width: 240,
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: ColorsManager.moreLightGray,
      ),
    );

void displayToastMsg(BuildContext context, String msg,
    {ToastificationType? type}) {
  toastification.show(
    context: context,
    title: Text(
      msg,
      style: AppTextStyles.font14BlueSemiBold.copyWith(color: Colors.white),
    ),
    type: type ?? ToastificationType.info,
    style: ToastificationStyle.simple,
    alignment: Alignment.bottomCenter,
    backgroundColor: type != null ? Colors.red : ColorsManager.mainBlue,
    autoCloseDuration: const Duration(seconds: 2),
  );
}
