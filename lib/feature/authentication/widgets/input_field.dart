import 'package:flutter/material.dart';
import 'package:tastify_food_app/core/themes/app_colors.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  final TextInputAction textInputAction;

  final TextInputType keyboardType;

  const InputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.textInputAction,

    this.obscure = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppColors.black),

      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
