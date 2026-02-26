import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../design_system.dart';

abstract interface class AppBottomSheet {
  const AppBottomSheet._();

  static Future<void> show(
    BuildContext context, {
    required String title,
    required List<Widget> Function(BuildContext) slivers,
    Widget? stickyActionBar,
  }) async {
    WoltModalSheet.show(
      context: context,
      pageListBuilder:
          (bottomSheetContext) => [
            SliverWoltModalSheetPage(
              surfaceTintColor: AppColors.neutral[0],
              backgroundColor: AppColors.neutral[0],
              isTopBarLayerAlwaysVisible: true,
              topBarTitle: Text(
                title,
                style: AppTypography.bodyXlargeSemiBold.copyWith(
                  color: AppColors.neutral[900],
                ),
              ),
              stickyActionBar: stickyActionBar,
              mainContentSliversBuilder: slivers,
            ),
          ],
    );
  }
}
