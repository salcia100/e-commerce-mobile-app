import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class ProductApi {
  Future<List<Product>> filterProducts({
  double minPrice = 0,
  double maxPrice = double.infinity,
  List<String> colors = const [],
  int rating = 0,
  String category = '',
  List<String> discounts = const [],
}) async {
  try {
    String url = apiUrl + '/products/filter';

    String? token = await SecureStorage.getToken();
     // Créer les paramètres en query string
    final queryParams = {                                          //####1
      'min_price': minPrice.toString(),
      'max_price': maxPrice.toString(),
      'colors': colors.join(','), // Convertir liste en string
      'rating': rating.toString(),
      'category': category,
      'discounts': discounts.join(','), // Idem
    };
    final uri = Uri.parse('$apiUrl/products/filter').replace(queryParameters: queryParams);    //#####2

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      
    );
    print(' Filter API response: ${response.body}');

    if (response.statusCode == 200) {
       final Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> productList = responseData['products'];
      //print('Premier produit: ${productList[0]}');
      //final products = productList.map((json) => Product.fromJson(json)).toList();
      //print('✅ Produits parsés: ${products.length}');
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Erreur lors du filtrage des produits");
    }
  } catch (e) {
    throw Exception("Erreur : $e");
  }
}




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

  Future<List<Product>> getVendorProducts() async {
    try {
      String url = apiUrl + '/VendorProducts';
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
