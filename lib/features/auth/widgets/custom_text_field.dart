import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType textInputType;
  final bool isPhone;
  final bool isEnabled;
  final TextEditingController? textEditingController;
  final String hintText;
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.textEditingController,
      required this.isEnabled,
      required this.isPhone,
      required this.textInputType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      enabled: widget.isEnabled,
      enableInteractiveSelection: true,
      controller: widget.textEditingController,
      cursorColor: Colors.orange.shade900,
      keyboardType: widget.textInputType,
      style: const TextStyle(fontSize: 12.3),
      // onChanged: (value) {
      //   final isParsed = int.tryParse(value);
      //   showPrefix = value.isNotEmpty && value.length <= 10 && isParsed != null;
      //   setState(() {});
      // },
      decoration: InputDecoration(
        prefix: Text(widget.isPhone ? "+ 91 " : ''),
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 12.3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        filled: true,
        fillColor: widget.isEnabled ? Colors.white : Colors.grey.shade300,
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black12),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black12),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
    );
  }
}
