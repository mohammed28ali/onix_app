import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_app/src/core/utils/app_strings.dart';
import 'package:onix_app/src/features/authentication/data/datasource/remote_data_source.dart';
import 'package:onix_app/src/features/authentication/data/repository/repository_impl.dart';
import 'package:onix_app/src/features/authentication/domain/repository/repository.dart';

import 'package:onix_app/src/features/authentication/domain/usecase/usecase.dart';
import 'package:onix_app/src/features/authentication/presentation/cubit/login_cubit.dart';
import 'package:onix_app/src/features/authentication/presentation/screens/logain_screen.dart';
import 'package:onix_app/src/features/home/presentation/cubit/cubit.dart';
import 'package:onix_app/src/features/home/presentation/screens/home_screen.dart';
import 'package:onix_app/src/features/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginScreen = '/loginScreen';
  static const String homeScreen = '/homeScreen';
}

class AppRoutes {
  static Route? onGeneratRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) {
          final Dio dio = Dio();
          return BlocProvider(
            create: (context) => LoginCubit(
              LoginUseCase(LoginRepositoryImp(LoginProvider(dio))),
            ),
            child: const LoginScreen(),
          );
        });
      case Routes.homeScreen:
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (context) => DeliveryCubit()..getDeliveryData(),
                  child: HomeScreen(),
                )));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
