import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/wishlist_api.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/home/components/buttomBar.dart';
import 'package:inscri_ecommerce/screens/wishlist/components/appBar.dart';
import 'package:inscri_ecommerce/screens/wishlist/components/wishlist_body.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishListApi apiService = WishListApi();
  List<Product> products = [];
  bool isLoading = true;


   @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

  void fetchWishlist() async {
    try {
      List<Product> data = await WishListApi.GetLikes();
      print("Products loaded: ${data.length}");
      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {
        isLoading = false;
      });
    
  }
  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchWishlist();
  }
  

    /*void fetchWishlist() async {
  try {
    setState(() {
      isLoading = true;  // Affichage de l'animation de chargement
    });

    // Appel à l'API pour récupérer les données
    WishListApi api = WishListApi();
    List<Product> data = await api.GetLikes();  
    if (data != null && data.isNotEmpty) {
      print("Products loaded: ${data.length}");
      setState(() {
        wishlistItems = data;
        isLoading = false;
      });
    } else {
      throw Exception("Aucune donnée reçue ou la liste est vide.");
    }
  } catch (e) {
    print("Erreur : $e");

    // Affichage du message d'erreur sur l'interface utilisateur
    setState(() {
      isLoading = false;
     
    });
  }*/
}

  
  /*final List<Product> wishlistItems = [
    Product(    id: 1, // Ajout de l'ID
    name: "Dress1", 
    price: 52.00, 
    image: 'assets/wishlist/1.jpg',
    description: 'A beautiful linen dress.',
    stock: 10,
    reviews: ["Super produit !", "Très bon achat !"]),

    Product(
    id: 2, // Ajout de l'ID
    name: " Dress2", 
    price: 67.00, 
    image: 'assets/wishlist/2.jpg',
    description: 'A beautiful linen dress.',
    stock: 15,
    reviews: ["Très satisfait !"]
  ),
  Product(
    id: 3, // Ajout de l'ID
    name: "Dress3", 
    price: 59.00, 
    image: 'assets/wishlist/3.jpg',
    description: 'A beautiful linen dress.',
    stock: 5,
    reviews: ["Jolie robe !"]
  ),
  Product(
    id: 4, // Ajout de l'ID
    name: " Dress", 
    price: 85.00, 
    image: 'assets/wishlist/4.jpg',
    description: 'Elegant dress for special occasions.',
    stock: 3,
    reviews: ["Produit de qualité."]
  ),
    Product(
    id: 5, // Ajout de l'ID
    name: " shirt", 
    price: 85.00, 
    image: 'assets/wishlist/11.jpg',
    description: 'Elegant shirt.',
    stock: 3,
    reviews: ["Produit de qualité."]
  ),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: WishlistBody(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
