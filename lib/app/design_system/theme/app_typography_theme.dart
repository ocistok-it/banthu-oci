import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

/// {@template app_input_theme}
/// Theme class which provides configuration of [AppTextField]
/// {@endtemplate}
class AppTypographyTheme extends ThemeExtension<AppTypographyTheme> {
  /// {@macro app_input_theme}
  const AppTypographyTheme({required this.defaultText});

  /// {@macro app_input_theme}
  factory AppTypographyTheme.light() {
    return AppTypographyTheme(defaultText: AppColors.neutral[700]!);
  }

  /// The default text color.
  final Color defaultText;

  @override
  ThemeExtension<AppTypographyTheme> copyWith({Color? defaultText}) {
    return AppTypographyTheme(defaultText: defaultText ?? this.defaultText);
  }

  @override
  ThemeExtension<AppTypographyTheme> lerp(
    covariant ThemeExtension<AppTypographyTheme>? other,
    double t,
  ) {
    if (other is! AppTypographyTheme) {
      return this;
    }

    return AppTypographyTheme(
      defaultText: Color.lerp(defaultText, other.defaultText, t)!,
    );
  }
}
