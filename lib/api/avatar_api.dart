import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'dart:convert';
import 'package:inscri_ecommerce/model/Avatar.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class AvatarApi {
  Future<List<Avatar>> getAvatars() async {
    try {
      String url = apiUrl + '/avatars';
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
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Avatar.fromJson(json)).toList();
      } else {
        throw Exception("Erreur lors du chargement des produits");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }
}
