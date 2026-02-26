import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/design_system/design_system.dart';
import 'app/router/app_router.dart';
import 'app/themes/app_colors.dart';
import 'app/themes/app_typography.dart';
import 'core/dependencies/injector.dart';
import 'features/authentication/auth_guard.dart';
import 'features/authentication/cubit/authentication_cubit.dart';
import 'features/notification/display/blocs/notification_counter_bloc/notification_counter_bloc.dart';

class BanthuApp extends StatelessWidget {
  const BanthuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeScope.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthenticationCubit>()),
        BlocProvider(create: (_) => sl<NotificationCounterBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'Banthu App',
        builder: (context, child) => AuthGuard(child: child!),
        themeMode: theme.themeMode,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(extensions: [theme.appTheme]).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.brandPrimary400,
          ),
          scaffoldBackgroundColor: AppColor.neutral50,
          appBarTheme: AppBarTheme(
            foregroundColor: AppColor.neutral900,
            titleTextStyle: bodyLargeSemiBold.copyWith(
              color: AppColor.neutral900,
            ),
            scrolledUnderElevation: 0,
            actionsIconTheme: const IconThemeData(size: 24),
            elevation: 0,
            backgroundColor: AppColor.neutral0,
          ),
          textTheme: GoogleFonts.interTextTheme(),
        ),
      ),
    );
  }
}
