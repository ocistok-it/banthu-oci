import '../theme/theme_extension.dart';
import 'package:flutter/material.dart';

import 'base_app_button.dart';

/// {@template primary_text_button}
/// A custom secondary text button widget that adapts to the platform.
/// {@endtemplate}
class SecondaryButton extends BaseAppButton {
  /// {@macro primary_text_button}
  const SecondaryButton({
    super.key,
    required super.label,
    super.onTap,
    super.leading,
    super.trailing,
    super.appButtonSize,
  });

  @override
  Color backgroundColor(BuildContext context) {
    return context.buttonTheme.secondaryBackground;
  }

  @override
  Color disabledColor(BuildContext context) {
    return context.buttonTheme.secondaryDisabled;
  }

  @override
  Color focusedColor(BuildContext context) {
    return context.buttonTheme.secondaryFocused;
  }

  @override
  Color hoveredColor(BuildContext context) {
    return context.buttonTheme.secondaryHover;
  }

  @override
  Color textColor(BuildContext context) {
    return context.buttonTheme.secondaryText;
  }

  @override
  Color pressedColor(BuildContext context) {
    return context.buttonTheme.secondaryPressed;
  }

  /// The default border for the text button.
  @override
  BorderSide defaultBorder(BuildContext context) =>
      BorderSide(color: context.buttonTheme.secondaryPressed);

  /// The focused border for the text button.
  @override
  BorderSide focusedBorder(BuildContext context) =>
      BorderSide(color: context.buttonTheme.secondaryPressed);

  /// The hover border for the text button.
  @override
  BorderSide hoveredBorder(BuildContext context) =>
      BorderSide(color: context.buttonTheme.secondaryPressed);

  /// The disabled border for the text button.
  @override
  BorderSide disabledBorder(BuildContext context) => BorderSide.none;
}
