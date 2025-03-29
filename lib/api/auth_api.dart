import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';
import 'package:inscri_ecommerce/model/user/register_model.dart';

import '../model/user/login_model.dart';

class APIService {
  Future<RegisterResponseModel> Register(
      RegisterRequestModel requestModel) async {
    String url = apiUrl + '/auth/register';
    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());

    // Log status code and response body
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load Data Status code: ${response.statusCode}');
    }
  }

  final storage = FlutterSecureStorage(); // Secure storage for token
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = apiUrl + '/auth/login';
    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());

    print('response status:${response.statusCode}');
    print('response body:${response.body}');

    if (response.statusCode == 200) {
      // Convert JSON response
      LoginResponseModel loginResponse =
          LoginResponseModel.fromJson(json.decode(response.body));

      // ✅ Store token securely
      if (loginResponse.token.isNotEmpty) {
        await SecureStorage.saveToken(loginResponse.token);
        print("Token stored successfully!");
      }

      return loginResponse;
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
