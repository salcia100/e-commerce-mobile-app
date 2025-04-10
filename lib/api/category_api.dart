import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class CategoryApi {
  //afficher tous les categories
  Future<List<Category>> getCategories() async {
    try {
      String url = apiUrl + '/categories/show';
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
        var jsonResponse = jsonDecode(response.body);

        // Access the categories list from the response
        List<dynamic> data = jsonResponse['categories'];

        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception("Erreur lors du chargement des categories");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  //afficher les produits d'une categorie
  Future<List<dynamic>> getCategoryProducts(int id) async {
    try {
      String url = apiUrl + '/categories/${id}/products';
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
        var jsonResponse = jsonDecode(response.body);

        // Access the categories list from the response
        List<dynamic> data = jsonResponse['products'];

        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Erreur lors du chargement des produits");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }
}
