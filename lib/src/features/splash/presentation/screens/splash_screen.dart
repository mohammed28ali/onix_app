import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onix_app/src/config/routes/app_route.dart';
import 'package:onix_app/src/core/extenstions/empty_box_extention.dart';
import 'package:onix_app/src/core/extenstions/navigator_extention.dart';
import 'package:onix_app/src/core/extenstions/size_extention.dart';
import 'package:onix_app/src/core/utils/app_colors.dart';
import 'package:onix_app/src/core/utils/app_images.dart';
import 'package:onix_app/src/core/utils/app_values.dart';
import 'package:onix_app/src/features/splash/data/repository/repository_impl.dart';
import 'package:onix_app/src/features/splash/domain/usecase/usecase.dart';
import 'package:onix_app/src/features/splash/presentation/cubit/cubit.dart';
import 'package:onix_app/src/features/splash/presentation/cubit/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        LoadDataUseCase(
          SplashScreenRepositoryImpl(),
        ),
      )..loadData(),
      child: Scaffold(
        backgroundColor: AppColors.splashBackGroundColor,
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) async {
            if (state == SplashState.loaded) {
              bool loggedIn = await isLoggedIn();
              if (loggedIn) {
                context.pushAndRemoveNamed(Routes.homeScreen);
              } else {
                context.pushAndRemoveNamed(Routes.loginScreen);
              }
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppImages.logo),
                (context.height * 0.15).emptyBoxHeight,
                Stack(
                  children: [
                    SvgPicture.asset(AppImages.splashBuildingsBackground),
                    Positioned(
                      top: AppSize.s60,
                      left: AppSize.s50,
                      child: Center(
                        child: SvgPicture.asset(AppImages.deliveryMan),
                      ),
                    ),
                    (context.height * 0.4).emptyBoxHeight,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
