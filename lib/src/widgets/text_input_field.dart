import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool ispassword;
  final VoidCallback onpress;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.onpress,
    this.ispassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: IconButton(
          onPressed: onpress,
          icon: const Icon(
            Icons.arrow_forward,
          ),
        ),
      ),
      keyboardType: textInputType,
      obscureText: ispassword,
    );
  }
}
