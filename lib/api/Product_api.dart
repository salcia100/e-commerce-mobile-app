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
      String? token = await SecureStorage.getToken();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', 
          'Content-Type': 'application/json'
        },
      );
      print("API Response: ${response.body}");
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
      String? token = await SecureStorage.getToken();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', 
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

  Future<List<Product>> getVendorProducts() async {
    try {
      String url = apiUrl + '/VendorProducts';
      String? token = await SecureStorage.getToken();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', 
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
      String? token = await SecureStorage.getToken();
      //print('📦 Token utilisé : $token');
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token';
      //..headers['Accept'] = 'application/json';
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

  Future<void> updateProduct(
      int productId, Product updatedData, XFile? imageFile) async {
    try {
      String url = apiUrl + '/product/update/$productId'; // URL d’update
      String? token = await SecureStorage.getToken();
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token';
      request.fields['_method'] = 'PUT'; // Tell Laravel to treat it as a PUT

      // Ajouter les champs modifiés
      request.fields['name'] = updatedData.name;
      request.fields['description'] = updatedData.description;
      request.fields['price'] = updatedData.price.toString();
      request.fields['stock'] = updatedData.stock.toString();
      // Vérifier si une image a été sélectionnée
      if (imageFile != null) {
        var file = await http.MultipartFile.fromPath('image', imageFile.path);
        request.files.add(file);
      }
      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print('🔍 Réponse API update : $responseBody');

      if (response.statusCode == 200) {
        print('✅ Produit mis à jour avec succès !');
      } else {
        print('⚠️ Erreur lors de la mise à jour : $responseBody');
      }
    } catch (e) {
      print('❌ Exception update : $e');
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      String url = apiUrl + '/product/delete/$productId'; // URL delete
      String? token = await SecureStorage.getToken();

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print("🔍 Réponse API delete : ${response.body}");
      if (response.statusCode == 200) {
        print("✅ Produit supprimé avec succès !");
      } else {
        print("⚠️ Erreur lors de la suppression : ${response.body}");
      }
    } catch (e) {
      print("❌ Exception delete : $e");
    }
  }
}
