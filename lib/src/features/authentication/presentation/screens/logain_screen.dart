import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onix_app/src/config/routes/app_route.dart';
import 'package:onix_app/src/core/extenstions/empty_box_extention.dart';
import 'package:onix_app/src/core/extenstions/navigator_extention.dart';
import 'package:onix_app/src/core/extenstions/size_extention.dart';
import 'package:onix_app/src/core/extenstions/toast_extention.dart';
import 'package:onix_app/src/core/local_data/cache_helper.dart';
import 'package:onix_app/src/core/utils/app_colors.dart';
import 'package:onix_app/src/core/utils/app_images.dart';
import 'package:onix_app/src/core/utils/app_strings.dart';
import 'package:onix_app/src/core/utils/app_values.dart';
import 'package:onix_app/src/core/utils/constants.dart';
import 'package:onix_app/src/core/widgets/custom_common_button.dart';
import 'package:onix_app/src/core/widgets/custom_language_widget.dart';
import 'package:onix_app/src/features/authentication/domain/entity/entity.dart';
import 'package:onix_app/src/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController userIdController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            context.errorSnackBar(
                state.message, AppConstant.errorSnackbarDuration);
          } else if (state is LoginLoaded) {
            context.pushNamed(Routes.homeScreen);
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return _buildLoadingWidget();
          } else {
            return _buildLoginForm(
              context,
              userIdController,
              passwordController,
            );
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoginForm(
    BuildContext context,
    TextEditingController userIdController,
    TextEditingController passwordController,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildLogoSection(context),
          (context.height * 0.15).emptyBoxHeight,
          _buildWelcomeText(),
          _buildText(AppStrings.logBackIntoYourAccount),
          (context.height * 0.035).emptyBoxHeight,
          _buildInputFields(
            context,
            userIdController,
            passwordController,
          ),
          _buildShowMoreText(),
          (context.height * 0.035).emptyBoxHeight,
          _buildLoginButton(context, userIdController, passwordController),
          _buildDeliveryCarImage(context),
        ],
      ),
    );
  }

  Widget _buildLogoSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            (context.height * 0.12).emptyBoxHeight,
            Padding(
              padding: const EdgeInsets.only(left: AppSize.s10),
              child: SvgPicture.asset(
                AppImages.logo,
                height: context.height * 0.1,
                width: context.width * 0.5,
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Image.asset(
              AppImages.halfCirclePng,
              width: context.width * 0.43,
            ),
            Positioned(
              top: context.height * 0.08,
              left: context.width * 0.27,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomLanguageWidget();
                    },
                  );
                },
                child: SvgPicture.asset(
                  AppImages.languageIcon,
                  width: context.width * 0.1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      children: [
        Text(
          AppStrings.welcomeBack,
          style: TextStyle(color: AppColors.mainColor, fontSize: AppSize.s40),
        ),
        SizedBox(height: 5.0),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.mainColor,
        fontSize: AppSize.s18,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildInputFields(
    BuildContext context,
    TextEditingController userIdController,
    TextEditingController passwordController,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
      child: Column(
        children: [
          CommonTextFormField(
            hintText: AppStrings.userID,
            controller: userIdController,
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return AppStrings.pleaseEnterYourUserId;
              }
              return null;
            },
          ),
          (context.height * 0.01).emptyBoxHeight,
          CommonTextFormField(
            hintText: AppStrings.password,
            controller: passwordController,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return AppStrings.pleaseEnterPassword;
              }
              return null;
            },
          ),
          (context.height * 0.015).emptyBoxHeight,
        ],
      ),
    );
  }

  Widget _buildShowMoreText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          AppStrings.showMore,
          style: TextStyle(color: AppColors.mainColor, fontSize: AppSize.s16),
        ),
      ),
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    TextEditingController userIdController,
    TextEditingController passwordController,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
          child: CommonButton(
            text: AppStrings.logIn,
            onPressed: () async {
              final deliveryNo = userIdController.text.trim();
              final password = passwordController.text.trim();
              final user = DeliveryUser(
                deliveryNo: deliveryNo,
                password: password,
                deliveryName: '',
              );
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', true);
              context.read<LoginCubit>().login(user);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryCarImage(BuildContext context) {
    return Column(
      children: [
        (context.height * 0.025).emptyBoxHeight,
        SvgPicture.asset(
          AppImages.deliveryCar,
          height: AppSize.s215,
        ),
        (context.height * 0.025).emptyBoxHeight,
      ],
    );
  }
}
