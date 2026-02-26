import '../../../../app/constants/app_assets.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_typography.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastSeenCategorySection extends StatelessWidget {
  const LastSeenCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthenticationCubit, AuthenticationState, AuthStatus>(
      selector: (authenticationState) {
        return authenticationState.status;
      },
      builder: (context, authStatus) {
        if (authStatus == AuthStatus.unauthenticated) {
          return const SliverToBoxAdapter();
        } else if (authStatus == AuthStatus.unknown) {
          return const SliverToBoxAdapter();
        }
        return SliverPadding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 80,
              mainAxisSpacing: 16,
              childAspectRatio: 80 / 92,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 48,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.neutral100),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      AppIcons.defCategoryIcon,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Auto Parts & Accessories",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: captionRegular.copyWith(
                      color: AppColor.neutral900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              childCount: 5,
            ),
          ),
        );
      },
    );
  }
}
