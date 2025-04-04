import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

  Future<void> addProduct(Map<String, dynamic> dict, XFile? imageFile) async {
    try {
      String url = apiUrl + '/products/add';

      // ✅ Retrieve token
      String? token = await SecureStorage.getToken();

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token';

      // Ajouter les autres données du produit
      request.fields['name'] = dict['name'];
      request.fields['description'] = dict['description'];
      request.fields['price'] = dict['price'];
      request.fields['stock'] = dict['stock'];

      // Vérifier si une image a été sélectionnée
      if (imageFile != null) {
        var file = await http.MultipartFile.fromPath('image', imageFile.path);
        request.files.add(file);
      }

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print('🔍 Réponse API : $responseBody');

      if (response.statusCode == 200) {
        print('✅ Produit ajouté avec succès : $responseBody');
      } else {
        print('⚠️ Erreur lors de l’ajout du produit : $responseBody');
      }
    } catch (e) {
      print('❌ Exception : $e');
    }
  }
}
