import '../theme/theme_extension.dart';
import 'package:flutter/material.dart';

import 'base_app_button.dart';

/// {@template primary_text_button}
/// A custom primary text button widget that adapts to the platform.
/// {@endtemplate}
class PrimaryButton extends BaseAppButton {
  /// {@macro primary_text_button}
  const PrimaryButton({
    super.key,
    required super.label,
    super.onTap,
    super.leading,
    super.trailing,
    super.appButtonSize,
  });

  @override
  Color backgroundColor(BuildContext context) {
    return context.buttonTheme.primaryBackground;
  }

  @override
  Color disabledColor(BuildContext context) {
    return context.buttonTheme.primaryDisabled;
  }

  @override
  Color focusedColor(BuildContext context) {
    return context.buttonTheme.primaryFocused;
  }

  @override
  Color hoveredColor(BuildContext context) {
    return context.buttonTheme.primaryHover;
  }

  @override
  Color textColor(BuildContext context) {
    return context.buttonTheme.primaryText;
  }

  @override
  Color pressedColor(BuildContext context) {
    return context.buttonTheme.primaryPressed;
  }
}
