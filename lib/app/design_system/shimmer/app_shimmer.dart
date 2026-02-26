import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../colors/app_colors.dart';

class BaseAppShimmer extends StatelessWidget {
  const BaseAppShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 48,
    this.shape = BoxShape.rectangle,
  });

  final double? width, height;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.brandPrimary[25]!,
      highlightColor: AppColors.white,
      child: Container(
        width: width,
        height: shape == BoxShape.circle ? width : height,
        decoration: BoxDecoration(
          borderRadius:
              shape == BoxShape.circle ? null : BorderRadius.circular(8),
          color: AppColors.brandPrimary[25]!,
          shape: shape,
        ),
      ),
    );
  }
}
