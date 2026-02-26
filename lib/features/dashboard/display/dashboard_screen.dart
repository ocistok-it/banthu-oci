import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../../app/constants/app_assets.dart';
import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_typography.dart';
import '../../../app/widgets/app_clickable_widget.dart';
import '../../../app/widgets/app_icon_with_badge.dart';
import '../../home/home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardView();
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 3));
      },
      child: CustomScrollView(
        slivers: [
          PinnedHeaderSliver(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              decoration: const BoxDecoration(
                color: AppColor.neutral0,
                border: Border(bottom: BorderSide(color: AppColor.neutral100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Account",
                    style: bodyLargeSemiBold.copyWith(
                      color: AppColor.neutral900,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push("/notifications");
                        },
                        icon: const Icon(UniconsLine.bell),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(UniconsLine.shopping_cart),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: const BoxDecoration(
                color: AppColor.neutral0,
                border: Border(bottom: BorderSide(color: AppColor.neutral100)),
              ),
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
                                style: bodySmallRegular.copyWith(
                                  color: AppColor.neutral600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context.push("./account-settings");
                        },
                        icon: const Icon(UniconsLine.cog),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(color: AppColor.neutral0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Summary Order Management",
                      style: bodyMediumSemiBold.copyWith(
                        color: AppColor.neutral900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraint) {
                      if (constraint.maxWidth < 600) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                width: 70,
                                child: AppIconButton(
                                  boxRadius: 4,
                                  iconPadding: const EdgeInsets.all(2),
                                  icon: AppIconWithBadge(
                                    icon: Image.asset(
                                      AppIcons.iconQuotationProcess,
                                      height: 20,
                                      width: 20,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    ),
                                    count: 1,
                                  ),
                                  label: "Quotation Process",
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                child: AppIconButton(
                                  boxRadius: 4,
                                  iconPadding: const EdgeInsets.all(2),
                                  icon: AppIconWithBadge(
                                    count: 5,
                                    icon: Image.asset(
                                      AppIcons.iconToPay,
                                      height: 20,
                                      width: 20,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  label: "To Pay",
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                child: AppIconButton(
                                  boxRadius: 4,
                                  iconPadding: const EdgeInsets.all(2),
                                  icon: AppIconWithBadge(
                                    count: 900,
                                    icon: Image.asset(
                                      AppIcons.iconAdjustBill,
                                      height: 20,
                                      width: 20,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  label: "Adjust. Bill",
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                child: AppIconButton(
                                  boxRadius: 4,
                                  iconPadding: const EdgeInsets.all(2),
                                  icon: AppIconWithBadge(
                                    count: 59,
                                    icon: Image.asset(
                                      AppIcons.iconShipping,
                                      height: 20,
                                      width: 20,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  label: "Shipping",
                                ),
                              ),
                              Container(
                                width: 70,
                                margin: const EdgeInsets.only(right: 20),
                                child: AppIconButton(
                                  boxRadius: 4,
                                  iconPadding: const EdgeInsets.all(2),
                                  icon: AppIconWithBadge(
                                    count: 32,
                                    icon: Image.asset(
                                      AppIcons.iconToReceive,
                                      height: 20,
                                      width: 20,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  label: "To Receive",
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              width: 70,
                              child: AppIconButton(
                                boxRadius: 4,
                                iconPadding: const EdgeInsets.all(2),
                                icon: AppIconWithBadge(
                                  icon: Image.asset(
                                    AppIcons.iconQuotationProcess,
                                    height: 20,
                                    width: 20,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                  count: 1,
                                ),
                                label: "Quotation Process",
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: AppIconButton(
                                boxRadius: 4,
                                iconPadding: const EdgeInsets.all(2),
                                icon: AppIconWithBadge(
                                  count: 5,
                                  icon: Image.asset(
                                    AppIcons.iconToPay,
                                    height: 20,
                                    width: 20,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                label: "To Pay",
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: AppIconButton(
                                boxRadius: 4,
                                iconPadding: const EdgeInsets.all(2),
                                icon: AppIconWithBadge(
                                  count: 900,
                                  icon: Image.asset(
                                    AppIcons.iconAdjustBill,
                                    height: 20,
                                    width: 20,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                label: "Adjust. Bill",
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: AppIconButton(
                                boxRadius: 4,
                                iconPadding: const EdgeInsets.all(2),
                                icon: AppIconWithBadge(
                                  count: 59,
                                  icon: Image.asset(
                                    AppIcons.iconShipping,
                                    height: 20,
                                    width: 20,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                label: "Shipping",
                              ),
                            ),
                            Container(
                              width: 70,
                              margin: const EdgeInsets.only(right: 20),
                              child: AppIconButton(
                                boxRadius: 4,
                                iconPadding: const EdgeInsets.all(2),
                                icon: AppIconWithBadge(
                                  count: 32,
                                  icon: Image.asset(
                                    AppIcons.iconToReceive,
                                    height: 20,
                                    width: 20,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                label: "To Receive",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(color: AppColor.neutral0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.brandPrimary50,
                  border: Border.all(color: AppColor.brandPrimary100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            const Icon(
                              UniconsLine.wallet,
                              color: AppColor.brandPrimary400,
                              size: 24,
                            ),
                            Text(
                              "Banthu Wallet",
                              style: bodyMediumRegular.copyWith(
                                color: AppColor.neutral900,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            UniconsLine.eye_slash,
                            color: AppColor.neutral900,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "฿56.947,87",
                          style: titleSemiBold.copyWith(
                            color: AppColor.neutral900,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColor.neutral0,
                              ),
                              child: const Icon(
                                UniconsLine.plus,
                                size: 16,
                                color: AppColor.brandPrimary400,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 6.5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColor.neutral0,
                              ),
                              child: Row(
                                spacing: 2,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Details",
                                    style: bodySmallSemiBold.copyWith(
                                      color: AppColor.brandPrimary400,
                                    ),
                                  ),
                                  const Icon(
                                    UniconsLine.arrow_right,
                                    size: 16,
                                    color: AppColor.brandPrimary400,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(color: AppColor.neutral0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardListTile(
                    icon: UniconsLine.receipt,
                    caption: "Transaction List",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.shopping_bag,
                    caption: "Buy Again",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.file_alt,
                    caption: "Product Request",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.heart,
                    caption: "Wishlist",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.ticket,
                    caption: "My Voucher",
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(color: AppColor.neutral0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardListTile(
                    icon: UniconsLine.info_circle,
                    caption: "About Banthu",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.shopping_bag,
                    caption: "How to Order",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.document_info,
                    caption: "Terms & Conditions",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.file_alt,
                    caption: "Request Product Tips",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.wallet,
                    caption: "Banthu Wallet",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.money_withdrawal,
                    caption: "Refund Policy",
                  ),
                  DashboardListTile(
                    icon: UniconsLine.question_circle,
                    caption: "FAQ",
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}

class DashboardListTile extends StatelessWidget {
  const DashboardListTile({
    super.key,
    this.onTap,
    required this.icon,
    required this.caption,
  });

  final void Function()? onTap;
  final IconData icon;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return AppClickableWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Icon(icon, size: 20, color: AppColor.neutral900),
                Text(
                  caption,
                  style: bodySmallSemiBold.copyWith(color: AppColor.neutral900),
                ),
              ],
            ),
            const Icon(
              UniconsLine.angle_right,
              size: 20,
              color: AppColor.neutral900,
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultProfilePicture extends StatelessWidget {
  const DefaultProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.brandPrimary25,
      ),
      child: const Icon(
        UniconsLine.user,
        size: 32,
        color: AppColor.brandPrimary400,
      ),
    );
  }
}
