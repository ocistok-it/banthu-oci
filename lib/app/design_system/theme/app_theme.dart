import 'package:flutter/material.dart';

import 'app_button_theme.dart';
import 'app_input_theme.dart';
import 'app_tag_theme.dart';
import 'app_typography_theme.dart';

/// {@template app_theme}
/// Configuration class which collects all Themes of app together and provides
/// them as a single instance
/// {@endtemplate}
class AppTheme extends ThemeExtension<AppTheme> {
  /// {@macro app_theme}
  const AppTheme({
    required this.appButtonTheme,
    required this.appInputTheme,
    required this.appTagTheme,
    required this.appTypographyTheme,
  });

  /// {@macro app_theme}
  factory AppTheme.light() {
    return AppTheme(
      appButtonTheme: AppButtonTheme.light(),
      appInputTheme: AppInputTheme.light(),
      appTagTheme: AppTagTheme.light(),
      appTypographyTheme: AppTypographyTheme.light(),
    );
  }

  /// [AppButtonTheme] instance provides configuration of buttons
  final ThemeExtension<AppButtonTheme> appButtonTheme;

  /// [AppInputTheme] instance provides configuration of [AppTextField]
  final ThemeExtension<AppInputTheme> appInputTheme;

  final ThemeExtension<AppTagTheme> appTagTheme;

  final ThemeExtension<AppTypographyTheme> appTypographyTheme;

  @override
  ThemeExtension<AppTheme> copyWith({
    ThemeExtension<AppButtonTheme>? appButtonTheme,
    ThemeExtension<AppInputTheme>? appInputTheme,
    ThemeExtension<AppTagTheme>? appTagTheme,
    ThemeExtension<AppTypographyTheme>? appTypographyTheme,
  }) {
    return AppTheme(
      appButtonTheme: appButtonTheme ?? this.appButtonTheme,
      appInputTheme: appInputTheme ?? this.appInputTheme,
      appTagTheme: appTagTheme ?? this.appTagTheme,
      appTypographyTheme: appTypographyTheme ?? this.appTypographyTheme,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) {
      return this;
    }

    return AppTheme(
      appButtonTheme: appButtonTheme.lerp(other.appButtonTheme, t),
      appInputTheme: appInputTheme.lerp(other.appInputTheme, t),
      appTagTheme: appTagTheme.lerp(other.appTagTheme, t),
      appTypographyTheme: appTypographyTheme.lerp(other.appTypographyTheme, t),
    );
  }
}
