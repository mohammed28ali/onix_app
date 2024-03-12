import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_app/src/core/extenstions/empty_box_extention.dart';
import 'package:onix_app/src/core/extenstions/size_extention.dart';
import 'package:onix_app/src/core/utils/app_colors.dart';
import 'package:onix_app/src/core/utils/app_images.dart';
import 'package:onix_app/src/core/utils/app_strings.dart';
import 'package:onix_app/src/core/utils/app_values.dart';
import 'package:onix_app/src/core/widgets/custom_language_widget.dart';
import 'package:onix_app/src/features/home/presentation/cubit/cubit.dart';
import 'package:onix_app/src/features/home/presentation/widgets/custom_card_widget.dart';
import 'package:onix_app/src/features/home/presentation/widgets/empty_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            _buildTopHeaderContainer(context),
            (context.height * 0.025).emptyBoxHeight,
            _buildTabBar(context),
            Expanded(child: _buildTabBarView(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeaderContainer(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.height * 0.2,
          color: AppColors.redColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildLanguageButton(context),
            ],
          ),
        ),
        Positioned(
          bottom: AppSize.s0,
          right: context.width * 0.18,
          child: Image.asset(
            AppImages.deliveryBoxMan,
            width: context.width * 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageButton(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.halfCircle2,
          width: context.width * 0.4,
        ),
        Positioned(
          left: context.width * 0.25,
          bottom: context.height * 0.08,
          child: Container(
            padding: const EdgeInsets.all(AppSize.s4),
            height: context.height * 0.05,
            width: context.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s12),
              color: AppColors.whiteColor,
            ),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomLanguageWidget();
                  },
                );
              },
              child: Image.asset(
                AppImages.languageIconPng,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      width: context.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s50),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(AppSize.s0_2),
            blurRadius: AppSize.s8,
            spreadRadius: AppSize.s6,
            offset: const Offset(AppSize.s0, AppSize.s6),
          )
        ],
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.whiteColor,
        unselectedLabelColor: AppColors.mainColor,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s50),
          color: AppColors.mainColor,
        ),
        tabs: const [
          Tab(text: AppStrings.news),
          Tab(text: AppStrings.others),
        ],
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return TabBarView(
      children: [
        BlocProvider(
          create: (context) => DeliveryCubit()..getDeliveryData(),
          child: BlocBuilder<DeliveryCubit, DeliveryState>(
            builder: (context, state) {
              final cubit = context.read<DeliveryCubit>();
              if (state == DeliveryState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == DeliveryState.success) {
                final List<Map<String, dynamic>> newDeliveries = [];
                final List<Map<String, dynamic>> otherDeliveries = [];
                for (final item in cubit.deliveryData) {
                  if (item['DLVRY_STATUS_FLG'] == '0') {
                    newDeliveries.add(item);
                  } else {
                    otherDeliveries.add(item);
                  }
                }

                if (newDeliveries.isEmpty && otherDeliveries.isEmpty) {
                  return const Center(
                    child: EmptyListWidget(),
                  );
                }

                return TabBarView(
                  children: [
                    if (newDeliveries.isNotEmpty)
                      ListView.separated(
                        itemCount: newDeliveries.length,
                        separatorBuilder: (context, index) =>
                            (context.height * 0.02).emptyBoxHeight,
                        itemBuilder: (context, index) {
                          final item = newDeliveries[index];
                          return CustomCardWidget(
                            stutusNumber: item['DLVRY_STATUS_FLG'].toString(),
                            price: item['BILL_AMT'].toString(),
                            date: item['BILL_DATE'].toString(),
                            billNumber: item['BILL_NO'].toString(),
                          );
                        },
                      ),
                    if (otherDeliveries.isNotEmpty)
                      ListView.separated(
                        itemCount: otherDeliveries.length,
                        separatorBuilder: (context, index) =>
                            (context.height * 0.02).emptyBoxHeight,
                        itemBuilder: (context, index) {
                          final item = otherDeliveries[index];
                          return CustomCardWidget(
                            stutusNumber: item['DLVRY_STATUS_FLG'].toString(),
                            price: item['BILL_AMT'].toString(),
                            date: item['BILL_DATE'].toString(),
                            billNumber: item['BILL_NO'].toString(),
                          );
                        },
                      ),
                  ],
                );
              } else if (state == DeliveryState.failure) {
                return const Center(
                  child: Text(
                    AppStrings.failedToFetchDeliveryData,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    AppStrings.errorHasOccured,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
