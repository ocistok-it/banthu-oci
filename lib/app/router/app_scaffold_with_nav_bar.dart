import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../core/dependencies/injector.dart';
import '../../features/authentication/cubit/authentication_cubit.dart';
import '../constants/app_assets.dart';
import '../themes/app_colors.dart';
import '../themes/app_typography.dart';
import '../widgets/app_clickable_widget.dart';
import '../widgets/app_toast.dart';

class AppScaffoldWithNavBar extends StatefulWidget {
  const AppScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  State<AppScaffoldWithNavBar> createState() => _AppScaffoldWithNavBarState();
}

class _AppScaffoldWithNavBarState extends State<AppScaffoldWithNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: widget.child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.brandPrimary400,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "Current exchange rate: ",
                      style: bodySmallRegular.copyWith(
                        color: AppColor.neutral0,
                      ),
                      children: [
                        TextSpan(
                          text: "CN¥ 1,00 = 4,80 THB",
                          style: bodySmallSemiBold.copyWith(
                            color: AppColor.neutral0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppClickableWidget(
                  onTap: () {
                    showAppToast(context, message: "Testing");
                  },
                  child: const Icon(
                    UniconsLine.times,
                    color: AppColor.neutral0,
                  ),
                ),
              ],
            ),
          ),
          BottomNavigationBar(
            onTap: _onTap,
            backgroundColor: AppColor.neutral0,
            elevation: 0,
            currentIndex: _getCurrentIndex(context),
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            unselectedLabelStyle: captionRegular.copyWith(
              color: AppColor.neutral700,
            ),
            selectedLabelStyle: captionRegular.copyWith(
              color: AppColor.brandPrimary400,
            ),
            unselectedItemColor: AppColor.neutral700,
            selectedItemColor: AppColor.brandPrimary400,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.banthuNavBarIcon,
                  colorFilter: const ColorFilter.mode(
                    AppColor.neutral700,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Home",
                activeIcon: SvgPicture.asset(AppAssets.banthuNavBarIcon),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppAssets.quotationNavBarIcon),
                label: "Quotation",
                activeIcon: SvgPicture.asset(
                  AppAssets.quotationNavBarIcon,
                  colorFilter: const ColorFilter.mode(
                    AppColor.brandPrimary400,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const BottomNavigationBarItem(
                icon: Icon(UniconsLine.bill, size: 32),
                label: "Transaction",
              ),
              const BottomNavigationBarItem(
                icon: Icon(UniconsLine.heart, size: 32),
                label: "Wishlist",
              ),
              const BottomNavigationBarItem(
                icon: Icon(UniconsLine.user, size: 32),
                label: "Account",
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final GoRouterState route = GoRouterState.of(context);
    final String location = route.uri.toString();
    if (location == '/') {
      return 0;
    }
    if (location == '/dashboard/orders/quotation') {
      return 1;
    }
    if (location == '/dashboard/orders') {
      return 2;
    }
    if (location == '/dashboard/wishlist') {
      return 3;
    }
    if (location == '/dashboard') {
      return 4;
    }
    return 0;
  }

  void _onTap(int value) {
    final int currentIndex = _getCurrentIndex(context);
    final AuthenticationCubit authCubit = sl<AuthenticationCubit>();
    final AuthStatus authStatus = authCubit.state.status;
    final bool loggedIn =
        authStatus == AuthStatus.authenticated ||
        authStatus == AuthStatus.unverified;

    switch (value) {
      case 0:
        if (currentIndex == value) return;
        context.go('/');
      case 1:
        context.push('/dashboard/orders/quotation');
      case 2:
        context.push('/dashboard/orders');
      case 3:
        context.push('/dashboard/wishlist');
      case 4:
        if (currentIndex == value) return;
        if (loggedIn) {
          context.go('/dashboard');
          return;
        }
        context.push('/sign_in');
      default:
        context.go('/');
    }
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = View.of(context).viewPadding.top;
    return SizedBox(height: statusBarHeight);
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
