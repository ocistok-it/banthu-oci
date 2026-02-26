import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_typography.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastSeenCategorySectionTitle extends StatelessWidget {
  const LastSeenCategorySectionTitle({super.key});

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
        return SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Last Seen Category",
                  style: bodyMediumSemiBold.copyWith(
                    color: AppColor.neutral900,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(height: 0, color: AppColor.neutral100),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
