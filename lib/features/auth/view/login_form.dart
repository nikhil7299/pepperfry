import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/features/auth/controller/auth_controller.dart';
import 'package:pepperfry/features/auth/widgets/continue_button.dart';
import 'package:pepperfry/features/auth/widgets/custom_text_field.dart';

// mobile,otp,login btn
class LoginForm extends ConsumerStatefulWidget {
  static const String routeName = '/signUpLoginForm';

  final String phoneText;

  const LoginForm({
    super.key,
    required this.phoneText,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  late final TextEditingController otpController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    otpController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(
              "assets/sign_up.jpg",
              fit: BoxFit.fitWidth,
              // height: 100,
              width: 350,
            ),
            const SizedBox(height: 20),
            Text(
              "Welcome Back",
              style: TextStyle(
                  color: Colors.brown.shade600, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              isPhone: false,
              textInputType: TextInputType.phone,
              hintText: '+ 91 ${widget.phoneText}',
              isEnabled: false,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Change Phone Number",
                  style: TextStyle(
                      color: Colors.deepOrange.shade500, fontSize: 11.3),
                ),
              ),
            ),
            CustomTextField(
              isPhone: false,
              isEnabled: true,
              textInputType: TextInputType.number,
              hintText: 'Enter OTP recieved on Mobile Number',
              textEditingController: otpController,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                    color: Colors.deepOrange.shade500,
                    fontSize: 11.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ContinueButton(
              buttonText: "CONTINUE",
              onPressed: () async {
                await ref.read(authStateProvider.notifier).verifyPhone(
                      context: context,
                      phone: widget.phoneText,
                      otp: otpController.text,
                    );
              },
            ),
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
