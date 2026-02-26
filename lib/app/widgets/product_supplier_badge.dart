import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../themes/app_colors.dart';

class ProductSupplierBadge extends StatelessWidget {
  const ProductSupplierBadge({
    super.key,
    required this.imageSource,
    required this.badgeColor,
    required this.caption,
  });

  final String imageSource;
  final Color badgeColor;
  final String caption;

  factory ProductSupplierBadge.gigaFactory() {
    return const ProductSupplierBadge(
      imageSource: AppIcons.iconGigaFactory,
      badgeColor: AppColor.gigaFactoryColor,
      caption: "GigaFactory",
    );
  }
  factory ProductSupplierBadge.taurus() {
    return const ProductSupplierBadge(
      imageSource: AppIcons.iconTaurus,
      badgeColor: AppColor.taurusColor,
      caption: "Taurus",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: badgeColor,
      ),
      child: Row(
        spacing: 2,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 14, width: 14, child: Image.asset(imageSource)),
          Text(
            caption,
            style: const TextStyle(
              fontSize: 9,
              color: AppColor.neutral0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
