import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/Product/Product.dart';

class ApiService {
  Future<List<dynamic>> getProducts() async {
    try {
      String url = apiUrl + '/product/showall';
      final response = await http.get(Uri.parse(url));

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
