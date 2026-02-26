import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../app/constants/constants.dart';
import '../../app/design_system/design_system.dart';
import '../../app/themes/app_colors.dart';
import '../../app/themes/app_typography.dart';
import '../authentication/cubit/authentication_cubit.dart';
import '../dashboard/display/dashboard_screen.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Setting"),
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: AppColor.neutral100)),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: const BoxDecoration(color: AppColor.neutral0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        const DefaultProfilePicture(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              spacing: 8,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Dao Siriporn",
                                  style: bodyLargeSemiBold.copyWith(
                                    color: AppColor.neutral900,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.neutral100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Silver",
                                        style: captionMedium.copyWith(
                                          color: AppColor.neutral700,
                                        ),
                                      ),
                                      const Icon(
                                        UniconsLine.angle_right,
                                        size: 16,
                                        color: AppColor.neutral700,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "siripondao@mail.com",
                              style: AppTypography.bodySmallRegular.copyWith(
                                color: AppColor.neutral600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        UniconsLine.edit,
                        color: AppColor.brandPrimary400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(color: AppColor.neutral0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardListTile(
                  icon: UniconsLine.map_marker,
                  caption: "Address List",
                ),
                DashboardListTile(
                  icon: UniconsLine.card_atm,
                  caption: "Bank Account",
                ),
                DashboardListTile(
                  icon: UniconsLine.lock,
                  caption: "Change Password",
                ),
                DashboardListTile(
                  icon: UniconsLine.language,
                  caption: "Change Language",
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SecondaryButton(
              label: "Sign Out",
              appButtonSize: AppButtonSize.small,
              onTap: () async {
                final String? dialogResult = await showAdaptiveDialog<String>(
                  context: context,
                  builder: (context) {
                    return Dialog.fullscreen(
                      backgroundColor: AppColor.neutral50,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(AppAssets.signOutIllustration),
                            const SizedBox(height: 24),
                            Text(
                              "Are you sure you want to sign out?",
                              style: titleSemiBold.copyWith(
                                color: AppColor.neutral900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "You'll need to sign in again to access your account.",
                              style: bodyLargeRegular.copyWith(
                                color: AppColor.neutral700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: SecondaryButton(
                                appButtonSize: AppButtonSize.large,
                                label: "Sign Out",
                                onTap: () {
                                  Navigator.pop(context, "ok");
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                appButtonSize: AppButtonSize.large,
                                label: "Cancel",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                if (dialogResult == null) return;
                if (!context.mounted) return;
                context.read<AuthenticationCubit>().logout();
              },
            ),
          ),
          const SizedBox(height: 8),
          const Center(child: Text("version: ${FlutterVersion.version}")),
        ],
      ),
    );
  }
}
