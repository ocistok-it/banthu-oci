import 'package:flutter/widgets.dart';

import 'app_shimmer.dart';

class CircleShimmer extends BaseAppShimmer {
  const CircleShimmer({super.key, required double size})
    : super(width: size, shape: BoxShape.circle);
}
