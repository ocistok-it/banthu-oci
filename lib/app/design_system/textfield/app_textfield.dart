import '../theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../typography/typography.dart';

/// {@template app_text_field}
/// A customizable text field widget with various customization options.
/// {@endtemplate}
class AppTextField extends StatelessWidget {
  /// {@macro app_text_field}
  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.enabled = true,
    this.obscureText = false,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.helperText,
    this.errorText,
    this.suffixIcon,
    this.suffixIconConstraints = const BoxConstraints(
      minHeight: 24,
      minWidth: 40,
    ),
    this.prefixIcon,
    this.prefixIconConstraints = const BoxConstraints(
      minHeight: 24,
      minWidth: 40,
    ),
    this.autofillHints,
    this.onEditingComplete,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines = 1,
  });

  /// The controller for the text field.
  final TextEditingController? controller;

  /// The label text for the text field.
  final String? labelText;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether the text field is obscured.
  final bool obscureText;

  /// Called when the text field value changes.
  final ValueChanged<String>? onChanged;

  /// The autovalidate mode for the text field.
  final AutovalidateMode autovalidateMode;

  /// The validator for the text field.
  final FormFieldValidator<String>? validator;

  /// The helper text for the text field.
  final String? helperText;

  /// The error text for the text field.
  final String? errorText;

  /// The suffix icon for the text field.
  final Widget? suffixIcon;

  /// The constraints for the suffix icon.
  final BoxConstraints? suffixIconConstraints;

  /// The prefix icon for the text field.
  final Widget? prefixIcon;

  /// The constraints for the prefix icon.
  final BoxConstraints? prefixIconConstraints;

  /// The autofillhints for app text field.
  final Iterable<String>? autofillHints;

  /// Called when the text field value completed.
  final VoidCallback? onEditingComplete;

  /// The input formatters for the text field.
  final List<TextInputFormatter>? inputFormatters;

  /// The keyboard type for the text field.
  final TextInputType? keyboardType;

  /// the maximum lines available in text field.
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete,
      autofillHints: autofillHints,
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      validator: validator,
      maxLines: maxLines,
      style: WidgetStateTextStyle.resolveWith((states) {
        late final Color textColor;

        if (states.contains(WidgetState.error)) {
          textColor = context.inputTheme.focusedTextDefault;
        } else if (states.contains(WidgetState.focused)) {
          textColor = context.inputTheme.focusedTextDefault;
        } else if (states.contains(WidgetState.disabled)) {
          textColor = context.inputTheme.disabledText;
        } else {
          textColor = context.inputTheme.defaultText;
        }

        return AppTypography.bodyLargeRegular.copyWith(color: textColor);
      }),
      cursorColor: context.inputTheme.focusedTextDefault,
      cursorHeight: 24,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: WidgetStateTextStyle.resolveWith((states) {
          late final Color textColor;

          if (states.contains(WidgetState.error)) {
            textColor = context.inputTheme.errorTextDefault;
          } else if (states.contains(WidgetState.focused)) {
            textColor = context.inputTheme.focusedOnBrand;
          } else if (states.contains(WidgetState.disabled)) {
            textColor = context.inputTheme.disabledText;
          } else {
            textColor = context.inputTheme.defaultText;
          }

          return AppTypography.bodyLargeRegular.copyWith(color: textColor);
        }),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          late final Color textColor;

          if (states.contains(WidgetState.error)) {
            textColor = context.inputTheme.errorTextDefault;
          } else if (states.contains(WidgetState.focused)) {
            textColor = context.inputTheme.focusedOnBrand;
          } else {
            textColor = context.inputTheme.defaultText;
          }

          return const TextStyle(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w500,
          ).copyWith(color: textColor);
        }),
        filled: true,
        fillColor:
            enabled
                ? context.inputTheme.defaultColor
                : context.inputTheme.disabledColor,
        border: WidgetStateInputBorder.resolveWith((states) {
          late final Color borderColor;

          if (states.contains(WidgetState.error)) {
            borderColor = context.inputTheme.borderError;
          } else if (states.contains(WidgetState.focused)) {
            borderColor = context.inputTheme.borderFocused;
          } else if (states.contains(WidgetState.disabled)) {
            borderColor = context.inputTheme.borderDisabled;
          } else if (states.contains(WidgetState.hovered)) {
            borderColor = context.inputTheme.borderHover;
          } else {
            borderColor = context.inputTheme.borderDefault;
          }

          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor),
          );
        }),
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        helperText: helperText,
        helperStyle: WidgetStateTextStyle.resolveWith((states) {
          late final Color textColor;

          if (states.contains(WidgetState.error)) {
            textColor = context.inputTheme.errorTextDefault;
          } else if (states.contains(WidgetState.focused)) {
            textColor = context.inputTheme.focusedOnBrand;
          } else if (states.contains(WidgetState.disabled)) {
            textColor = context.inputTheme.disabledText;
          } else {
            textColor = context.inputTheme.defaultText;
          }

          return AppTypography.bodySmallRegular.copyWith(color: textColor);
        }),
        errorText: errorText,
        errorStyle: AppTypography.bodySmallRegular.copyWith(
          color: context.inputTheme.errorTextDefault,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffixIconConstraints: suffixIconConstraints,
        prefixIconConstraints: prefixIconConstraints,
      ),
    );
  }
}
