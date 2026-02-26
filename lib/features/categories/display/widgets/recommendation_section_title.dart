import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_typography.dart';
import 'package:flutter/material.dart';

class RecommendationSectionTitle extends StatelessWidget {
  const RecommendationSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recommendation",
              style: bodyMediumSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 8),
            const Divider(height: 0, color: AppColor.neutral100),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
