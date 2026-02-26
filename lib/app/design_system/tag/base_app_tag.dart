import '../button/button.dart';
import 'package:flutter/material.dart';

import '../typography/typography.dart';

abstract class BaseAppTag extends StatelessWidget {
  const BaseAppTag({
    super.key,
    this.leading,
    this.trailing,
    required this.label,
  });

  /// The leading icon for the text button.
  final IconBuilder? leading;

  /// The trailing icon for the text button.
  final IconBuilder? trailing;

  final String label;

  Color backgroundColor(BuildContext context);

  Color textColor(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!(textColor(context)),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.captionSemiBold.copyWith(
              color: textColor(context),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 4),
            trailing!(textColor(context)),
          ],
        ],
      ),
    );
  }
}
