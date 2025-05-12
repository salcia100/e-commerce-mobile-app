import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/custom_orders.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';

class CustomOrdersApi {
  Future<List<CustomOrders>> getAvailableCustomOrders() async {
    try {
      String url = apiUrl+'/custom-orders/available';
      String? token = await SecureStorage.getToken();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', 
        },
      );

      if (response.statusCode == 200) {
        print('✅ Custom orders loaded successfully!');

        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> data = jsonResponse["CustomOrders"];

        return data.map((json) => CustomOrders.fromJson(json)).toList();
      } else {
        throw Exception("⚠️ Erreur: ${response.body}");
      }
    } catch (e) {
      throw Exception("❌ Erreur: $e");
    }
  }

   Future<void> addCustomOrder(
      String title,
      String description,
      String budget,
      String quantity,
      String material,
      String color,
      String name,
      String phone,
      String shipping_address,
      int categoryId,
      XFile? image) async {
    try {
      String url = apiUrl + '/custom-orders/add';  
      String? token = await SecureStorage.getToken();

      // Créer la requête multipart pour envoyer les données, y compris l'image
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['title'] = title
        ..fields['description'] = description
        ..fields['budget'] = budget
        ..fields['quantity'] = quantity.toString()
        ..fields['material'] = material
        ..fields['color'] = color
        ..fields['name'] = name
        ..fields['phone'] = phone
        ..fields['shipping_address'] = shipping_address
        ..fields['category_id'] = categoryId.toString();

      if (image != null) {
        // Si l'image est fournie, l'ajouter à la requête
        var imageFile = await http.MultipartFile.fromPath('image', image.path);
        request.files.add(imageFile);
      }

      // Exécuter la requête
      final response = await request.send();

      if (response.statusCode == 200) {
        print('✅ Custom order created successfully!');
        // Vous pouvez aussi traiter la réponse si nécessaire
        var responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        print('Order created: ${jsonResponse['order']}');
      } else {
        print('⚠️ Failed to create custom order: ${response.statusCode}');
        throw Exception('Failed to create custom order');
      }
    } catch (e) {
      print('❌ Error: $e');
      throw Exception("Erreur lors de la création de la commande personnalisée: $e");
    }
  }

  Future<void> acceptCustomOrder(int orderId) async {
    try {
      String url = apiUrl+'/custom-orders/$orderId/accept-order'; 

      String? token = await SecureStorage.getToken();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', 
        },
      );

      if (response.statusCode == 200) {
        print('✅ Custom order accepted successfully!');
        var responseBody = jsonDecode(response.body);
        print('Accepted order: ${responseBody['order']}');
      } else {
        print('⚠️ Failed to accept custom order: ${response.statusCode}');
        throw Exception('Failed to accept custom order');
      }
    } catch (e) {
      print('❌ Error: $e');
      throw Exception("Erreur lors de l'acceptation de la commande personnalisée: $e");
    }
  }

  Future<void> confirmVendor(int orderId) async {
    try {
      String url = apiUrl+'/custom-orders/$orderId/confirm-vendor';  
      String? token = await SecureStorage.getToken();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', 
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("✅ Vendor confirmed successfully!");
        var responseBody = jsonDecode(response.body);
        print('Order confirmed: ${responseBody['order']}');
      } else {
        print("❌ Failed to confirm vendor: ${response.body}");
        throw Exception('Failed to confirm vendor');
      }
    } catch (e) {
      print("❌ Error: $e");
      throw Exception("Erreur lors de la confirmation du vendeur: $e");
    }
  }
  
  Future<void> cancelVendor(int orderId) async {
    try {
      String url = apiUrl+'/custom-orders/$orderId/cancel-vendor';  
      String? token = await SecureStorage.getToken();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', 
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("✅ Vendor canceled successfully!");
        var responseBody = jsonDecode(response.body);
        print('Order canceled: ${responseBody['order']}');
      } else {
        print("❌ Failed to cancel vendor: ${response.body}");
        throw Exception('Failed to cancel vendor');
      }
    } catch (e) {
      print("❌ Error: $e");
      throw Exception("Erreur lors de l'annulation du vendeur: $e");
    }
  }
  //les custom orders du client
  Future<List<CustomOrders>> getclientCustomOrders() async {
    try {
      String url = apiUrl+'/custom-orders/my-custom-orders';
      String? token = await SecureStorage.getToken();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', 
        },
      );

      if (response.statusCode == 200) {
        print('✅ My Custom orders loaded successfully!');

        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> data = jsonResponse["MycustomOrders"];

        return data.map((json) => CustomOrders.fromJson(json)).toList();
      } else {
        throw Exception("⚠️ Erreur: ${response.body}");
      }
    } catch (e) {
      throw Exception("❌ Erreur: $e");
    }
  }
  //les custom orders accepted by vendor
  Future<List<CustomOrders>> getVendorCustomSales() async {
    try {
      String url = apiUrl+'/custom-orders/my-custom-sales';
      String? token = await SecureStorage.getToken();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', 
        },
      );

      if (response.statusCode == 200) {
        print('✅ My Custom Sales loaded successfully!');

        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> data = jsonResponse["MySales"];

        return data.map((json) => CustomOrders.fromJson(json)).toList();
      } else {
        throw Exception("⚠️ Erreur: ${response.body}");
      }
    } catch (e) {
      throw Exception("❌ Erreur: $e");
    }
  }
}
