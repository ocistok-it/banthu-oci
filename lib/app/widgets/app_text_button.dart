import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_typography.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
    this.height = 48.0,
    this.width = double.infinity,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final double height, width;

  factory AppTextButton.primary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return AppTextButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColor.brandPrimary400,
      textColor: AppColor.neutral0,
      isLoading: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: onPressed,
      child: Text(text, style: bodyMediumSemiBold.copyWith(color: textColor)),
    );
  }
}
