import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/router/app_router.dart';
import 'cubit/authentication_cubit.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        return switch (state.status) {
          AuthStatus.unauthenticated => {appRouter.go("/")},
          AuthStatus.authenticated => {appRouter.go("/")},
          AuthStatus.unverified => {appRouter.go("/")},
          _ => appRouter.go("/"),
        };
      },
      child: child,
    );
  }
}
