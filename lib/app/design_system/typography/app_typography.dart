import 'package:flutter/material.dart';

abstract interface class AppTypography {
  const AppTypography._();

  /// Headings
  static const TextStyle heading1SemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 64.0,
  );
  static const TextStyle heading2SemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 52.0,
  );
  static const TextStyle heading3SemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 48.0,
  );
  static const TextStyle heading4SemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 40.0,
  );
  static const TextStyle heading5SemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 32.0,
  );
  static const TextStyle heading6SemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24.0,
  );

  /// Title
  static const TextStyle titleSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  );
  static const TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
  );
  static const TextStyle titleRegular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
  );

  /// Body
  static const TextStyle bodyXlargeSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
  );
  static const TextStyle bodyXlargeMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
  );
  static const TextStyle bodyXlargeRegular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
  );
  static const TextStyle bodyLargeSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  );
  static const TextStyle bodyLargeMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );
  static const TextStyle bodyLargeRegular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    height: 150 / 100,
  );
  static const TextStyle bodyMediumSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
  );
  static const TextStyle bodyMediumMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
  static const TextStyle bodyMediumRegular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );
  static const TextStyle bodySmallSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
  );
  static const TextStyle bodySmallMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );
  static const TextStyle bodySmallRegular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    height: 160 / 100,
  );

  /// Caption
  static const TextStyle captionSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 10.0,
    height: 160 / 100,
  );
  static const TextStyle captionMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10.0,
  );
  static const TextStyle captionRegular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 10.0,
  );
}
