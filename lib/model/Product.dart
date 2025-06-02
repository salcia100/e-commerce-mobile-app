import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:intl/intl.dart';

class Product {
  String image, name, description;
  int stock, id; 
  double price, rating;
  List<Map<String, dynamic>> reviews;
  final String date; 
  List<Color>? color;
  List<String>? size;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.stock,
    required this.reviews,
    required this.date,
    this.color,
    this.size,
    required this.rating,
  });
 

  factory Product.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] != null
        ? json['image'].replaceAll("127.0.0.1", IPv4)
        : "default_image_url.jpg"; // Valeur par défaut si image est null
    imageUrl = imageUrl + "?${DateTime.now().minute}"; // les images ssont up to date chaque minute

    List<String> parseStringList(dynamic input) {  //pour une liste des tailles
      if (input == null) return [];
      if (input is String) {
        try {
          final decoded = jsonDecode(input);
          if (decoded is List) {
            return List<String>.from(decoded.map((x) => x.toString()));
          } else {
            return [input];
          }
        } catch (e) {
          return [input];
        }
      }
      if (input is List)
        return List<String>.from(input.map((x) => x.toString()));
      return [];
    }

    List<Color> parseColorList(dynamic input) { // pour une liste des couleurs
      if (input == null) return [];
      if (input is String) {
        try {
          final decoded = jsonDecode(input);
          if (decoded is List) {
            return decoded
                .map<Color>((x) => colorFromString(x.toString()))
                .toList();
          } else {
            return [colorFromString(input)];
          }
        } catch (e) {
          return [colorFromString(input)];
        }
      }
      if (input is List)
        return input.map<Color>((x) => colorFromString(x.toString())).toList();
      return [];
    }

    List<Map<String, dynamic>> parseReviews(dynamic input) {   // pour une liste des reviews
    if (input is String) {
      try {
        final decoded = jsonDecode(input);  // Si c'est une chaîne JSON
        if (decoded is List) {
          return List<Map<String, dynamic>>.from(decoded);
        }
      } catch (e) {
        return []; // Si l'input est une chaîne mais pas un JSON valide
      }
    }
    if (input is List) {
      return List<Map<String, dynamic>>.from(input);
    }
    return [];
  }

    print("image url : " + imageUrl);

    return Product(
      id: json['id'],
      name: json['name'] ?? 'No name available',
      image: imageUrl,
      price: double.parse(json['price'].toString()),
      description: json['description'] ?? 'No description available',
      stock: int.parse(json['stock'].toString()),
     reviews: parseReviews(json['reviews']),
      date: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(json['created_at'])),
      color: parseColorList(json['color']),
      size: parseStringList(json['size']),
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Name: $name, Image: $image, Price: $price';
  }
}

Color colorFromString(String colorString) {
  switch (colorString.toLowerCase()) {
    case "red":
      return Colors.red;
    case "blue":
      return Colors.blue;
    case "green":
      return Colors.green;
    case "black":
      return Colors.black;
    case "white":
      return Colors.white;
    case "yellow":
      return Colors.yellow;
    case "orange":
      return Colors.orange;
    case "purple":
      return Colors.purple;
    case "pink":
      return Colors.pink;
    case "grey":
    case "gray":
      return Colors.grey;
    default:
      return Colors.transparent; // Default if unknown color
  }
}
