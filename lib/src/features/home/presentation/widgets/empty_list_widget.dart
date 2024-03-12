import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onix_app/src/core/extenstions/empty_box_extention.dart';
import 'package:onix_app/src/core/extenstions/size_extention.dart';
import 'package:onix_app/src/core/utils/app_images.dart';
import 'package:onix_app/src/core/utils/app_strings.dart';
import 'package:onix_app/src/core/utils/app_values.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SvgPicture.asset(AppImages.empatyOrder),
        (context.height * 0.025).emptyBoxHeight,
        Text(AppStrings.noOrdersYet,
            style: TextStyle(color: Colors.black, fontSize: AppSize.s24)),
        (context.height * 0.02).emptyBoxHeight,
        Text(AppStrings.youdoNotHaveAnyOrdersInYourHistory,
            style: TextStyle(
                color: Colors.black,
                fontSize: AppSize.s20,
                fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
