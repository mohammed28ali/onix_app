import 'package:flutter/material.dart';
import 'package:onix_app/src/core/extenstions/empty_box_extention.dart';
import 'package:onix_app/src/core/extenstions/size_extention.dart';
import 'package:onix_app/src/core/utils/app_colors.dart';
import 'package:onix_app/src/core/utils/app_strings.dart';
import 'package:onix_app/src/core/utils/app_values.dart';
import 'package:onix_app/src/features/home/presentation/widgets/custom_card_column_data.dart';

class CustomCardWidget extends StatelessWidget {
  final String stutusNumber;
  final String price;
  final String date;
  final String billNumber;

  const CustomCardWidget(
      {super.key,
      required this.stutusNumber,
      required this.price,
      required this.date,
      required this.billNumber});

  @override
  Widget build(BuildContext context) {
    double priceDouble = double.parse(price);

    int roundedPrice = priceDouble.round();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSize.s12),
      height: AppSize.s120,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(AppSize.s0_2),
            blurRadius: AppSize.s8,
            spreadRadius: AppSize.s6,
            offset: const Offset(AppSize.s0, AppSize.s6),
          ),
        ],
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              (context.height * 0.015).emptyBoxHeight,
              Row(
                children: [
                  (context.width * 0.04).emptyBoxWidth,
                  Text('#$billNumber',
                      style: const TextStyle(
                          color: AppColors.greyColor, fontSize: AppSize.s16)),
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (context.width * 0.07).emptyBoxWidth,
                    CustomCardColumnDataWidget(
                      title: AppStrings.status,
                      subTitle: _getStatusText(stutusNumber),
                      subTitleColor: _getStatusColor(stutusNumber),
                    ),
                    (context.width * 0.01).emptyBoxWidth,
                    const VerticalDivider(
                      color: AppColors.greyColor,
                      thickness: 1,
                    ),
                    (context.width * 0.01).emptyBoxWidth,
                    CustomCardColumnDataWidget(
                      title: AppStrings.totalPrice,
                      subTitle: '$roundedPrice ${AppStrings.le}',
                      subTitleColor: AppColors.mainColor,
                    ),
                    (context.width * 0.01).emptyBoxWidth,
                    const VerticalDivider(
                      color: AppColors.greyColor,
                      thickness: 1,
                    ),
                    (context.width * 0.01).emptyBoxWidth,
                    CustomCardColumnDataWidget(
                      title: AppStrings.date,
                      subTitle: date,
                      subTitleColor: AppColors.mainColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: _getStatusColor(stutusNumber),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppSize.s16),
                    bottomRight: Radius.circular(AppSize.s16),
                  )),
              width: AppSize.s60,
              height: AppSize.s120,
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.order,
                        style: TextStyle(
                            fontSize: AppSize.s12,
                            fontWeight: FontWeight.normal)),
                    Text(AppStrings.details,
                        style: TextStyle(
                            fontSize: AppSize.s12,
                            fontWeight: FontWeight.normal)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.whiteColor,
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(String statusNumber) {
    switch (statusNumber) {
      case '0':
        return AppStrings.news;
      case '1':
        return AppStrings.delivered;
      case '2':
        return AppStrings.delivering;
      default:
        return AppStrings.returned;
    }
  }

  Color _getStatusColor(String statusNumber) {
    switch (statusNumber) {
      case '0':
        return AppColors.greenColor;
      case '1':
        return AppColors.darkGreyColor;
      case '2':
        return AppColors.mainColor;
      default:
        return AppColors.redColor;
    }
  }
}
