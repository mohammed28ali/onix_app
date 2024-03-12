import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onix_app/src/core/api/end_points.dart';
import 'package:onix_app/src/features/authentication/data/model/login_responce_model.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';

class LoginProvider {
  final Dio _dio;

  LoginProvider(this._dio);

  Future<LoginResponse> login(String deliveryNo, String password) async {
    _dio.interceptors.add(
      AwesomeDioInterceptor(
        logRequestTimeout: false,
        logRequestHeaders: false,
        logResponseHeaders: false,
        logger: debugPrint,
      ),
    );
    final response = await _dio.post(
      '${EndPoints.baseUrl}${EndPoints.logIn}',
      data: {
        "Value": {
          "P_LANG_NO": "1",
          "P_DLVRY_NO": deliveryNo,
          "P_PSSWRD": password
        }
      },
    );
    return LoginResponse.fromJson(response.data);
  }
}
