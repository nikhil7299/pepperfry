import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/features/auth/controller/auth_controller.dart';
import 'package:pepperfry/features/auth/widgets/continue_button.dart';
import 'package:pepperfry/features/auth/widgets/custom_text_field.dart';

// mobile,otp, name, email,login btn
class CompleteSignUpForm extends ConsumerStatefulWidget {
  static const String routeName = '/completeSignUp';
  final String phoneText;
  const CompleteSignUpForm({
    super.key,
    required this.phoneText,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteSignUpFormState();
}

class _CompleteSignUpFormState extends ConsumerState<CompleteSignUpForm> {
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
              "Sign Up Now",
              style: TextStyle(
                  color: Colors.brown.shade600, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              isPhone: false,
              hintText: '+ 91 ${widget.phoneText}',
              isEnabled: false,
              textInputType: TextInputType.phone,
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
            CustomTextField(
              isPhone: false,
              hintText: "Enter Name",
              isEnabled: true,
              textInputType: TextInputType.name,
              textEditingController: nameController,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              isPhone: false,
              hintText: "Enter Email",
              isEnabled: true,
              textInputType: TextInputType.emailAddress,
              textEditingController: emailController,
            ),
            const SizedBox(height: 15),
            ContinueButton(
              buttonText: "Sign Up",
              onPressed: () async {
                await ref.read(authStateProvider.notifier).signUpUser(
                      phone: widget.phoneText,
                      otp: otpController.text,
                      name: nameController.text,
                      email: emailController.text,
                      context: context,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
