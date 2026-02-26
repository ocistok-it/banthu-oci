import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../themes/app_colors.dart';
import '../themes/app_typography.dart';

void showAppToast(BuildContext context, {required String message}) {
  toastification.show(
    context: context,
    animationDuration: const Duration(milliseconds: 300),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    type: ToastificationType.info,
    style: ToastificationStyle.flatColored,
    description: Text(
      message,
      style: bodySmallMedium.copyWith(color: AppColor.semanticError200),
    ),
    icon: const Icon(Icons.info_outline, color: AppColor.semanticError200),
    alignment: Alignment.topCenter,
    closeButton: ToastCloseButton(
      buttonBuilder:
          (context, onClose) => SizedBox.square(
            dimension: 30,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              child: Builder(
                builder: (context) {
                  return InkWell(
                    onTap: onClose,
                    borderRadius: BorderRadius.circular(5),
                    child: const Icon(
                      Icons.close,
                      color: AppColor.semanticError200,
                      size: 18,
                    ),
                  );
                },
              ),
            ),
          ),
    ),
    autoCloseDuration: const Duration(seconds: 3),
    primaryColor: AppColor.semanticError200,
    backgroundColor: AppColor.semanticError0,
    borderRadius: BorderRadius.circular(12.0),
    dragToClose: true,
  );
}
