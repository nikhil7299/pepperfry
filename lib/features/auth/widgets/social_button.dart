import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String socialLabel;
  final VoidCallback onTap;
  final IconData iconData;
  const SocialButton(
      {super.key,
      required this.socialLabel,
      required this.onTap,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
          fixedSize: Size.fromWidth(size.width),
          side: const BorderSide(width: 1, color: Colors.black12)),
      onPressed: onTap,
      icon: Icon(
        iconData,
        size: 15,
      ),
      label: Text(
        socialLabel,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
