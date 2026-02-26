import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../app/constants/app_assets.dart';
import '../../app/constants/app_constants.dart';
import '../../app/design_system/design_system.dart';
import '../../app/router/app_router.dart';
import '../../app/themes/app_colors.dart';
import '../../app/themes/app_typography.dart';
import '../../app/widgets/app_clickable_widget.dart';
import '../../app/widgets/app_icon_with_badge.dart';
import '../../app/widgets/product_card.dart';
import '../../core/utils/lorem_ipsum_generator.dart';
import '../authentication/cubit/authentication_cubit.dart';
import '../notification/display/blocs/notification_counter_bloc/notification_counter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenView();
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 3));
      },
      child: CustomScrollView(
        slivers: [
          const HomeProductRequestPanel(),
          const HomeAppBar(),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              const HomeBannerPanel(),
              const HomeVerifyPanel(),
              SizedBox(
                height: 128.0,
                child: ListView.separated(
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 8),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: 100,
                  itemBuilder: (BuildContext context, int index) {
                    return AppClickableWidget(
                      onTap: () {
                        context.push("/categories");
                      },
                      child: Container(
                        width: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Column(
                          spacing: 8.0,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColor.brandPrimary25,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(Icons.abc, size: 32),
                            ),
                            Text(
                              "Auto Parts & Accessories",
                              textAlign: TextAlign.center,
                              style: captionRegular.copyWith(
                                color: AppColor.neutral900,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Based on your search",
                      style: bodyLargeSemiBold.copyWith(
                        color: AppColor.neutral900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 266.0,
                    child: ListView.separated(
                      separatorBuilder:
                          (_, index) => const SizedBox(width: 16.0),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 10,
                        bottom: 10,
                      ),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        final productName = LoremIpsumGenerator.generate();
                        final productPrice = Random().nextInt(500);
                        return ProductCard(
                          productName: productName,
                          productPrice: productPrice,
                          onTap: () {
                            context.push("/product/1688/795293963816");
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              const HomeAdsPanel(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Image.asset(
                              AppIcons.cogsIcon,
                              height: 24,
                              width: 24,
                            ),
                            Text(
                              "Industrial Products",
                              style: bodyLargeSemiBold.copyWith(
                                color: AppColor.neutral900,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "See more",
                          style: bodySmallSemiBold.copyWith(
                            color: AppColor.brandPrimary400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 0,
                    ),
                    child: AspectRatio(
                      aspectRatio: 350 / 146,
                      child: Image.asset(
                        AppAssets.homebanner1,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 266.0,
                    child: ListView.separated(
                      separatorBuilder:
                          (_, index) => const SizedBox(width: 16.0),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 10,
                        bottom: 10,
                      ),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        final productName = LoremIpsumGenerator.generate();
                        final productPrice = Random().nextInt(500);
                        return ProductCard(
                          productName: productName,
                          productPrice: productPrice,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const HomeInfoPanel(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Image.asset(
                          "assets/images/ic_cogs.png",
                          height: 24,
                          width: 24,
                        ),
                        Text(
                          "Trending Product",
                          style: bodyLargeSemiBold.copyWith(
                            color: AppColor.neutral900,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "See more",
                      style: bodySmallSemiBold.copyWith(
                        color: AppColor.brandPrimary400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ]),
          ),
          // SliverLayoutBuilder(
          //   builder: (_, constraints) {
          //     if (constraints.crossAxisExtent < 600) {
          //       return SliverPadding(
          //         padding: const EdgeInsets.symmetric(horizontal: 20),
          //         sliver: SliverGrid.builder(
          //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 2,
          //             mainAxisSpacing: 16,
          //             crossAxisSpacing: 16,
          //             childAspectRatio: 167 / 266,
          //           ),
          //           itemCount: 10,
          //           itemBuilder: (_, _) {
          //             final productName = LoremIpsumGenerator.generate();
          //             final productPrice = Random().nextInt(500);
          //             return ProductCard(
          //               productName: productName,
          //               productPrice: productPrice,
          //             );
          //           },
          //         ),
          //       );
          //     }
          //     return SliverPadding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       sliver: SliverGrid.builder(
          //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //           maxCrossAxisExtent: 167,
          //           mainAxisSpacing: 16,
          //           crossAxisSpacing: 16,
          //           childAspectRatio: 167 / 266,
          //         ),
          //         itemCount: 10,
          //         itemBuilder: (_, _) {
          //           final productName = LoremIpsumGenerator.generate();
          //           final productPrice = Random().nextInt(500);
          //           return ProductCard(
          //             productName: productName,
          //             productPrice: productPrice,
          //           );
          //         },
          //       ),
          //     );
          //   },
          // ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 167 / 266,
              ),
              itemCount: 10,
              itemBuilder: (_, _) {
                final productName = LoremIpsumGenerator.generate();
                final productPrice = Random().nextInt(500);
                return ProductCard(
                  productName: productName,
                  productPrice: productPrice,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PinnedHeaderSliver(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        color: AppColor.neutral0,
        child:
            BlocSelector<AuthenticationCubit, AuthenticationState, AuthStatus>(
              selector: (authenticationState) {
                return authenticationState.status;
              },
              builder: (context, authStatus) {
                return switch (authStatus) {
                  AuthStatus.unauthenticated => searchbarWithLoginButton(),
                  AuthStatus.unknown => searchbarWithLoginButton(),
                  AuthStatus.authenticated => Row(
                    spacing: 8.0,
                    children: [
                      searchBar(),
                      IconButton(
                        onPressed: () {
                          context.push("/notifications");
                        },
                        icon: BlocBuilder<
                          NotificationCounterBloc,
                          NotificationCounterState
                        >(
                          builder: (context, state) {
                            if (state.status == AppStatus.complete) {
                              return AppIconWithBadge(
                                icon: const Icon(UniconsLine.bell),
                                count: state.counter,
                              );
                            }
                            return AppIconWithBadge.empty(
                              icon: const Icon(UniconsLine.bell),
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const AppIconWithBadge(
                          count: 23,
                          icon: Icon(UniconsLine.shopping_cart),
                        ),
                      ),
                    ],
                  ),
                  AuthStatus.unverified => Row(
                    spacing: 8.0,
                    children: [
                      searchBar(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(UniconsLine.bell),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(UniconsLine.shopping_cart),
                      ),
                    ],
                  ),
                };
              },
            ),
      ),
    );
  }

  Expanded searchBar() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.neutral100),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              spacing: 8.0,
              children: [
                Icon(UniconsLine.search, color: AppColor.neutral700),
                Text("Search item...", style: bodyLargeRegular),
              ],
            ),
            BlocSelector<AuthenticationCubit, AuthenticationState, AuthStatus>(
              selector: (authenticationState) {
                return authenticationState.status;
              },
              builder: (context, authStatus) {
                switch (authStatus) {
                  case AuthStatus.unauthenticated:
                  case AuthStatus.unknown:
                    return const SizedBox.shrink();
                  case AuthStatus.authenticated:
                  case AuthStatus.unverified:
                    return AppClickableWidget(
                      onTap: () {},
                      child: const Icon(
                        UniconsLine.image_search,
                        color: AppColor.neutral700,
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row searchbarWithLoginButton() {
    return Row(
      spacing: 8.0,
      children: [
        searchBar(),
        PrimaryButton(
          label: "Login",
          onTap: () {
            appRouter.push("/sign_in");
          },
          appButtonSize: AppButtonSize.small,
        ),
      ],
    );
  }
}

class HomeProductRequestPanel extends StatelessWidget {
  const HomeProductRequestPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return PinnedHeaderSliver(
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.productRequestBanner),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8.0,
              children: [
                AppClickableWidget(
                  onTap: () {},
                  child: const Icon(UniconsLine.times),
                ),
                Image.asset(AppAssets.productRequestIllustration),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product Request", style: bodySmallSemiBold),
                    Text(
                      "Calculate your imagined products.",
                      style: captionRegular,
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.neutral0,
                foregroundColor: AppColor.brandPrimary400,
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 6.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    "Quote Now",
                    style: captionSemiBold.copyWith(
                      color: AppColor.brandPrimary400,
                    ),
                  ),
                  const Icon(UniconsLine.arrow_right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeInfoPanel extends StatelessWidget {
  const HomeInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: AppIconButton(
              onTap: () => debugPrint("About Banthu"),
              icon: Image.asset(
                AppIcons.iconAboutBanthu,
                height: 32,
                width: 32,
              ),
              label: "About Banthu",
            ),
          ),
          Flexible(
            child: AppIconButton(
              onTap: () => debugPrint("How to Order"),
              icon: Image.asset(AppIcons.iconHowToOrder, height: 32, width: 32),
              label: "How to Order",
            ),
          ),
          Flexible(
            child: AppIconButton(
              onTap: () => debugPrint("Terms & Conditions"),
              icon: Image.asset(AppIcons.iconTnC, height: 32, width: 32),
              label: "Terms & Conditions",
            ),
          ),
          Flexible(
            child: AppIconButton(
              onTap: () => debugPrint("Request Product Tips"),
              icon: Image.asset(
                AppIcons.iconProductTips,
                height: 32,
                width: 32,
              ),
              label: "Request Product Tips",
            ),
          ),
          Flexible(
            child: AppIconButton(
              onTap: () => debugPrint("Banthu Wallet"),
              icon: Image.asset(
                AppIcons.iconBanthuWallet,
                height: 32,
                width: 32,
              ),
              label: "Banthu Wallet",
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAdsPanel extends StatelessWidget {
  const HomeAdsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.brandPrimary25,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        spacing: 8.0,
        children: [
          Text(
            "Why choose Banthu for your business?",
            style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColor.neutral0,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColor.neutral100),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.5),
                    child: Column(
                      spacing: 4,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.brandPrimary25,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: AppColor.brandPrimary400),
                          ),
                          child: Image.asset(
                            AppIcons.iconFreeShipping,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        Text(
                          "Free Shipping",
                          textAlign: TextAlign.center,
                          style: captionSemiBold.copyWith(
                            color: AppColor.neutral900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.5),
                    child: Column(
                      spacing: 4,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.brandPrimary25,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: AppColor.brandPrimary400),
                          ),
                          child: Image.asset(
                            AppIcons.iconPriceAllIn,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        Text(
                          "Price ALL-IN",
                          textAlign: TextAlign.center,
                          style: captionSemiBold.copyWith(
                            color: AppColor.neutral900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.5),
                    child: Column(
                      spacing: 4,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.brandPrimary25,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: AppColor.brandPrimary400),
                          ),
                          child: Image.asset(
                            AppIcons.iconFreeMembership,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        Text(
                          "Free Membership",
                          textAlign: TextAlign.center,
                          style: captionSemiBold.copyWith(
                            color: AppColor.neutral900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.5),
                    child: Column(
                      spacing: 4,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.brandPrimary25,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: AppColor.brandPrimary400),
                          ),
                          child: Image.asset(
                            AppIcons.iconPaymentSecure,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        Text(
                          "Secure Payment",
                          textAlign: TextAlign.center,
                          style: captionSemiBold.copyWith(
                            color: AppColor.neutral900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeVerifyPanel extends StatelessWidget {
  const HomeVerifyPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthenticationCubit, AuthenticationState, AuthStatus>(
      selector: (authenticationState) => authenticationState.status,
      builder: (_, authStatus) {
        return switch (authStatus) {
          AuthStatus.authenticated => const SizedBox.shrink(),
          AuthStatus.unauthenticated => const SizedBox.shrink(),
          AuthStatus.unknown => const SizedBox.shrink(),
          AuthStatus.unverified => verifyBox(),
        };
      },
    );
  }

  Widget verifyBox() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.neutral100),
      borderRadius: BorderRadius.circular(8.0),
      color: AppColor.brandPrimary25,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify Your Email!",
                style: bodySmallSemiBold.copyWith(color: AppColor.neutral900),
              ),
              Text(
                "Please verify your email address to activate your account and enjoy all features.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: captionRegular.copyWith(color: AppColor.neutral600),
              ),
            ],
          ),
        ),
        PrimaryButton(
          label: "Verify",
          appButtonSize: AppButtonSize.xsmall,
          trailing:
              (iconColor) => Icon(UniconsLine.arrow_right, color: iconColor),
          onTap: () {
            print("Verify");
          },
        ),
      ],
    ),
  );
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.onTap,
    required this.icon,
    required this.label,
    this.iconPadding = const EdgeInsets.all(8),
    this.boxRadius = 8,
  });

  final VoidCallback? onTap;
  final Widget icon;
  final String label;
  final EdgeInsetsGeometry? iconPadding;
  final double boxRadius;

  @override
  Widget build(BuildContext context) {
    return AppClickableWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          spacing: 8,
          children: [
            Container(
              padding: iconPadding,
              decoration: BoxDecoration(
                color: AppColor.brandPrimary25,
                borderRadius: BorderRadius.circular(boxRadius),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: const Color(0xFF1C202B).withValues(alpha: 0.04),
                    offset: const Offset(0, 1),
                  ),
                  BoxShadow(
                    blurRadius: 3,
                    color: const Color(0xFF1C202B).withValues(alpha: 0.05),
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: icon,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: captionRegular.copyWith(color: AppColor.neutral900),
            ),
          ],
        ),
      ),
    );
  }
}

class IndicatorModel with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class HomeBannerPanel extends StatefulWidget {
  const HomeBannerPanel({super.key});

  static const double _aspectRatio = 2.19 / 1;
  static const double _horizontalPadding = 20.0;
  static const double _verticalPadding = 16.0;

  @override
  State<HomeBannerPanel> createState() => _HomeBannerPanelState();
}

class _HomeBannerPanelState extends State<HomeBannerPanel> {
  final IndicatorModel _indicator = IndicatorModel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: HomeBannerPanel._aspectRatio,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _indicator.setCurrentIndex(index);
            },
          ),
          items: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: HomeBannerPanel._verticalPadding,
                horizontal: HomeBannerPanel._horizontalPadding,
              ),
              child: Image.asset(
                AppAssets.homebanner1,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: HomeBannerPanel._verticalPadding,
                horizontal: HomeBannerPanel._horizontalPadding,
              ),
              child: Image.asset(
                AppAssets.homebanner2,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ),
          ],
        ),
        Positioned(
          left: 32,
          bottom: 36,
          right: 32,
          child: SizedBox(
            height: 8,
            child: ListView.separated(
              separatorBuilder: (_, _) => const SizedBox(width: 4.0),
              itemBuilder: (_, index) {
                return IndicatorWidget(
                  indicatorNotifier: _indicator,
                  bannerIndex: index,
                );
              },
              itemCount: 2,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({
    super.key,
    required IndicatorModel indicatorNotifier,
    required int bannerIndex,
  }) : _indicatorNotifier = indicatorNotifier,
       _bannerIndex = bannerIndex;

  final IndicatorModel _indicatorNotifier;
  final int _bannerIndex;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _indicatorNotifier,
      builder: (_, _) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _indicatorNotifier.currentIndex == _bannerIndex
                    ? AppColor.neutral0
                    : AppColor.greyscale50,
          ),
        );
      },
    );
  }
}
