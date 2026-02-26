import 'package:flutter/material.dart';

class AppClickableWidget extends StatelessWidget {
  const AppClickableWidget({super.key, this.onTap, required this.child});

  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: child,
    );
  }
}
