import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class ProductApi {
  Future<List<dynamic>> getProducts() async {
    try {
      String url = apiUrl + '/product/showall';

      // ✅ Retrieve token
      String? token = await SecureStorage.getToken();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // ✅ Attach token
          'Content-Type': 'application/json'
        },
      );

      print("API Response: ${response.body}"); // Debugging

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Erreur lors du chargement des produits");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<List<dynamic>> searchProducts(String query) async {
    try {
      String url = apiUrl + '/product/search?q=$query';

      // ✅ Retrieve token
      String? token = await SecureStorage.getToken();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // ✅ Attach token
          'Content-Type': 'application/json'
        },
      );

      print("API Response: ${response.body}"); // Debugging

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Erreur lors du chargement des produits");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }
}
