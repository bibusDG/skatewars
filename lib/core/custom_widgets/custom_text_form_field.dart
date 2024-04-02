import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(width: 1, color: Colors.orange), //<-- SEE HERE
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 4, color: Colors.white),
            borderRadius: BorderRadius.circular(20.0)),
        // errorText: errorText,
        hintText: hintText,
        // icon: icon,
      ),

    );
  }
}