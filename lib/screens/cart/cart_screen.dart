import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Cart_api.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Cart.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/cart/components/cart_item.dart';
import 'package:inscri_ecommerce/screens/cart/components/cart_resume.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartApi apiService = CartApi();
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      List<dynamic> data = await apiService.GetCart();
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
  }

  // Added method to handle pull-to-refresh
  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: Color(0xFF1D1F22),
            fontSize: 18,
            fontFamily: 'Product Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Cart item = products[index];
                return CartItem(
                  cart: Cart(
                      title: item.title,
                      size: "s",
                      color: "red",
                      price: item.price,
                      quantity: item.quantity,
                      imagePath: item.imagePath),
                  /* title: item.name,
                    size: "S",
                    color: "Beige",
                    price: item.price,
                    quantity: item.quantity,
                    imagePath: item.image,*/
                );
              },
            ),
          ),

          // Liste des articles
          /*CartItem(
              title: "Coat",
              size: "S",
              color: "Beige",
              price: 30.00,
              quantity: 1,
              imagePath: "assets/cart/10.jpg",
            ),
            CartItem(
              title: "Sweater",
              size: "M",
              color: "brown",
              price: 39.99,
              quantity: 1,
              imagePath: "assets/cart/11.jpg",
            ),

            CartItem(
              title: "Dress",
              size: "M",
              color: "Beige",
              price: 39.99,
              quantity: 1,
              imagePath: "assets/cart/12.jpg",
            ),*/

          const SizedBox(height: 20),

          // Résumé du panier
          const CartSummary(subtotal: 110.00),
        ],
      ),
    );
  }
}
