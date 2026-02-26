import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

/// {@template app_tag_theme}
/// Theme class which provides configuration of tag
/// {@endtemplate}
class AppTagTheme extends ThemeExtension<AppTagTheme> {
  /// {@macro app_tag_theme}
  const AppTagTheme({
    required this.defaultTagSolid,
    required this.blueTagSolid,
    required this.greenTagSolid,
    required this.orangeTagSolid,
    required this.redTagSolid,
    required this.darkBlueTagSolid,
    // Secondary
    required this.forestTagSolid,
    required this.maroonTagSolid,
    required this.dixieOrangeTagSolid,
    required this.defaultTagBackground,
    required this.blueTagBackground,
    required this.greenTagBackground,
    // Tertiary
    required this.orangeTagBackground,
    required this.redTagBackground,
    required this.darkBlueTagBackground,
    required this.forestTagBackground,
    required this.maroonTagBackground,
    required this.dixieOrangeTagBackground,
    //
    required this.solidTagForeground,
  });

  /// {@macro app_tag_theme}
  factory AppTagTheme.light() {
    return AppTagTheme(
      defaultTagSolid: AppColors.neutral[700]!,
      blueTagSolid: AppColors.semanticInfo[200]!,
      greenTagSolid: AppColors.brandPrimary[400]!,
      orangeTagSolid: AppColors.brandSecondary[400]!,
      redTagSolid: AppColors.semanticError[200]!,
      darkBlueTagSolid: AppColors.brandTertiary[400]!,
      forestTagSolid: AppColors.brandPrimary[700]!,
      maroonTagSolid: AppColors.semanticError[500]!,
      dixieOrangeTagSolid: AppColors.semanticWarning[300]!,
      //
      defaultTagBackground: AppColors.neutral[100]!,
      blueTagBackground: AppColors.semanticInfo[0]!,
      greenTagBackground: AppColors.brandPrimary[25]!,
      orangeTagBackground: AppColors.brandSecondary[25]!,
      redTagBackground: AppColors.semanticError[0]!,
      darkBlueTagBackground: AppColors.brandTertiary[25]!,
      forestTagBackground: AppColors.semanticSuccess[25]!,
      maroonTagBackground: AppColors.semanticError[25]!,
      dixieOrangeTagBackground: AppColors.semanticWarning[25]!,
      //
      solidTagForeground: AppColors.neutral,
    );
  }

  final Color defaultTagSolid;
  final Color blueTagSolid;
  final Color greenTagSolid;
  final Color orangeTagSolid;
  final Color redTagSolid;
  final Color darkBlueTagSolid;
  final Color forestTagSolid;
  final Color maroonTagSolid;
  final Color dixieOrangeTagSolid;

  final Color defaultTagBackground;
  final Color blueTagBackground;
  final Color greenTagBackground;
  final Color orangeTagBackground;
  final Color redTagBackground;
  final Color darkBlueTagBackground;
  final Color forestTagBackground;
  final Color maroonTagBackground;
  final Color dixieOrangeTagBackground;

  final Color solidTagForeground;

  @override
  ThemeExtension<AppTagTheme> copyWith({
    Color? defaultTagSolid,
    Color? blueTagSolid,
    Color? greenTagSolid,
    Color? orangeTagSolid,
    Color? redTagSolid,
    Color? darkBlueTagSolid,

    Color? forestTagSolid,
    Color? maroonTagSolid,
    Color? dixieOrangeTagSolid,
    Color? defaultTagBackground,
    Color? blueTagBackground,
    Color? greenTagBackground,

    Color? orangeTagBackground,
    Color? redTagBackground,
    Color? darkBlueTagBackground,
    Color? forestTagBackground,
    Color? maroonTagBackground,
    Color? dixieOrangeTagBackground,

    Color? solidTagForeground,
  }) {
    return AppTagTheme(
      defaultTagSolid: defaultTagSolid ?? this.defaultTagSolid,
      blueTagSolid: blueTagSolid ?? this.blueTagSolid,
      greenTagSolid: greenTagSolid ?? this.greenTagSolid,
      orangeTagSolid: orangeTagSolid ?? this.orangeTagSolid,
      redTagSolid: redTagSolid ?? this.redTagSolid,
      darkBlueTagSolid: darkBlueTagSolid ?? this.darkBlueTagSolid,
      forestTagSolid: forestTagSolid ?? this.forestTagSolid,
      maroonTagSolid: maroonTagSolid ?? this.maroonTagSolid,
      dixieOrangeTagSolid: dixieOrangeTagSolid ?? this.dixieOrangeTagSolid,
      defaultTagBackground: defaultTagBackground ?? this.defaultTagBackground,
      blueTagBackground: blueTagBackground ?? this.blueTagBackground,
      greenTagBackground: greenTagBackground ?? this.greenTagBackground,
      orangeTagBackground: orangeTagBackground ?? this.orangeTagBackground,
      redTagBackground: redTagBackground ?? this.redTagBackground,
      darkBlueTagBackground:
          darkBlueTagBackground ?? this.darkBlueTagBackground,
      forestTagBackground: forestTagBackground ?? this.forestTagBackground,
      maroonTagBackground: maroonTagBackground ?? this.maroonTagBackground,
      dixieOrangeTagBackground:
          dixieOrangeTagBackground ?? this.dixieOrangeTagBackground,
      solidTagForeground: solidTagForeground ?? this.solidTagForeground,
    );
  }

  @override
  ThemeExtension<AppTagTheme> lerp(
    covariant ThemeExtension<AppTagTheme>? other,
    double t,
  ) {
    if (other is! AppTagTheme) {
      return this;
    }

    return AppTagTheme(
      defaultTagSolid: Color.lerp(defaultTagSolid, other.defaultTagSolid, t)!,
      blueTagSolid: Color.lerp(blueTagSolid, other.blueTagSolid, t)!,
      greenTagSolid: Color.lerp(greenTagSolid, other.greenTagSolid, t)!,
      orangeTagSolid: Color.lerp(orangeTagSolid, other.orangeTagSolid, t)!,
      redTagSolid: Color.lerp(redTagSolid, other.redTagSolid, t)!,
      darkBlueTagSolid:
          Color.lerp(darkBlueTagSolid, other.darkBlueTagSolid, t)!,
      forestTagSolid: Color.lerp(forestTagSolid, other.forestTagSolid, t)!,
      maroonTagSolid: Color.lerp(maroonTagSolid, other.maroonTagSolid, t)!,
      dixieOrangeTagSolid:
          Color.lerp(dixieOrangeTagSolid, other.dixieOrangeTagSolid, t)!,
      defaultTagBackground:
          Color.lerp(defaultTagBackground, other.defaultTagBackground, t)!,
      blueTagBackground:
          Color.lerp(blueTagBackground, other.blueTagBackground, t)!,
      greenTagBackground:
          Color.lerp(greenTagBackground, other.greenTagBackground, t)!,
      orangeTagBackground:
          Color.lerp(orangeTagBackground, other.orangeTagBackground, t)!,
      redTagBackground:
          Color.lerp(redTagBackground, other.redTagBackground, t)!,
      darkBlueTagBackground:
          Color.lerp(darkBlueTagBackground, other.darkBlueTagBackground, t)!,
      forestTagBackground:
          Color.lerp(forestTagBackground, other.forestTagBackground, t)!,
      maroonTagBackground:
          Color.lerp(maroonTagBackground, other.maroonTagBackground, t)!,
      dixieOrangeTagBackground:
          Color.lerp(
            dixieOrangeTagBackground,
            other.dixieOrangeTagBackground,
            t,
          )!,
      solidTagForeground:
          Color.lerp(solidTagForeground, other.solidTagForeground, t)!,
    );
  }
}
