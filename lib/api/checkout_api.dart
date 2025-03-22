import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/checkout.dart';
import 'package:inscri_ecommerce/outils/secure_storage.dart';
import 'package:inscri_ecommerce/model/order.dart';

class CheckoutApi {
   Future<dynamic> checkout(CheckoutRequestModel requestModel) async {
    try {
      String url = apiUrl + '/checkout';

      // ✅ Retrieve token
      String? token = await SecureStorage.getToken();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Si l'authentification est requise
        },
        body:jsonEncode(requestModel.toJson()),
      );
      if (response.statusCode == 200) {
        print('✅ order created successfully !');
        CheckoutResponseModel checkoutResponse = CheckoutResponseModel.fromJson(json.decode(response.body));
        
        return checkoutResponse.payment_url;  // Retourne l'URL de Stripe
      } else {
        return response.body;
        
        
      }
    } catch (e) {
      print('❌ Exception : $e');
    }
  }
}