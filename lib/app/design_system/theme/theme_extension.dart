import 'package:flutter/material.dart';

import 'app_button_theme.dart';
import 'app_input_theme.dart';
import 'app_tag_theme.dart';
import 'app_theme.dart';
import 'app_typography_theme.dart';

/// An extension on [BuildContext] that provides access to the current theme.
extension ThemeExt on BuildContext {
  /// The current theme.
  ThemeData get theme => Theme.of(this);

  ///the current button theme
  AppButtonTheme get buttonTheme =>
      theme.extension<AppTheme>()!.appButtonTheme as AppButtonTheme;

  // /// The current app checkboxTheme.
  // AppCheckboxTheme get checkboxTheme =>
  //     theme.extension<AppTheme>()!.appCheckboxTheme as AppCheckboxTheme;

  // /// The current app iconTheme.
  // AppIconTheme get iconTheme =>
  //     theme.extension<AppTheme>()!.appIconTheme as AppIconTheme;

  /// The current app inputTheme.
  AppInputTheme get inputTheme =>
      theme.extension<AppTheme>()!.appInputTheme as AppInputTheme;

  /// The current app radioTheme.
  // AppRadioTheme get radioTheme =>
  //     theme.extension<AppTheme>()!.appRadioTheme as AppRadioTheme;

  // /// The current app toggleTheme.
  AppTagTheme get tagTheme =>
      theme.extension<AppTheme>()!.appTagTheme as AppTagTheme;

  /// The current app typographyTheme.
  AppTypographyTheme get typographyTheme =>
      theme.extension<AppTheme>()!.appTypographyTheme as AppTypographyTheme;

  // /// The current app avatarTheme.
  // AppAvatarTheme get avatarTheme =>
  //     theme.extension<AppTheme>()!.appAvatarTheme as AppAvatarTheme;

  // /// The current app navigationTheme.
  // AppNavigationTheme get navigationTheme =>
  //     theme.extension<AppTheme>()!.appNavigationTheme as AppNavigationTheme;

  // /// The current app layoutTheme.
  // AppLayoutTheme get layoutTheme =>
  //     theme.extension<AppTheme>()!.appLayoutTheme as AppLayoutTheme;

  // /// The current app badgeTheme.
  // AppBadgeTheme get badgeTheme =>
  //     theme.extension<AppTheme>()!.appBadgeTheme as AppBadgeTheme;

  // /// The current app breadcrumbTheme.
  // AppBreadCrumbTheme get appBreadCrumbTheme =>
  //     theme.extension<AppTheme>()!.appBreadCrumbTheme as AppBreadCrumbTheme;

  // /// The current app appDropdownTheme.
  // AppDropdownTheme get appDropdownTheme =>
  //     theme.extension<AppTheme>()!.appDropdownTheme as AppDropdownTheme;
}
