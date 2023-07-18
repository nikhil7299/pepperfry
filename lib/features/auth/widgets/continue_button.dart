import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const ContinueButton(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size.fromWidth(size.width),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.deepOrange.shade500,
      ),
      child: Text(buttonText),
    );
  }
}
