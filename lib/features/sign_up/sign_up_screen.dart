import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app/constants/app_constants.dart';
import '../../app/themes/app_colors.dart';
import '../../app/themes/app_typography.dart';
import '../../app/widgets/app_elevated_button.dart';
import '../../app/widgets/app_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUpScreenView();
  }
}

class SignUpScreenView extends StatefulWidget {
  const SignUpScreenView({super.key});

  @override
  State<SignUpScreenView> createState() => _SignUpScreenViewState();
}

class _SignUpScreenViewState extends State<SignUpScreenView> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;

  late ValueNotifier<bool> _passwordVisibilityNotifier;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisibilityNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _passwordVisibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.neutral50,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return SignUpMobileLayout(
                fullNameController: _fullNameController,
                emailController: _emailController,
                phoneNumberController: _phoneNumberController,
                passwordController: _passwordController,
                passwordVisibilityNotifier: _passwordVisibilityNotifier,
              );
            } else if (constraints.maxWidth < 1200) {
              return SignUpTabletLayout(
                fullNameController: _fullNameController,
                emailController: _emailController,
                phoneNumberController: _phoneNumberController,
                passwordController: _passwordController,
                passwordVisibilityNotifier: _passwordVisibilityNotifier,
              );
            } else {
              return const Center(child: Text('Desktop is not supported yet'));
            }
          },
        ),
      ),
    );
  }
}

class SignUpMobileLayout extends StatefulWidget {
  const SignUpMobileLayout({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.passwordController,
    required this.passwordVisibilityNotifier,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> passwordVisibilityNotifier;

  @override
  State<SignUpMobileLayout> createState() => _SignUpMobileLayoutState();
}

class _SignUpMobileLayoutState extends State<SignUpMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.kDefaultPadding,
          vertical: AppConstants.kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Join Banthu and Start Importing Smarter",
              style: titleSemiBold,
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Register to connect with trusted suppliers and manage your business imports in one place.",
              style: bodyLargeRegular,
            ),
            const SizedBox(height: 24.0),
            Text(
              "Full Name",
              style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 6.0),
            AppTextFormField(controller: widget.fullNameController),
            const SizedBox(height: 16.0),
            Text(
              "Email",
              style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 6.0),
            AppTextFormField(controller: widget.emailController),
            const SizedBox(height: 16.0),
            Text(
              "Phone Number",
              style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 6.0),
            AppTextFormField(controller: widget.emailController),
            const SizedBox(height: 16.0),
            Text(
              "Password",
              style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 6.0),
            AppTextFormField(controller: widget.passwordController),
            const SizedBox(height: 24.0),
            const SignUpButton(),
            const SizedBox(height: 8.0),
            const RegistersNote(),
            const SizedBox(height: 24.0),
            const DividerOr(),
            const SizedBox(height: 24.0),
            const RegisterWithGoogleButton(),
            const SizedBox(height: 24.0),
            const AlreadyHaveAccount(),
            // SizedBox(
            //   height: 500,
            //   child: Stack(
            //     clipBehavior: Clip.none,
            //     children: <Widget>[
            //       RecaptchaV2(
            //         apiKey: AppSecrets.reCaptchaKey,
            //         apiSecret: AppSecrets.reCaptchaSecret,
            //         controller: recaptchaV2Controller,
            //         pluginURL: AppSecrets.reCaptchaUrl,
            //         onVerifiedError: (err) {},
            //         onVerifiedSuccessfully: (success) {},
            //       ),
            //       Positioned(
            //         left: 0,
            //         right: 0,
            //         bottom: 0,
            //         child: Column(
            //           children: [
            //             SignUpButton(),
            //             SizedBox(height: 8.0),
            //             RegistersNote(),
            //             SizedBox(height: 24.0),
            //             DividerOr(),
            //             SizedBox(height: 24.0),
            //             RegisterWithGoogleButton(),
            //             SizedBox(height: 24.0),
            //             AlreadyHaveAccount(),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class SignUpTabletLayout extends StatefulWidget {
  const SignUpTabletLayout({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.passwordController,
    required this.passwordVisibilityNotifier,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> passwordVisibilityNotifier;

  @override
  State<SignUpTabletLayout> createState() => _SignUpTabletLayoutState();
}

class _SignUpTabletLayoutState extends State<SignUpTabletLayout> {
  String verifyResult = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.kDefaultPadding,
          vertical: AppConstants.kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Join Banthu and Start Importing Smarter",
              style: titleSemiBold,
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Register to connect with trusted suppliers and manage your business imports in one place.",
              style: bodyLargeRegular,
            ),
            const SizedBox(height: 24.0),
            Text(
              "Full Name",
              style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 6.0),
            AppTextFormField(controller: widget.fullNameController),
            const SizedBox(height: 16.0),
            Text(
              "Email",
              style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 6.0),
            AppTextFormField(controller: widget.emailController),
            const SizedBox(height: 16.0),
            Text(
              "Phone Number",
              style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 6.0),
            AppTextFormField(controller: widget.emailController),
            const SizedBox(height: 16.0),
            Text(
              "Password",
              style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
            ),
            const SizedBox(height: 6.0),
            AppTextFormField(controller: widget.passwordController),
            const SizedBox(height: 24.0),
            const SizedBox(
              height: 350,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        SignUpButton(),
                        SizedBox(height: 8.0),
                        RegistersNote(),
                        SizedBox(height: 24.0),
                        DividerOr(),
                        SizedBox(height: 24.0),
                        RegisterWithGoogleButton(),
                        SizedBox(height: 24.0),
                        AlreadyHaveAccount(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistersNote extends StatelessWidget {
  const RegistersNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "By clicking the Register button, I agree to the ",
          style: bodySmallRegular.copyWith(color: AppColor.neutral600),
          children: [
            TextSpan(
              text: "Terms & Conditions",
              style: bodySmallSemiBold.copyWith(
                color: AppColor.brandPrimary400,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint("terms and conditions tapped");
                    },
            ),
            TextSpan(
              text: " and ",
              style: bodySmallRegular.copyWith(color: AppColor.neutral600),
            ),
            TextSpan(
              text: "Privacy Policy",
              style: bodySmallSemiBold.copyWith(
                color: AppColor.brandPrimary400,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint("Privacy Policy tapped");
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterWithGoogleButton extends StatelessWidget {
  const RegisterWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          "Register with Google",
          style: bodyLargeSemiBold.copyWith(color: AppColor.neutral900),
        ),
      ),
    );
  }
}

class DividerOr extends StatelessWidget {
  const DividerOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
          style: bodyMediumRegular.copyWith(color: AppColor.neutral70),
        ),
        const Expanded(
          child: Divider(
            color: AppColor.greyscale50,
            thickness: 1.0,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: bodyMediumRegular.copyWith(color: AppColor.neutral70),
          children: [
            TextSpan(
              text: "Login Here",
              style: bodyMediumSemiBold.copyWith(color: AppColor.neutral900),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint("Login here tapped");
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpButton extends StatefulWidget {
  const SignUpButton({super.key});

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return AppElevatedButton.primary(text: "Sign Up", onPressed: () {});
  }
}
