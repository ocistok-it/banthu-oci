import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import 'app_clickable_widget.dart';

class FavIconButton extends StatelessWidget {
  const FavIconButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 4,
      top: 4,
      child: AppClickableWidget(
        onTap: onTap,
        child: Container(
          height: 28,
          width: 28,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.neutral0,
          ),
          child: const Icon(Icons.favorite_outline, size: 20),
        ),
      ),
    );
  }
}
