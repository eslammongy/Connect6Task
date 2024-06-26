import 'package:flutter/material.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:restaurants/core/theme/app_text_style.dart';

class CustomizedTextField extends StatelessWidget {
  const CustomizedTextField({
    super.key,
    this.onSubmitted,
    this.label,
    this.isSearch = true,
    this.keyboardType,
    this.inputAction,
    this.controller,
    this.onChanged,
    this.initialValue,
  });
  final Function(String)? onSubmitted;
  final String? label;
  final bool isSearch;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    controller?.text = initialValue ?? '';
    return Expanded(
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: inputAction ?? TextInputAction.done,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            labelText: label ?? 'Search for a restaurant by name...',
            labelStyle: AppTextStyles.font13GrayRegular.copyWith(fontSize: 13),
            focusedBorder: buildOutlineInputBorder(ColorsManager.mainBlue),
            enabledBorder: buildOutlineInputBorder(ColorsManager.lightGray),
            border: buildOutlineInputBorder(ColorsManager.lightGray),
            prefixIcon: isSearch ? const Icon(Icons.search) : null,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(width: 2.0, color: color),
    );
  }
}
