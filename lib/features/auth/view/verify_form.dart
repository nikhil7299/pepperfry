import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/constants/app_constants.dart';
import 'package:pepperfry/features/auth/controller/auth_controller.dart';
import 'package:pepperfry/features/auth/view/complete_sign_up_form.dart';
import 'package:pepperfry/features/auth/view/login_form.dart';
import 'package:pepperfry/features/auth/widgets/continue_button.dart';
import 'package:pepperfry/features/auth/widgets/custom_text_field.dart';
import 'package:pepperfry/features/auth/widgets/social_button.dart';

class VerifyForm extends ConsumerStatefulWidget {
  const VerifyForm({super.key});

  @override
  ConsumerState<VerifyForm> createState() => _VerifyFormState();
}

class _VerifyFormState extends ConsumerState<VerifyForm> {
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              "assets/sign_up.jpg",
              fit: BoxFit.fitWidth,
              // height: 100,
              width: 350,
            ),
            const SizedBox(height: 25),
            Text(
              AppConstants.signUpOrLogIn,
              style: TextStyle(
                  color: Colors.brown.shade600, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 22),
            CustomTextField(
              isPhone: true,
              isEnabled: true,
              textInputType: TextInputType.phone,
              hintText: AppConstants.enterPhone,
              textEditingController: phoneController,
            ),
            const SizedBox(height: 18),
            ContinueButton(
              buttonText: "CONTINUE",
              onPressed: () async {
                final navigator = Navigator.of(context);
                final isRegistered = await ref
                    .read(authStateProvider.notifier)
                    .checkUser(phone: phoneController.text, context: context);

                if (isRegistered) {
                  navigator.pushNamed(
                    LoginForm.routeName,
                    arguments: phoneController.text,
                  );
                } else {
                  navigator.pushNamed(
                    CompleteSignUpForm.routeName,
                    arguments: phoneController.text,
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: AppConstants.byContinuing,
                style: const TextStyle(color: Colors.black, fontSize: 12),
                children: [
                  TextSpan(
                    text: AppConstants.termsAndConditions,
                    style: TextStyle(color: Colors.deepOrange.shade500),
                    //! TODO
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            const Text(
              "Or",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Continue with",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            const SizedBox(height: 10),
            SocialButton(
              socialLabel: "Google",
              onTap: () {},
              iconData: Icons.g_translate,
            ),
            const SizedBox(height: 25),
            Image.asset(
              "assets/signup_login_bottom.jpg",
              fit: BoxFit.fitWidth,
              // height: 100,
              width: 400,
            ),
          ],
        ),
      ),
    );
  }
}
