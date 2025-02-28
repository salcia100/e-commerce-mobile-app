import 'package:flutter/material.dart';

class Product {
  String image, name, description;
  int price, stock, id;
  //Color color;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.stock,
    //required this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      name: "dress1",
      image: "assets/images/outfit_1.png",
      price: 20,
      description: "description",
      stock: 5),
  Product(
      id: 2,
      name: "dress2",
      image: "assets/images/outfit_2.png",
      price: 30,
      description: "description",
      stock: 5),
  Product(
      id: 3,
      name: "dress3",
      image: "assets/images/outfit_3.png",
      price: 20,
      description: "description",
      stock: 6),
  Product(
      id: 4,
      name: "dress4",
      image: "assets/images/outfit_4.png",
      price: 10,
      description: "description",
      stock: 20),
  Product(
      id: 5,
      name: "dress5",
      image: "assets/images/outfit_5.png",
      price: 20,
      description: "description",
      stock: 10),
  Product(
      id: 6,
      name: "dress6",
      image: "assets/images/outfit_6.png",
      price: 50,
      description: "description",
      stock: 3),
];
