import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_typography.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = AppColor.brandPrimary400,
    this.textColor = AppColor.neutral0,
    this.isLoading = false,
    this.height = 52.0,
    this.width = double.infinity,
    this.borderSide,
  });

  factory AppElevatedButton.primary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return AppElevatedButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColor.brandPrimary400,
      textColor: AppColor.neutral0,
      isLoading: false,
    );
  }

  factory AppElevatedButton.disabled({required String text}) {
    return AppElevatedButton(
      text: text,
      onPressed: null,
      backgroundColor: AppColor.neutral100,
      textColor: AppColor.neutral300,
      isLoading: false,
    );
  }

  factory AppElevatedButton.loading() {
    return const AppElevatedButton(isLoading: true, text: '', onPressed: null);
  }

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final double height, width;
  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              side: borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const CircularProgressIndicator.adaptive(
            // backgroundColor: neutral0,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.neutral0),
          ),
        ),
      );
    }
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(text, style: bodyLargeSemiBold.copyWith(color: textColor)),
      ),
    );
  }
}
