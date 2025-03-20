import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Cart_api.dart';
import 'package:inscri_ecommerce/constant/constant.dart';

class Cart {
  final String title;
  final String size;
  final String color;
  final double price;
  final int quantity;
  final String imagePath;

  const Cart({
    required this.title,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    // Si l'image est dans l'objet "product"
    String imageUrl = json['product']['image'];

    // Vérifie et remplace l'IP si nécessaire
    if (imageUrl != null && imageUrl.contains("127.0.0.1")) {
      imageUrl = imageUrl.replaceAll("127.0.0.1", IPv4);
    }

    //imageUrl = imageUrl + "?${DateTime.now().second}"; // Append timestamp

    print("image url : " + imageUrl);

    return Cart(
      title: json['product']['name'],
      size: "s",
      color: "red",
      imagePath: imageUrl,
      price: double.parse(json['product']['price'].toString()),
      quantity: int.parse(json['quantity'].toString()),
      //quantity: int.parse(json['product']['stock'].toString()),
    );
  }
}
