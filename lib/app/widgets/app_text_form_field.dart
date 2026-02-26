import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_typography.dart';

typedef TextFormValidator = String? Function(String?)?;

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.initialValue,
    this.validator,
    this.obscureText = false,
    this.hintText,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.prefix,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final TextFormValidator validator;
  final bool obscureText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      style: bodyLargeRegular.copyWith(color: AppColor.neutral900),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColor.semanticInfo200,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColor.semanticError200,
            width: 2.0,
          ),
        ),
        hintText: hintText,
        errorStyle: bodyLargeRegular.copyWith(color: AppColor.semanticError200),
        hintStyle: bodyLargeRegular.copyWith(color: AppColor.neutral900),
        prefixIcon: prefixIcon,
        prefix: prefix,
        suffixIcon: suffixIcon,
        suffix: suffix,
      ),
    );
  }
}

class PhoneNumberPrefix extends StatelessWidget {
  const PhoneNumberPrefix({super.key, required this.phoneCountryCode});

  final String phoneCountryCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 12.0, top: 12, end: 12),
      margin: const EdgeInsets.only(left: 2, right: 10),
      decoration: const BoxDecoration(
        color: AppColor.neutral100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Text(
        phoneCountryCode,
        style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
      ),
    );
  }
}
