import '../../core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_typography.dart';
import 'app_clickable_widget.dart';
import 'fav_icon_button.dart';
import 'product_source_badge.dart';
import 'product_supplier_badge.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.aspectRatio = 167 / 266,
    this.onTap,
    this.productImage,
    required this.productName,
    required this.productPrice,
    this.productRating,
    this.productSold,
  });

  final double? aspectRatio;
  final VoidCallback? onTap;
  final String? productImage;
  final String productName;
  final num productPrice;
  final String? productRating;
  final double? productSold;

  @override
  Widget build(BuildContext context) {
    return AppClickableWidget(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: aspectRatio!,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.neutral0,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withValues(alpha: 0.04),
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: AppColor.shadowColor.withValues(alpha: 0.05),
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          child: Image.asset(
                            "assets/images/sample_img.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const FavIconButton(),
                      ProductSourceBadge.s1688(),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          WidgetSpan(child: ProductSupplierBadge.gigaFactory()),
                          const WidgetSpan(child: SizedBox(width: 2)),
                          WidgetSpan(child: ProductSupplierBadge.taurus()),
                          const WidgetSpan(child: SizedBox(width: 2)),
                          TextSpan(
                            text: productName,
                            style: bodySmallRegular.copyWith(
                              color: AppColor.neutral900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      productPrice.toCurrency(),
                      style: bodyMediumSemiBold.copyWith(
                        color: AppColor.neutral900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColor.semanticWarning100,
                          size: 11,
                        ),
                        Text(
                          productRating ?? "-".toString(),
                          style: bodySmallSemiBold.copyWith(
                            color: AppColor.neutral600,
                          ),
                        ),
                        if (productSold != null) ...[
                          const SizedBox(height: 10, child: VerticalDivider()),
                          Text(
                            "${productSold!.toCompactNumber()} sold",
                            style: bodySmallRegular.copyWith(
                              color: AppColor.neutral600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
