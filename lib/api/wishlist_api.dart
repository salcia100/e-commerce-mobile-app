import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/outils/secure_storage.dart';

class WishListApi {
  static Future<void> addLike(int productId) async {
    try {
      String url = apiUrl + '/likes/add';

      // ✅ Retrieve token
      String? token = await SecureStorage.getToken();

      final response = await http.post(
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
        print('✅ Product added to wishlist !');
      } else {
        print('⚠️ Erreur : ${response.body}');
      }
    } catch (e) {
      print('❌ Exception : $e');
    }
  }

   static Future<List<Product>> GetLikes() async {
  try {
    String url = apiUrl + '/likes';

    // ✅ Retrieve token
    String? token = await SecureStorage.getToken();

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Si l'authentification est requise
      },
    );

    if (response.statusCode == 200) {
      print('✅ voici votre wishlist !');
      List<dynamic> data = jsonDecode(response.body);

      // Accéder à la clé 'product' dans chaque élément pour obtenir le produit
      List<Product> products = data.map((json) {
        return Product.fromJson(json['product']); // Accéder à 'product' dans chaque élément
      }).toList();

      return products;
    } else {
      throw Exception(" ⚠️ Erreur : ${response.body}");
    }
  } catch (e) {
    throw Exception(" ❌  Erreur : $e ");
  }
}


static Future<void> removeLike(int id) async {
    try {
      String url = apiUrl + '/likes/delete/$id';

      // ✅ Retrieve token
      String? token = await SecureStorage.getToken();

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Si l'authentification est requise
        },
      );
      if (response.statusCode == 200) {
        print('✅ product deleted from wishlist successfully !');
      } else {
        print('⚠️ Erreur : ${response.body}');
      }
    } catch (e) {
      print('❌ Exception : $e');
    }
  }

}