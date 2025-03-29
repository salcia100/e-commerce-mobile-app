import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/order.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class OrdersApi {
  Future<List<dynamic>> getOrdersHistory() async {
    try {
      String url = apiUrl + '/orders';

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
        print('✅ this is your orders history !');

        Map<String, dynamic> jsonResponse =jsonDecode(response.body); // Decode the JSON

        List<dynamic> data = jsonResponse["orders"]; // Extract the orders list

        return data.map((json) => Order.fromJson(json)).toList();

      } else {
        throw Exception(" ⚠️ Erreur : ${response.body}");
      }
    } catch (e) {
      throw Exception(" ❌  Erreur : $e ");
    }
  }
}
