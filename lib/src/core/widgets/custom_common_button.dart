// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:onix_app/src/core/utils/app_colors.dart';
import 'package:onix_app/src/core/utils/app_values.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final double padding;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.mainColor,
    this.borderRadius = AppSize.s24,
    this.padding = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: AppSize.s18),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.all(padding),
        ),
      ),
    );
  }
}
