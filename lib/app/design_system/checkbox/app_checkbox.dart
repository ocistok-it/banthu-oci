import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    super.key,
    this.backgroundColor = AppColors.neutral,
    this.selectedColor = AppColors.brandPrimary,
    this.borderColor,
    this.size = 20,
    required this.value,
    required this.onChanged,
  });

  final Color backgroundColor, selectedColor;
  final Color? borderColor;
  final bool value;
  final void Function(bool?)? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Checkbox.adaptive(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return selectedColor;
          }
          return backgroundColor;
        }),
        side: BorderSide(color: borderColor ?? AppColors.neutral[100]!),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
