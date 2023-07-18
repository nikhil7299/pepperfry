import 'package:flutter/material.dart';
import 'package:pepperfry/features/auth/view/complete_sign_up_form.dart';
import 'package:pepperfry/features/auth/view/login_form.dart';
import 'package:pepperfry/features/auth/view/verify_form.dart';

class LoginViewButton extends StatelessWidget {
  final ButtonStyle buttonStyle;
  final Widget child;
  const LoginViewButton({
    super.key,
    required this.child,
    required this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: buttonStyle,
      onPressed: () {
        Navigator.of(context, rootNavigator: true).push(
          ModalBottomSheetRoute(
            useSafeArea: true,
            backgroundColor: Colors.white,
            isScrollControlled: true,
            constraints: const BoxConstraints(maxHeight: 650),
            builder: (context) => Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: 30,
                backgroundColor: Colors.white,
                elevation: 0,
                actions: [
                  IconButton(
                    alignment: Alignment.topRight,
                    icon: const Icon(
                      Icons.clear_sharp,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              body: Navigator(
                observers: [NavigatorObserver()],
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case LoginForm.routeName:
                      return MaterialPageRoute(
                        builder: (context) => LoginForm(
                          phoneText: settings.arguments as String,
                        ),
                      );
                    case CompleteSignUpForm.routeName:
                      return MaterialPageRoute(
                        builder: (context) => CompleteSignUpForm(
                          phoneText: settings.arguments as String,
                        ),
                      );

                    default:
                      return MaterialPageRoute(
                        builder: (context) => const VerifyForm(),
                      );
                  }
                },
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
