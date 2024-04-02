import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
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