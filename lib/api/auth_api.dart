import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inscri_ecommerce/model/user/User.dart';
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

      //Store token securely
      if (loginResponse.token.isNotEmpty) {
        await SecureStorage.saveToken(loginResponse.token);
        print("Token stored successfully!");
      }

      return loginResponse;
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  Future<User> fetchProfile() async {
    String url = apiUrl + '/auth/profile';
    // Retrieve token
    String? token = await SecureStorage.getToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token', //  Attach token
        'Content-Type': 'application/json'
      },
    );
    print("API Response: ${response.body}"); // Debugging
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return User.fromJson(jsonResponse['data']);
    } else {
      throw Exception("Erreur lors du chargement des produits");
    }
  }

  Future<bool> updateUserAvatar(int avatarId) async {
    try {
      String url = apiUrl + '/auth/profile/update';
      final String? token = await SecureStorage.getToken();

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'avatar_id': avatarId}),
      );

      print("Update Avatar Response: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Erreur de mise à jour: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erreur: $e");
      return false;
    }
  }

  Future<void> sendVerificationRequest() async {
    try {
      String url = apiUrl + '/auth/send-verification-request';
      final String? token = await SecureStorage.getToken();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Request sent successfully.");
      } else {
        print("Failed to send request: ${response.body}");
      }
    } catch (e) {
      print("Error sending request: $e");
    }
  }
}
