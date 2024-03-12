import 'package:flutter/material.dart';
import 'package:onix_app/src/core/utils/app_colors.dart';
import 'package:onix_app/src/core/utils/app_values.dart';

class CommonTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String> validator;

  CommonTextFormField({
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            color: AppColors.hintColor,
            fontWeight: FontWeight.normal,
            fontSize: AppSize.s18),
        filled: true,
        fillColor: AppColors.textFormFiledBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: AppSize.s12),
      ),
    );
  }
}
