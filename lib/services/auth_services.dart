import 'package:crud_employee/utils/shared_preferences_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const String urlPort = "http://192.168.1.14:42752";

class AuthServices {
  final String apiRegister = "$urlPort/api/auth/register";
  final String apiLogin = "$urlPort/api/auth/login";
  final String apiVerify = "$urlPort/api/auth/otp/verify";
  final String apiResend = "$urlPort/api/auth/otp/resend";

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      var response = await Dio().post(
        apiRegister,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "confirm_password": confirmPassword
        },
      );
      if (kDebugMode) {
        print(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response);
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var response = await Dio().post(
        apiLogin,
        data: {
          "email": email,
          "password": password,
        },
      );

      final token = response.data['data']['token'];
      await SharedPreferencesUtils().addToken(token);

      if (kDebugMode) {
        print(response.data['data']['token']);
        print('login succeed');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception(e.response);
    }
  }

  Future<void> verify({required String email, required String otp}) async {
    try {
      var response = await Dio().post(
        apiVerify,
        data: {"email": email, "otp": otp},
      );
      if (kDebugMode) {
        print(otp);
        print(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response);
    }
  }

  Future<void> resend({required String email}) async {
    try {
      var response = await Dio().post(
        apiResend,
        data: {"email": email},
      );
      if (kDebugMode) {
        print(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response);
    }
  }

  Future<bool> isAuthorized() async {
    final token = await SharedPreferencesUtils().getToken();

    bool hasExpired = JwtDecoder.isExpired(token);

    if (hasExpired) {
      await SharedPreferencesUtils().removeToken();
      return false;
    }
    return true;
  }
}
