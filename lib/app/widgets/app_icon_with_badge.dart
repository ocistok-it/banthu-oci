import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_typography.dart';

class AppIconWithBadge extends StatelessWidget {
  const AppIconWithBadge({super.key, required this.icon, required this.count});

  final Widget icon;
  final int count;

  factory AppIconWithBadge.empty({required Widget icon}) {
    return AppIconWithBadge(icon: icon, count: 0);
  }

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return icon;
    } else {
      return Badge.count(
        offset: const Offset(10, -10),
        backgroundColor: AppColor.semanticError200,
        textStyle: captionRegular.copyWith(color: AppColor.neutral0),
        count: count,
        child: icon,
      );
    }
  }
}
