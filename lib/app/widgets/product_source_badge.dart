import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../themes/app_colors.dart';

class ProductSourceBadge extends StatelessWidget {
  const ProductSourceBadge({
    super.key,
    required this.imageSource,
    required this.badgeColor,
  });

  final String imageSource;
  final Color badgeColor;

  factory ProductSourceBadge.s1688() {
    return const ProductSourceBadge(
      imageSource: AppIcons.icon1688,
      badgeColor: AppColor.brandSecondary400,
    );
  }

  factory ProductSourceBadge.sTaobao() {
    return const ProductSourceBadge(
      imageSource: AppIcons.iconTaobao,
      badgeColor: AppColor.semanticError200,
    );
  }

  factory ProductSourceBadge.sAlibaba() {
    return const ProductSourceBadge(
      imageSource: AppIcons.iconAlibaba,
      badgeColor: AppColor.brandSecondary25,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: Container(
        height: 16,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Image.asset(
          imageSource,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fitHeight,
          height: 10,
        ),
      ),
    );
  }
}
