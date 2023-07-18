import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/constants/app_constants.dart';
import 'package:pepperfry/features/auth/view/login_view_button.dart';

class AuthSplashView extends ConsumerWidget {
  const AuthSplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Auth splash view"),
            LoginViewButton(
              buttonStyle: FilledButton.styleFrom(elevation: 0),
              child: const Text(AppConstants.signUpOrLogIn),
            ),
          ],
        ),
      ),
    );
  }
}
