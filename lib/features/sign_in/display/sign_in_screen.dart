import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../app/constants/app_constants.dart';
import '../../../app/design_system/design_system.dart';
import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_typography.dart';
import '../../../app/widgets/app_clickable_widget.dart';
import '../../../app/widgets/app_toast.dart';
import '../../../core/dependencies/injector.dart';
import '../../authentication/cubit/authentication_cubit.dart';
import '../data/models/login_payload.dart';
import '../domain/usecases/sign_in_usecase.dart';
import 'bloc/sign_in_bloc.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SignInBloc(
            authCubit: sl<AuthenticationCubit>(),
            usecase: sl<SignInUsecase>(),
          ),
      child: const SignInScreenView(),
    );
  }
}

class SignInScreenView extends StatefulWidget {
  const SignInScreenView({super.key});

  @override
  State<SignInScreenView> createState() => _SignInScreenViewState();
}

class _SignInScreenViewState extends State<SignInScreenView> {
  late CheckManager _check;
  late PasswordVisibility _passwordVisibility;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _check = CheckManager();
    _passwordVisibility = PasswordVisibility();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _check.dispose();
    _passwordVisibility.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.neutral50,
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInLoadFailure) {
            showAppToast(context, message: state.exception.toString());
          }
        },
        child: SafeArea(
          child: SignInMobileLayout(
            check: _check,
            passwordVisibility: _passwordVisibility,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatelessWidget {
  const PasswordForm({
    super.key,
    required this.passwordController,
    required this.passwordVisibility,
  });

  final TextEditingController passwordController;
  final PasswordVisibility passwordVisibility;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: passwordVisibility.obscureText,
      builder: (_, obscureText, _) {
        return AppTextField(
          controller: passwordController,
          obscureText: obscureText,
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: IconButton(
            onPressed: () {
              passwordVisibility.showHidePassword();
            },
            icon:
                obscureText
                    ? const Icon(UniconsLine.eye)
                    : const Icon(UniconsLine.eye_slash),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Password cannot be empty!";
            } else if (value.length < 5) {
              return "Password cannot less than 5";
            }
            return null;
          },
        );
      },
    );
  }
}

class EmailForm extends StatelessWidget {
  const EmailForm({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email cannot be empty!";
        } else if (value.length < 5) {
          return "Email cannot less than 5";
        }
        return null;
      },
    );
  }
}

class SignInMobileLayout extends StatefulWidget {
  const SignInMobileLayout({
    super.key,
    required this.check,
    required this.passwordVisibility,
    required this.emailController,
    required this.passwordController,
  });

  final CheckManager check;
  final PasswordVisibility passwordVisibility;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignInMobileLayout> createState() => _SignInMobileLayoutState();
}

class _SignInMobileLayoutState extends State<SignInMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.kDefaultPadding,
          vertical: AppConstants.kDefaultPadding,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome Back to Banthu", style: titleSemiBold),
              const SizedBox(height: 8.0),
              const Text(
                "Log in to connect with trusted suppliers and manage your imports.",
                style: bodyLargeRegular,
              ),
              const SizedBox(height: 24.0),
              Text(
                "Email",
                style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
              ),
              const SizedBox(height: 6.0),
              EmailForm(emailController: widget.emailController),
              const SizedBox(height: 16.0),
              Text(
                "Password",
                style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
              ),
              const SizedBox(height: 6.0),
              PasswordForm(
                passwordController: widget.passwordController,
                passwordVisibility: widget.passwordVisibility,
              ),
              const SizedBox(height: 16.0),
              RememberAndForgotPassword(check: widget.check),
              const SizedBox(height: 24.0),
              SignInButton(
                check: widget.check,
                emailController: widget.emailController,
                passwordController: widget.passwordController,
              ),
              const SizedBox(height: 24.0),
              Row(
                spacing: 24.0,
                children: [
                  const Expanded(
                    child: Divider(
                      color: AppColor.greyscale50,
                      thickness: 1.0,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    "or",
                    style: bodyMediumRegular.copyWith(
                      color: AppColor.neutral70,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: AppColor.greyscale50,
                      thickness: 1.0,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.neutral900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Continue with Google",
                    style: bodyLargeSemiBold.copyWith(
                      color: AppColor.neutral900,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: bodyMediumRegular.copyWith(
                      color: AppColor.neutral700,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: bodyMediumSemiBold.copyWith(
                          color: AppColor.neutral900,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckManager {
  ValueNotifier<bool> isActive = ValueNotifier(false);
  bool get isActiveValue => isActive.value;

  void activeDeactive() {
    isActive.value = !isActive.value;
  }

  void dispose() {
    isActive.dispose();
  }
}

class PasswordVisibility {
  ValueNotifier<bool> obscureText = ValueNotifier(true);
  bool get isObscureText => obscureText.value;

  void showHidePassword() {
    obscureText.value = !obscureText.value;
  }

  void dispose() {
    obscureText.dispose();
  }
}

class RememberAndForgotPassword extends StatefulWidget {
  const RememberAndForgotPassword({super.key, required this.check});

  final CheckManager check;

  @override
  State<RememberAndForgotPassword> createState() =>
      _RememberAndForgotPasswordState();
}

class _RememberAndForgotPasswordState extends State<RememberAndForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppClickableWidget(
          onTap: () {
            widget.check.activeDeactive();
          },
          child: Row(
            spacing: 8.0,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: ValueListenableBuilder(
                  valueListenable: widget.check.isActive,
                  builder: (_, isActive, _) {
                    return AppCheckBox(
                      value: isActive,
                      onChanged: (value) {
                        widget.check.activeDeactive();
                      },
                    );
                  },
                ),
              ),
              const Text("Remember me", style: bodyMediumRegular),
            ],
          ),
        ),
        AppClickableWidget(
          onTap: () {
            debugPrint("Forgot Password");
          },
          child: const Text("Forgot Password?", style: bodyMediumRegular),
        ),
      ],
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.check,
    required this.emailController,
    required this.passwordController,
  });

  final CheckManager check;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        if (state is SignInLoadInProgress) {
          return const SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: "Loading...",
              appButtonSize: AppButtonSize.large,
              onTap: null,
            ),
          );
        }
        return SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            label: "Login",
            onTap: () {
              debugPrint("request login");
              if (formKey.currentState?.validate() ?? false) {
                debugPrint(emailController.text);
                debugPrint(passwordController.text);
                final SignInPayload payload = SignInPayload(
                  email: emailController.text,
                  password: passwordController.text,
                );
                context.read<SignInBloc>().add(
                  SignInRequested(payload: payload),
                );
              }
            },
            appButtonSize: AppButtonSize.large,
          ),
        );
      },
    );
  }
}
