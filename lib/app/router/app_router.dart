import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../core/dependencies/injector.dart';
import '../../core/networks/token_manager.dart';
import '../../features/authentication/cubit/authentication_cubit.dart';
import '../../features/categories/display/categories_screen.dart';
import '../../features/dashboard/display/dashboard_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/notification/display/notification_screen.dart';
import '../../features/product_detail/display/product_detail_screen.dart';
import '../../features/settings/account_settings.dart';
import '../../features/sign_in/data/models/user_decoded_model.dart';
import '../../features/sign_in/display/sign_in_screen.dart';
import '../../features/splash/cubit/splash_cubit.dart';
import '../../features/splash/splash_page.dart';
import '../design_system/design_system.dart';
import 'app_scaffold_with_nav_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: "/splash",
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/splash",
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create:
                (_) =>
                    SplashCubit(authenticationCubit: sl<AuthenticationCubit>())
                      ..initializeApp(),
            child: const SplashScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/categories",
      builder: (context, state) {
        return const CategoriesScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/notifications",
      builder: (context, state) {
        return NotificationScreen(key: state.pageKey);
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppScaffoldWithNavBar(key: state.pageKey, child: child);
      },
      routes: [
        GoRoute(
          path: "/",
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const HomeScreen(),
              ),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: "product/:store/:productId",
              builder: (context, state) {
                final String? store = state.pathParameters['store'];
                final String? productId = state.pathParameters['productId'];
                return ProductDetailScreen(
                  store: store!,
                  productId: productId!,
                );
              },
              redirect: (context, state) {
                final String? store = state.pathParameters['store'];
                final String? productId = state.pathParameters['productId'];
                if (store == null || productId == null) {
                  return "/not_found";
                }
                return null;
              },
            ),
          ],
        ),
        GoRoute(
          path: "/dashboard",
          pageBuilder:
              (_, _) => const NoTransitionPage(child: DashboardScreen()),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: "/account-settings",
              builder: (context, state) {
                return const AccountSettingsScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: "/orders/quotation",
              builder: (_, _) => const QuotationsScreen(),
            ),
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: "/orders",
              builder: (_, _) => const TransactionsScreen(),
            ),
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: "/wishlist",
              builder: (_, _) => const WishlistScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/sign_in",
      builder: (_, _) => const SignInScreen(),
    ),
  ],
);

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: const Center(child: Text("Wishlist")),
    );
  }
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transactions")),
      body: const Center(child: Text("Transactions")),
    );
  }
}

class QuotationsScreen extends StatelessWidget {
  const QuotationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quotations")),
      body: Center(
        child: Column(
          spacing: 6,
          children: [
            const Text("Quotations"),
            ElevatedButton(
              onPressed: () async {
                final AuthToken? genuineToken =
                    await sl<TokenManager>().getAuthToken();

                final AuthToken sampleToken = AuthToken(
                  accessToken: "",
                  refreshToken: "",
                  expiresIn: DateTime(2017, 9, 7, 17, 30),
                  userData: const UserData(),
                );

                final AuthToken emptyToken = AuthToken.empty();

                debugPrint(
                  "is sample token empty ${sampleToken == emptyToken}",
                );

                debugPrint(
                  "is genuine token empty ${genuineToken == emptyToken}",
                );

                debugPrint(
                  "is genuine token equal to sample token ${genuineToken == sampleToken}",
                );

                debugPrint(
                  "is genuine token equal to empty token ${genuineToken == emptyToken}",
                );
              },
              child: const Text("Verify"),
            ),
            const CircleShimmer(size: 48),
            const RectangleShimmer(),
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  spacing: 8,
                  children: [
                    DefaultTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    BlueTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    GreenTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    OrangeTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    RedTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    DarkBlueTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    ForestTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    MaroonTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    DixieOrangeTag(
                      label: "This is Tag",
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  spacing: 8,
                  children: [
                    DefaultSolidTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    BlueSolidTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    const GreenSolidTag(label: "This is Tag"),
                    OrangeSolidTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    RedSolidTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    DarkBlueSolidTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    ForestSolidTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    MaroonSolidTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                    DixieOrangeSolidTag(
                      label: "This is Tag",
                      leading: (iconColor) {
                        return Icon(
                          UniconsLine.chat_bubble_user,
                          color: iconColor,
                          size: 16,
                        );
                      },
                      trailing: (iconColor) {
                        return Icon(
                          UniconsLine.times,
                          color: iconColor,
                          size: 16,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
