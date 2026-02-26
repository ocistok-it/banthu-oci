import 'package:flutter/material.dart';

/// {@template app_colors}
/// Colors class for themes which provides direct access with static fields.
/// {@endtemplate}
abstract interface class AppColors {
  AppColors._();

  /// The color white
  static const white = Colors.white;

  /// The color black
  static const black = Colors.black;

  /// The color transparent
  static const transparent = Colors.transparent;

  // Misc.
  static const Color gigaFactoryColor = Color(0xff5F00EF);
  static const Color taurusColor = Color(0xffED0000);
  static const Color shadowColor = Color(0xFF1C202B);

  /// Greyscale colors
  static const Color greyscale50 = Color(0xffCECECE);

  /// Brand color palette.
  static const brand = MaterialColor(0xFF347AF6, {
    50: Color(0xFFF0F5FF),
    100: Color(0xFFE0ECFF),
    150: Color(0xFFD3E1FB),
    200: Color(0xFFBDD3F9),
    250: Color(0xFF9FBFF9),
    300: Color(0xFF81ACF9),
    400: Color(0xFF5A93F9),
    500: Color(0xFF347AF6),
    600: Color(0xFF1559D1),
    700: Color(0xFF174EAF),
    800: Color(0xFF1D4387),
    900: Color(0xFF163367),
  });

  /// Neutral colors
  static const neutral = MaterialColor(0xffFFFFFF, {
    0: Color(0xffFFFFFF),
    50: Color(0xffF5F5F5),
    70: Color(0xff858585),
    100: Color(0xffE6E6E6),
    200: Color(0xffD1D1D1),
    300: Color(0xffBDBDBD),
    400: Color(0xffA3A3A3),
    500: Color(0xff8A8A8A),
    600: Color(0xff707070),
    700: Color(0xff525252),
    800: Color(0xff424242),
    900: Color(0xff292929),
  });

  /// Brand primary colors
  static const brandPrimary = MaterialColor(0xff17BA83, {
    25: Color(0xffE4FCF4),
    50: Color(0xffA9F4DB),
    100: Color(0xff7BEFC8),
    200: Color(0xff4EE9B5),
    300: Color(0xff21E3A2),
    400: Color(0xff17BA83),
    500: Color(0xff14A373),
    600: Color(0xff129166),
    700: Color(0xff0F7653),
    800: Color(0xff0B5B40),
    900: Color(0xff08402D),
  });

  /// Brand secondary colors
  static const brandSecondary = MaterialColor(0xffF47B2A, {
    25: Color(0xffFEF3EC),
    50: Color(0xffFCDBC5),
    100: Color(0xffFAC39E),
    200: Color(0xffF7A56E),
    300: Color(0xffF69350),
    400: Color(0xffF47B2A),
    500: Color(0xffDF600C),
    600: Color(0xffAF4B09),
    700: Color(0xff7E3607),
    800: Color(0xff4E2204),
    900: Color(0xff3A1903),
  });

  /// Brand tertiary colors
  static const brandTertiary = MaterialColor(0xff34C7F4, {
    25: Color(0xffE2F7FD),
    50: Color(0xffBBECFB),
    100: Color(0xff9EE4FA),
    200: Color(0xff77DAF8),
    300: Color(0xff5AD2F6),
    400: Color(0xff34C7F4),
    500: Color(0xff0CB5E9),
    600: Color(0xff0A8FB8),
    700: Color(0xff076A88),
    800: Color(0xff06536B),
    900: Color(0xff043544),
  });

  /// Error colors
  static const semanticError = MaterialColor(0xffF93D41, {
    0: Color(0xffFEEBEC),
    25: Color(0xffFED7D8),
    50: Color(0xffFC9294),
    100: Color(0xffFA6164),
    200: Color(0xffF93D41),
    300: Color(0xffCF1C20),
    400: Color(0xffB4181C),
    500: Color(0xff901316),
  });

  /// Info colors
  static const semanticInfo = MaterialColor(0xff5084FE, {
    0: Color(0xffEBF1FF),
    25: Color(0xffB8CDFF),
    50: Color(0xff8FB1FE),
    100: Color(0xff719BFE),
    200: Color(0xff5084FE),
    300: Color(0xff0C54FE),
    400: Color(0xff013DCB),
    500: Color(0xff012B8E),
  });

  /// Success colors
  static const semanticSuccess = MaterialColor(0xff40C468, {
    0: Color(0xffEFFAF3),
    25: Color(0xffC1ECCE),
    50: Color(0xff8ADBA2),
    100: Color(0xff63CF83),
    200: Color(0xff40C468),
    300: Color(0xff35AB59),
    400: Color(0xff298444),
    500: Color(0xff1D5E30),
  });

  /// Warning colors
  static const semanticWarning = MaterialColor(0xffF8A61A, {
    0: Color(0xffFEF7EB),
    25: Color(0xffFDE4BA),
    50: Color(0xffFBCD7E),
    100: Color(0xffFAC161),
    200: Color(0xffF8A61A),
    300: Color(0xffE49207),
    400: Color(0xffC67F06),
    500: Color(0xff9E6605),
  });
}
