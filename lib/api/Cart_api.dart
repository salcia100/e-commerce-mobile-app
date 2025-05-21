import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';
import 'package:inscri_ecommerce/model/Cart.dart';

class CartApi {
  static Future<void> addProductToCart(int productId, int quantity) async {
    try {
      String url = apiUrl + '/cart/add';

      // Retrieve token
      String? token = await SecureStorage.getToken();

   Map<String, String> headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }


    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'product_id': productId,
        'quantity': quantity,
      }),
    );
      if (response.statusCode == 200) {
        print('✅ Produit ajouté au panier avec succès !');
      } else {
        print('❌ Erreur : ${response.body}');
      }
    } catch (e) {
      print('❌ Exception : $e');
    }
  }

  Future<List<dynamic>> GetCart() async {
    try {
      String url = apiUrl + '/cart';

      //  Retrieve token
      String? token = await SecureStorage.getToken();

      Map<String, String> headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

  
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

      if (response.statusCode == 200) {
        print('✅ voici votre panier !');
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Cart.fromJson(json)).toList();
      } else {
        throw Exception(" ❌ Erreur : ${response.body}");
      }
    } catch (e) {
      throw Exception(" ❌  Erreur : $e ");
    }
  }

  static Future<void> RemoveProductFomCart(int id) async {
    try {
      String url = apiUrl + '/cart/remove/$id';

      //  Retrieve token
      String? token = await SecureStorage.getToken();

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Si l'authentification est requise
        },
      );
      if (response.statusCode == 200) {
        print('✅ product deleted from cart successfully !');
      } else {
        print('❌ Erreur : ${response.body}');
      }
    } catch (e) {
      print('❌ Exception : $e');
    }
  }

  //updatequantity
  static Future<void> incrementquantity(int productId) async {
    try {
      String url = apiUrl + '/cart/incrementquantity/$productId';

      // Retrieve token
      String? token = await SecureStorage.getToken();

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Si l'authentification est requise
        },
        body: jsonEncode({
          'product_id': productId,
        }),
      );
      if (response.statusCode == 200) {
        print('✅ Cart updated');
      } else {
        print('❌ Erreur : ${response.body}');
      }
    } catch (e) {
      print('❌ Exception : $e');
    }
  }

   static Future<void> decrementquantity(int productId) async {
    try {
      String url = apiUrl + '/cart/decrementquantity/$productId';

      // Retrieve token
      String? token = await SecureStorage.getToken();

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Si l'authentification est requise
        },
        body: jsonEncode({
          'product_id': productId,
        }),
      );
      if (response.statusCode == 200) {
        print('✅ Cart updated');
      } else {
        print('❌ Erreur : ${response.body}');
      }
    } catch (e) {
      print('❌ Exception : $e');
    }
  }
}
