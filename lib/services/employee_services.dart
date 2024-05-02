import 'package:crud_employee/models/employees_models.dart';
import 'package:crud_employee/utils/shared_preferences_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String urlPort = "http://192.168.1.14:42752";

class EmployeeServices {
  final String apiUrl = "$urlPort/api/employees";

  Future<EmployeeModels> getEmployees() async {
    final token = await SharedPreferencesUtils().getToken();
    try {
      var response = await Dio().get(
        apiUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (kDebugMode) {
        print(response.data['data']);
      }
      return EmployeeModels.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response);
    }
  }

  Future<dynamic> getEmployeeById({required String id}) async {
    final token = await SharedPreferencesUtils().getToken();
    final apiGet = '$apiUrl/$id';
    try {
      var response = await Dio().get(
        apiGet,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (kDebugMode) {
        print(response.data);
      }
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response);
    }
  }

  Future<EmployeeModels> createEmployee({required FormData formData}) async {
    final token = await SharedPreferencesUtils().getToken();

    try {
      var response = await Dio().post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      return EmployeeModels.fromJson(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.response != null) {
        e.response!.data;
      } else {
        e;
      }
      throw Exception(e.message);
    }
  }

  Future<EmployeeModels> updateEmployee(
      {required FormData formData, required String id}) async {
    final token = await SharedPreferencesUtils().getToken();
    final apiPut = '$apiUrl/$id';

    try {
      var response = await Dio().put(
        apiPut,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      return EmployeeModels.fromJson(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.response != null) {
        e.response!.data;
      } else {
        e;
      }
      throw Exception(e.message);
    }
  }

  Future<dynamic> deleteEmployee({required String id}) async {
    final token = await SharedPreferencesUtils().getToken();
    final apiDelete = '$apiUrl/$id';

    try {
      final response = await Dio().delete(
        apiDelete,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      return EmployeeModels.fromJson(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.response != null) {
        e.response!.data;
      } else {
        e;
      }
      throw Exception(e.message);
    }
  }
}
