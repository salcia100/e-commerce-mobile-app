import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class FilterApi {
  Future<List<Product>> filterProducts({
    double minPrice = 0,
    double maxPrice = double.infinity,
    List<String> colors = const [],
    int rating = 0,
    int category = 0,
    List<String> discounts = const [],
  }) async {
    try {
      String url = apiUrl + '/products/filter';
      String? token = await SecureStorage.getToken();

      // Build the body dynamically
      final Map<String, dynamic> bodyMap = {
        'min_price': minPrice,
        'max_price': maxPrice,
        'colors': colors,
        'rating': rating,
        'discounts': discounts,
      };

      // Only add category_id if it's not 0
      if (category != 1 && category != 0) {
        bodyMap['category_id'] = category;
      }

      final body = jsonEncode(bodyMap);

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      print('Request body: $body');
      print('🔍 Filter API response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> productList = data['products'];
        return productList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Erreur lors du filtrage des produits");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }
}
