import 'package:flutter/material.dart';

import '../design_system.dart';

abstract interface class AppDialog {
  const AppDialog._();

  static Future<DialogResult?> showAppOkCancelDialog(
    BuildContext context, {
    String? title,
    required String subtitle,
    required String content,
    required String okCaption,
    required String cancelCaption,
  }) async {
    final DialogResult? result = await showAdaptiveDialog<DialogResult?>(
      context: context,
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        return Dialog(
          backgroundColor: AppColors.neutral,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: size.width > 600 ? 560 : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Column(
                    spacing: 12,
                    children: [
                      const SizedBox.shrink(),
                      Text(
                        title,
                        style: AppTypography.bodyMediumSemiBold.copyWith(
                          color: AppColors.neutral[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ] else ...[
                  const SizedBox(height: 12),
                ],
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        subtitle,
                        style: AppTypography.bodyMediumSemiBold.copyWith(
                          color: AppColors.neutral[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        content,
                        style: AppTypography.bodySmallRegular.copyWith(
                          color: AppColors.neutral[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    spacing: 6,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: SecondaryButton(
                          label: cancelCaption,
                          appButtonSize: AppButtonSize.small,
                          onTap: () {
                            Navigator.of(context).pop(DialogResult.cancel);
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: okCaption,
                          appButtonSize: AppButtonSize.small,
                          onTap: () {
                            Navigator.of(context).pop(DialogResult.ok);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }

  static Future<DialogResult?> showAppOkDialog(
    BuildContext context, {
    String? title,
    required String subtitle,
    required String content,
    required String okCaption,
  }) async {
    final result = await showAdaptiveDialog(
      context: context,
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        return SizedBox(
          width: size.width > 600 ? 560 : null,
          child: Dialog(
            backgroundColor: AppColors.neutral,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Column(
                    spacing: 12,
                    children: [
                      const SizedBox.shrink(),
                      Text(
                        title,
                        style: AppTypography.bodyMediumSemiBold.copyWith(
                          color: AppColors.neutral[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ] else ...[
                  const SizedBox(height: 12),
                ],
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        subtitle,
                        style: AppTypography.bodyMediumSemiBold.copyWith(
                          color: AppColors.neutral[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        content,
                        style: AppTypography.bodySmallRegular.copyWith(
                          color: AppColors.neutral[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    spacing: 6,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: okCaption,
                          appButtonSize: AppButtonSize.small,
                          onTap: () {
                            Navigator.of(context).pop(DialogResult.ok);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }

  static Future<DialogResult?> showAppFullScreenDialog(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String content,
  }) async {
    final result = await showAdaptiveDialog(
      context: context,
      builder: (context) {
        return const Dialog();
      },
    );
    return result;
  }
}
