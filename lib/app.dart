import 'package:flutter/material.dart';
import 'package:onix_app/src/config/routes/app_route.dart';
import 'package:onix_app/src/config/theme/app_theme.dart';
import 'package:onix_app/src/core/utils/app_strings.dart';

class OnixApp extends StatelessWidget {
  const OnixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      onGenerateRoute: AppRoutes.onGeneratRoute,
    );
  }
}
