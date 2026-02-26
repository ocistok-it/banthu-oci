import '../theme/theme_extension.dart';
import 'package:flutter/material.dart';

import 'base_app_button.dart';

/// {@template tertiary_button}
/// A custom secondary text button widget that adapts to the platform.
/// {@endtemplate}
class TertiaryButton extends BaseAppButton {
  /// {@macro tertiary_button}
  const TertiaryButton({
    super.key,
    required super.label,
    super.onTap,
    super.leading,
    super.trailing,
    super.appButtonSize,
  });

  @override
  Color backgroundColor(BuildContext context) {
    return context.buttonTheme.tertiaryBackground;
  }

  @override
  Color disabledColor(BuildContext context) {
    return context.buttonTheme.tertiaryDisabled;
  }

  @override
  Color focusedColor(BuildContext context) {
    return context.buttonTheme.tertiaryFocused;
  }

  @override
  Color hoveredColor(BuildContext context) {
    return context.buttonTheme.tertiaryHover;
  }

  @override
  Color textColor(BuildContext context) {
    return context.buttonTheme.tertiaryText;
  }

  @override
  Color pressedColor(BuildContext context) {
    return context.buttonTheme.tertiaryPressed;
  }
}
