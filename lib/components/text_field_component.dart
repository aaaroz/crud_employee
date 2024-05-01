import 'package:flutter/material.dart';

import '../theme/color.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final String hintText;
  final TextStyle hinstStyle;
  final bool? obscureText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  const TextFieldComponent({
    super.key,
    this.controller,
    this.obscureText,
    this.suffixIcon,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    required this.hinstStyle,
    this.textInputType,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
      onChanged: onChanged,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: grey200,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: grey500,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: negative,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        errorStyle: regular8Negative,
        hintText: hintText,
        hintStyle: hinstStyle,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 24,
                color: grey200,
              )
            : null,
        suffixIcon: suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
