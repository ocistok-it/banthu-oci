import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

/// {@template app_button_theme}
/// Theme class which provides configuration of buttons
/// {@endtemplate}
class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  /// {@macro app_button_theme}
  const AppButtonTheme({
    required this.primaryText,
    required this.primaryBackground,
    required this.primaryHover,
    required this.primaryFocused,
    required this.primaryDisabled,
    required this.primaryPressed,
    // Secondary
    required this.secondaryBackground,
    required this.secondaryHover,
    required this.secondaryFocused,
    required this.secondaryDisabled,
    required this.secondaryPressed,
    required this.secondaryText,
    // Tertiary
    required this.tertiaryBackground,
    required this.tertiaryHover,
    required this.tertiaryFocused,
    required this.tertiaryDisabled,
    required this.tertiaryPressed,
    required this.tertiaryText,
    //
    required this.buttonDisabled,
  });

  /// {@macro app_button_theme}
  factory AppButtonTheme.light() {
    return AppButtonTheme(
      primaryBackground: AppColors.brandPrimary,
      primaryHover: AppColors.brandPrimary[500]!,
      primaryFocused: AppColors.brandPrimary[50]!,
      primaryPressed: AppColors.brandPrimary[600]!,
      primaryDisabled: AppColors.neutral[100]!,
      primaryText: AppColors.neutral,
      // Secondary
      secondaryBackground: AppColors.neutral,
      secondaryHover: AppColors.neutral[100]!,
      secondaryFocused: AppColors.neutral[100]!,
      secondaryPressed: AppColors.neutral[200]!,
      secondaryDisabled: AppColors.neutral[100]!,
      secondaryText: AppColors.neutral[700]!,
      //
      tertiaryBackground: AppColors.neutral,
      tertiaryHover: AppColors.neutral[100]!,
      tertiaryFocused: AppColors.neutral[100]!,
      tertiaryPressed: AppColors.neutral[200]!,
      tertiaryDisabled: AppColors.neutral[0]!,
      tertiaryText: AppColors.brandPrimary,
      //
      buttonDisabled: AppColors.neutral[300]!,
    );
  }

  /// The color of the primary button default.
  final Color primaryBackground;

  /// The color of the primary button hover.
  final Color primaryHover;

  /// The color of the primary button focused.
  final Color primaryFocused;

  /// The color of the primary button pressed.
  final Color primaryPressed;

  /// The color of the primary button disabled.
  final Color primaryDisabled;

  /// The color of the primary text.
  final Color primaryText;

  /// The color of the secondary button default.
  final Color secondaryBackground;

  /// The color of the secondary button hover.
  final Color secondaryHover;

  /// The color of the secondary button focused.
  final Color secondaryFocused;

  /// The color of the secondary button pressed.
  final Color secondaryPressed;

  /// The color of the secondary button disabled.
  final Color secondaryDisabled;

  /// The color of the secondary button disabled.
  final Color secondaryText;

  /// The color of the tertiary button default.
  final Color tertiaryBackground;

  /// The color of the tertiary button hover.
  final Color tertiaryHover;

  /// The color of the tertiary button focused.
  final Color tertiaryFocused;

  /// The color of the tertiary button pressed.
  final Color tertiaryPressed;

  /// The color of the tertiary button disabled.
  final Color tertiaryDisabled;

  /// The color of the tertiary button disabled.
  final Color tertiaryText;

  /// Text color of disabled text
  final Color buttonDisabled;

  @override
  ThemeExtension<AppButtonTheme> copyWith({
    Color? primaryBackground,
    Color? primaryHover,
    Color? primaryFocused,
    Color? primaryPressed,
    Color? primaryDisabled,
    Color? primaryText,
    // Secondary
    Color? secondaryBackground,
    Color? secondaryHover,
    Color? secondaryFocused,
    Color? secondaryPressed,
    Color? secondaryDisabled,
    Color? secondaryText,
    //
    Color? tertiaryBackground,
    Color? tertiaryHover,
    Color? tertiaryFocused,
    Color? tertiaryPressed,
    Color? tertiaryDisabled,
    Color? tertiaryText,
    //
    Color? buttonDisabled,
  }) {
    return AppButtonTheme(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryFocused: primaryFocused ?? this.primaryFocused,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      primaryDisabled: primaryDisabled ?? this.primaryDisabled,
      primaryText: primaryText ?? this.primaryText,
      // Secondary
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      secondaryHover: secondaryHover ?? this.secondaryHover,
      secondaryFocused: secondaryFocused ?? this.secondaryFocused,
      secondaryPressed: secondaryPressed ?? this.secondaryPressed,
      secondaryDisabled: secondaryDisabled ?? this.secondaryDisabled,
      secondaryText: secondaryText ?? this.secondaryText,
      // Tertiary
      tertiaryBackground: tertiaryBackground ?? this.tertiaryBackground,
      tertiaryHover: tertiaryHover ?? this.tertiaryHover,
      tertiaryFocused: tertiaryFocused ?? this.tertiaryFocused,
      tertiaryPressed: tertiaryPressed ?? this.tertiaryPressed,
      tertiaryDisabled: tertiaryDisabled ?? this.tertiaryDisabled,
      tertiaryText: tertiaryText ?? this.tertiaryText,
      //
      buttonDisabled: buttonDisabled ?? this.buttonDisabled,
    );
  }

  @override
  ThemeExtension<AppButtonTheme> lerp(
    covariant ThemeExtension<AppButtonTheme>? other,
    double t,
  ) {
    if (other is! AppButtonTheme) {
      return this;
    }

    return AppButtonTheme(
      primaryBackground:
          Color.lerp(primaryBackground, other.primaryBackground, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      primaryFocused: Color.lerp(primaryFocused, other.primaryFocused, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      primaryDisabled: Color.lerp(primaryDisabled, other.primaryDisabled, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      // Secondary
      secondaryBackground:
          Color.lerp(secondaryBackground, other.secondaryBackground, t)!,
      secondaryHover: Color.lerp(secondaryHover, other.secondaryHover, t)!,
      secondaryFocused:
          Color.lerp(secondaryFocused, other.secondaryFocused, t)!,
      secondaryPressed:
          Color.lerp(secondaryPressed, other.secondaryPressed, t)!,
      secondaryDisabled:
          Color.lerp(secondaryDisabled, other.secondaryDisabled, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      //
      tertiaryBackground:
          Color.lerp(tertiaryBackground, other.tertiaryBackground, t)!,
      tertiaryHover: Color.lerp(tertiaryHover, other.tertiaryHover, t)!,
      tertiaryFocused: Color.lerp(tertiaryFocused, other.tertiaryFocused, t)!,
      tertiaryPressed: Color.lerp(tertiaryPressed, other.tertiaryPressed, t)!,
      tertiaryDisabled:
          Color.lerp(tertiaryDisabled, other.tertiaryDisabled, t)!,
      tertiaryText: Color.lerp(tertiaryText, other.tertiaryText, t)!,
      //
      buttonDisabled: Color.lerp(buttonDisabled, other.buttonDisabled, t)!,
    );
  }
}
