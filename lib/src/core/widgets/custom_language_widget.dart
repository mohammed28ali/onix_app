import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onix_app/src/core/extenstions/empty_box_extention.dart';
import 'package:onix_app/src/core/extenstions/size_extention.dart';
import 'package:onix_app/src/core/utils/app_colors.dart';
import 'package:onix_app/src/core/utils/app_images.dart';
import 'package:onix_app/src/core/utils/app_strings.dart';
import 'package:onix_app/src/core/utils/app_values.dart';
import 'package:onix_app/src/core/widgets/custom_common_button.dart';

class CustomLanguageWidget extends StatefulWidget {
  const CustomLanguageWidget({super.key});

  @override
  _CustomLanguageWidgetState createState() => _CustomLanguageWidgetState();
}

class _CustomLanguageWidgetState extends State<CustomLanguageWidget> {
  int selectedContainer = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: const Text(
        AppStrings.chooseLanguage,
        style: TextStyle(
            fontSize: AppSize.s18,
            color: AppColors.mainColor,
            fontWeight: FontWeight.bold),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedContainer = 1;
              });
            },
            child: Container(
              width: context.width * 0.3,
              height: context.height * 0.07,
              decoration: BoxDecoration(
                color: selectedContainer == 1
                    ? AppColors.lightGreen
                    : Colors.white,
                borderRadius: BorderRadius.circular(AppSize.s16),
                border: Border.all(
                  color: selectedContainer == 1
                      ? AppColors.selectedBorderGreen
                      : AppColors.unSelectedBorderGreen,
                  width: 1.0,
                ),
              ),
              child: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (context.width * 0.025).emptyBoxWidth,
                  Image.asset(
                    AppImages.arabicFlagPng,
                    width: context.width * 0.08,
                    height: context.height * 0.08,
                  ),
                  (context.width * 0.025).emptyBoxWidth,
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.arabicAr,
                        style: TextStyle(
                            color: Colors.black, fontSize: AppSize.s12),
                      ),
                      Text(
                        AppStrings.arabic,
                        style: TextStyle(
                            color: Colors.black, fontSize: AppSize.s10),
                      ),
                    ],
                  ),
                ],
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedContainer = 2;
              });
            },
            child: Container(
              width: context.width * 0.3,
              height: context.height * 0.07,
              decoration: BoxDecoration(
                color: selectedContainer == 2
                    ? AppColors.lightGreen
                    : Colors.white,
                borderRadius: BorderRadius.circular(AppSize.s16),
                border: Border.all(
                  color: selectedContainer == 2
                      ? AppColors.selectedBorderGreen
                      : AppColors.unSelectedBorderGreen,
                  width: 1.0,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (context.width * 0.025).emptyBoxWidth,
                  Image.asset(
                    AppImages.englishFlagPng,
                    width: context.width * 0.08,
                    height: context.height * 0.08,
                  ),
                  (context.width * 0.025).emptyBoxWidth,
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.english,
                        style: TextStyle(
                            color: Colors.black, fontSize: AppSize.s12),
                      ),
                      Text(
                        AppStrings.english,
                        style: TextStyle(
                            color: Colors.black, fontSize: AppSize.s10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        CommonButton(text: AppStrings.apply, onPressed: () {}),
      ],
    );
  }
}
