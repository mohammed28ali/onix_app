import 'package:flutter/material.dart';
import 'package:onix_app/src/core/extenstions/size_extention.dart';
import 'package:onix_app/src/core/utils/app_values.dart';

class CustomCardColumnDataWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color subTitleColor;

  const CustomCardColumnDataWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.subTitleColor});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: AppSize.s12,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: context.height * 0.015),
        Text(
          subTitle,
          style: TextStyle(
            color: subTitleColor,
            fontSize: AppSize.s16,
          ),
        ),
      ],
    );
  }
}
