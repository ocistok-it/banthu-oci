import 'package:flutter/material.dart';

import '../app_spacing.dart';
import '../typography/typography.dart';
import 'app_button_size.dart';

/// A function that builds an icon widget.
typedef IconBuilder = Widget Function(Color iconColor);

/// {@template app_text_button}
/// A custom text button widget that adapts to the platform.
/// {@endtemplate}
abstract class BaseAppButton extends StatelessWidget {
  /// {@macro app_text_button}
  const BaseAppButton({
    super.key,
    required this.label,
    this.onTap,
    this.leading,
    this.trailing,
    this.appButtonSize = AppButtonSize.medium,
  });

  /// The label for the text button.
  final String label;

  /// The callback function for the text button.
  final VoidCallback? onTap;

  /// The leading icon for the text button.
  final IconBuilder? leading;

  /// The trailing icon for the text button.
  final IconBuilder? trailing;

  /// The size of the text button.
  final AppButtonSize appButtonSize;

  Color backgroundColor(BuildContext context);

  Color hoveredColor(BuildContext context);

  Color focusedColor(BuildContext context);

  Color pressedColor(BuildContext context);

  Color disabledColor(BuildContext context);

  Color textColor(BuildContext context);

  /// The disabled text color for the text button.
  Color disabledTextColor(BuildContext context) {
    return Theme.of(context).disabledColor;
  }

  /// The default border for the text button.
  BorderSide defaultBorder(BuildContext context) => BorderSide.none;

  /// The focused border for the text button.
  BorderSide focusedBorder(BuildContext context) => BorderSide.none;

  /// The hover border for the text button.
  BorderSide hoveredBorder(BuildContext context) => BorderSide.none;

  /// The disabled border for the text button.
  BorderSide disabledBorder(BuildContext context) => BorderSide.none;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return disabledTextColor(context);
      }

      return textColor(context);
    });

    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabledColor(context);
          }

          if (states.contains(WidgetState.hovered)) {
            return hoveredColor(context);
          }

          if (states.contains(WidgetState.focused)) {
            return focusedColor(context);
          }

          if (states.contains(WidgetState.pressed)) {
            return pressedColor(context);
          }

          return backgroundColor(context);
        }),
        shape: WidgetStateProperty.resolveWith((states) {
          final shape = RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          );

          if (states.contains(WidgetState.disabled)) {
            return shape.copyWith(side: disabledBorder(context));
          }

          if (states.contains(WidgetState.focused)) {
            return shape.copyWith(side: focusedBorder(context));
          }

          if (states.contains(WidgetState.hovered)) {
            return shape.copyWith(side: hoveredBorder(context));
          }

          if (states.contains(WidgetState.pressed)) {
            return shape.copyWith(side: focusedBorder(context));
          }

          return shape.copyWith(side: defaultBorder(context));
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabledColor(context);
          }

          if (states.contains(WidgetState.hovered)) {
            return hoveredColor(context);
          }

          if (states.contains(WidgetState.focused)) {
            return focusedColor(context);
          }

          if (states.contains(WidgetState.pressed)) {
            return pressedColor(context);
          }

          return backgroundColor(context);
        }),
        foregroundColor: foregroundColor,
        fixedSize: WidgetStateProperty.all(switch (appButtonSize) {
          AppButtonSize.xsmall => const Size(double.infinity, 32),
          AppButtonSize.small => const Size(double.infinity, 40),
          AppButtonSize.medium => const Size(double.infinity, 48),
          AppButtonSize.large => const Size(double.infinity, 52),
        }),
        padding: WidgetStateProperty.all(switch (appButtonSize) {
          AppButtonSize.xsmall => const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6.5,
          ),
          AppButtonSize.small => const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 9,
          ),
          AppButtonSize.medium => const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          AppButtonSize.large => const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        }),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!(
              onTap != null ? textColor(context) : disabledTextColor(context),
            ),
            const SizedBox(width: 8),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: Text(
              label,
              style: switch (appButtonSize) {
                AppButtonSize.xsmall => AppTypography.bodySmallSemiBold,
                AppButtonSize.small => AppTypography.bodyMediumSemiBold,
                AppButtonSize.medium => AppTypography.bodyLargeSemiBold,
                AppButtonSize.large => AppTypography.bodyLargeSemiBold,
              },
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!(
              onTap != null ? textColor(context) : disabledTextColor(context),
            ),
          ],
        ],
      ),
    );
  }
}
